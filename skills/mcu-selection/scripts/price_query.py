#!/usr/bin/env python3
"""
MCU Price Query Script
Queries prices from LCSC and HQChip for given part numbers.

Usage:
    python price_query.py <part_number> [part_number2] ...
    python price_query.py --file parts.txt
    python price_query.py --all  # Query all parts in database
"""

import argparse
import json
import sys
from typing import Optional

try:
    import requests
    HAS_REQUESTS = True
except ImportError:
    HAS_REQUESTS = False


# LCSC API Configuration
LCSC_API_URL = "https://wmsc.lcsc.com/wmsc/product/detail"
LCSC_SEARCH_URL = "https://www.lcsc.com/search"

# HQChip API Configuration
HQCHIP_API_URL = "https://www.hqchip.com/ajax/GetPrice"


def query_lcsc_price(part_number: str) -> Optional[dict]:
    """
    Query price from LCSC.
    
    Args:
        part_number: MCU part number (e.g., "GD32F103C8T6")
    
    Returns:
        Dictionary with price info or None if failed
    """
    if not HAS_REQUESTS:
        print("Warning: requests library not available, returning mock data")
        return get_mock_price(part_number, "LCSC")
    
    try:
        # LCSC product detail URL pattern
        # Note: LCSC uses product codes, so we need to search first
        search_url = f"{LCSC_SEARCH_URL}?searchKeyword={part_number}"
        
        headers = {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
            "Accept": "application/json, text/plain, */*",
        }
        
        # Try the LCSC API endpoint
        response = requests.get(
            f"https://api.lcsc.com/v1/products/search",
            params={"keywords": part_number, "pageSize": 10},
            headers=headers,
            timeout=10
        )
        
        if response.status_code == 200:
            data = response.json()
            products = data.get("data", {}).get("products", [])
            if products:
                product = products[0]
                return {
                    "vendor": "LCSC",
                    "part_number": part_number,
                    "price": product.get("price", "N/A"),
                    "stock": product.get("stock", 0),
                    "currency": "CNY",
                    "url": f"https://www.lcsc.com/products/{part_number}.html",
                    "status": "In Stock" if product.get("stock", 0) > 0 else "Out of Stock"
                }
        
        return None
    except Exception as e:
        print(f"Error querying LCSC for {part_number}: {e}")
        return None


def query_hqchip_price(part_number: str) -> Optional[dict]:
    """
    Query price from HQChip.
    
    Args:
        part_number: MCU part number (e.g., "GD32F103C8T6")
    
    Returns:
        Dictionary with price info or None if failed
    """
    if not HAS_REQUESTS:
        print("Warning: requests library not available, returning mock data")
        return get_mock_price(part_number, "HQChip")
    
    try:
        headers = {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
            "Accept": "application/json, text/plain, */*",
            "Referer": "https://www.hqchip.com/",
        }
        
        # HQChip uses different part number format sometimes
        # Try direct price API
        params = {"partNumber": part_number}
        response = requests.get(
            HQCHIP_API_URL,
            params=params,
            headers=headers,
            timeout=10
        )
        
        if response.status_code == 200:
            data = response.json()
            if data.get("code") == 0:
                price_info = data.get("data", {})
                return {
                    "vendor": "HQChip",
                    "part_number": part_number,
                    "price": price_info.get("price", "N/A"),
                    "stock": price_info.get("stock", 0),
                    "currency": "CNY",
                    "url": f"https://www.hqchip.com/search?keyword={part_number}",
                    "status": "In Stock" if price_info.get("stock", 0) > 0 else "Out of Stock"
                }
        
        return None
    except Exception as e:
        print(f"Error querying HQChip for {part_number}: {e}")
        return None


def get_mock_price(part_number: str, vendor: str) -> dict:
    """
    Generate mock price data for testing.
    
    Args:
        part_number: MCU part number
        vendor: Vendor name (LCSC or HQChip)
    
    Returns:
        Mock price data
    """
    import hashlib
    
    # Generate consistent mock prices based on part number hash
    hash_val = int(hashlib.md5(part_number.encode()).hexdigest()[:8], 16)
    
    base_prices = {
        "GD32F103C8T6": 4.5,
        "CH32V103RBT6": 3.8,
        "STM32F103C8T6": 8.5,
        "FM33LG0xxN": 6.2,
    }
    
    base = base_prices.get(part_number, 5.0 + (hash_val % 50) / 10)
    variance = ((hash_val % 20) - 10) / 10
    
    if vendor == "HQChip":
        base *= 0.95  # HQChip typically slightly cheaper
    
    return {
        "vendor": vendor,
        "part_number": part_number,
        "price": round(base + variance, 2),
        "stock": 1000 + (hash_val % 50000),
        "currency": "CNY",
        "url": f"https://www.{vendor.lower().replace(' ', '')}.com/product/{part_number}",
        "status": "In Stock",
        "mock": True
    }


def query_all_vendors(part_number: str) -> dict:
    """
    Query price from all vendors.
    
    Args:
        part_number: MCU part number
    
    Returns:
        Dictionary with all vendor prices
    """
    results = {
        "part_number": part_number,
        "prices": [],
        "best_price": None
    }
    
    # Query LCSC
    lcsc_price = query_lcsc_price(part_number)
    if lcsc_price:
        results["prices"].append(lcsc_price)
    
    # Query HQChip
    hqchip_price = query_hqchip_price(part_number)
    if hqchip_price:
        results["prices"].append(hqchip_price)
    
    # Find best price
    valid_prices = [p for p in results["prices"] if isinstance(p.get("price"), (int, float))]
    if valid_prices:
        results["best_price"] = min(valid_prices, key=lambda x: x["price"])
    
    return results


def print_price_table(results: dict):
    """Print price results in formatted table."""
    print(f"\n{'='*60}")
    print(f"Price Query Results: {results['part_number']}")
    print(f"{'='*60}")
    
    if not results["prices"]:
        print("No price data available from vendors.")
        return
    
    print(f"\n{'Vendor':<12} {'Price (CNY)':<15} {'Stock':<12} {'Status':<15}")
    print("-" * 60)
    
    for price_info in results["prices"]:
        price = price_info.get("price", "N/A")
        if isinstance(price, (int, float)):
            price_str = f"¥{price:.2f}"
        else:
            price_str = str(price)
        
        print(f"{price_info['vendor']:<12} {price_str:<15} {price_info.get('stock', 'N/A'):<12} {price_info.get('status', 'N/A'):<15}")
    
    if results["best_price"]:
        print(f"\nBest Price: {results['best_price']['vendor']} at ¥{results['best_price']['price']:.2f}")
    
    print()


def load_database(db_path: str = None) -> dict:
    """Load MCU database."""
    if db_path is None:
        import os
        script_dir = os.path.dirname(os.path.abspath(__file__))
        db_path = os.path.join(os.path.dirname(script_dir), "references", "mcu_database.json")
    
    try:
        with open(db_path, 'r', encoding='utf-8') as f:
            return json.load(f)
    except Exception as e:
        print(f"Warning: Could not load database: {e}")
        return {"manufacturers": {}}


def query_all_parts():
    """Query prices for all parts in database."""
    db = load_database()
    all_parts = []
    
    for mfg_key, mfg_data in db.get("manufacturers", {}).items():
        for model in mfg_data.get("models", []):
            all_parts.append(model["part_number"])
    
    print(f"Querying prices for {len(all_parts)} parts...")
    
    results = []
    for i, part in enumerate(all_parts):
        print(f"[{i+1}/{len(all_parts)}] Querying {part}...", end="\r")
        result = query_all_vendors(part)
        if result["prices"]:
            results.append(result)
    
    print(f"\n\nRetrieved prices for {len(results)} parts.")
    
    # Save results
    output_file = "mcu_prices.json"
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(results, f, indent=2, ensure_ascii=False)
    print(f"Results saved to {output_file}")
    
    return results


def main():
    parser = argparse.ArgumentParser(
        description="MCU Price Query Tool - Query prices from LCSC and HQChip",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
    python price_query.py GD32F103C8T6
    python price_query.py CH32V103R8T6 STM32F103C8T6
    python price_query.py --file parts.txt
    python price_query.py --all
        """
    )
    
    parser.add_argument(
        "part_numbers",
        nargs="*",
        help="Part numbers to query"
    )
    parser.add_argument(
        "-f", "--file",
        help="File containing part numbers (one per line)",
        metavar="FILE"
    )
    parser.add_argument(
        "-a", "--all",
        action="store_true",
        help="Query all parts in database"
    )
    parser.add_argument(
        "-o", "--output",
        help="Output JSON file for results",
        metavar="FILE"
    )
    parser.add_argument(
        "--mock",
        action="store_true",
        help="Use mock data instead of real API calls"
    )
    
    args = parser.parse_args()
    
    if args.all:
        results = query_all_parts()
    elif args.file:
        with open(args.file, 'r') as f:
            parts = [line.strip() for line in f if line.strip()]
        results = []
        for part in parts:
            result = query_all_vendors(part)
            results.append(result)
            print_price_table(result)
    elif args.part_numbers:
        results = []
        for part in args.part_numbers:
            result = query_all_vendors(part)
            results.append(result)
            print_price_table(result)
    else:
        parser.print_help()
        sys.exit(1)
    
    if args.output and results:
        with open(args.output, 'w', encoding='utf-8') as f:
            json.dump(results, f, indent=2, ensure_ascii=False)
        print(f"Results saved to {args.output}")


if __name__ == "__main__":
    main()
