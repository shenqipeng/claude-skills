---
name: mcu-selection
description: "MCU selection from 284+ database(SiLabs,GigaDevice,Fudan Micro,WCH,XHSC). Chain: upstream←product-requirements(hw needs),brainstorming(design phase); downstream→brainstorming(MCU constrains design),writing-plans(toolchain/peripheral refs). Trigger: MCU,microcontroller,firmware,embedded,GD32,STM32,EFR32,CH32. Skip if: MCU already chosen,software-only"
---

# MCU Selection Skill

## Overview
This skill helps select optimal microcontrollers from a comprehensive database of 284+ entry-level and mainstream models based on project requirements.

## Database Coverage (Complete v4.0)

| Manufacturer | Count | Series | Filter Criteria |
|-------------|-------|--------|-----------------|
| **Silicon Labs** | 71 | EFR32BG (Blue Gecko BLE), EFM32PG (Pearl Gecko) | BLE 5.x/6.0, AI/ML, LCD, Secure Vault |
| **GigaDevice** | 85 | GD32F10x, GD32F1x0, GD32F3x0, GD32E23x, GD32VF103, GD32C2x1, GD32E232, GD32E502, GD32E1x3, GD32C1x3, GD32L23x | Entry-level & mainstream (F4xx/F30x/F2xx/F5xx/H7xx high-perf excluded) |
| **Fudan Micro** | 25 | FM33LC0xx, FM33LG0xx, FM33LE0xx, FM33A0xx, FM33FR0xx, FM33G0xx, etc. | All low-power series |
| **WCH** | 40 | CH32V003/103/203/208/303/305/307/317/407, CH32X035, CH32L103, CH56x/57x/58x/59x, CH5xx BLE | All RISC-V series |
| **XHSC** | 18 | HC32F0xx, HC32F1xx, HC32L0xx/1xx/2xx, HC32M1xx/3xx, HC32A0xx | Entry-level (F4A0/F460/F334 high-perf excluded) |
| **TOTAL** | **284+** | | |

**Note**: This database focuses on entry-level and mainstream MCUs. High-performance series (Cortex-M4F @ >120MHz, large Flash, advanced features) have been excluded to provide practical options for cost-sensitive applications.

## Supported Manufacturers

## Workflow

### Step 1: Parse Requirements
Extract from user request:
- Core requirements (ADC, UART, I2C, SPI, PWM, Timer, USB, CAN)
- Pin count range
- Flash/RAM size requirements
- Package type preferences
- Temperature range needs
- Special features (LCD, AES, RTC, CRC)

### Step 2: Match Against Database
Filter candidates by:
1. **Manufacturer preference** (if specified)
2. **Core type** (ARM Cortex-M, 8051, RISC-V)
3. **Required peripherals** (all must be present)
4. **Flash size** (minimum threshold)
5. **Pin count** (must meet minimum)
6. **Package availability**

### Step 3: Rank Candidates
Priority scoring:
1. Manufacturer match (if specified): +10 points
2. Peripheral count match: +5 per matched peripheral
3. Flash size efficiency (closest to requirement): +3 points
4. RAM availability (if specified): +2 points
5. Package preference match: +2 points

### Step 4: Generate Output
Provide top 3 candidates with:
- Part number
- Key specs
- Price estimate (via price_query.py)
- Recommendation reasoning

## Output Format Template

```
# MCU Selection Results

## Requirements Summary
- [List extracted requirements]

## Top Candidates

### 1. [Part Number] (Recommended)
| Spec | Value |
|------|-------|
| Manufacturer | [MFG] |
| Core | [Core type] |
| Flash | [Size] |
| RAM | [Size] |
| Pins | [Count] |
| Package | [Type] |
| Peripherals | [List] |
| Price (LCSC) | [CNY] |
| Price (HQChip) | [CNY] |

**Why recommended**: [Reasoning]

### 2. [Part Number]
[Same format]

### 3. [Part Number]
[Same format]

## Price Check
Run: `python scripts/price_query.py [part_numbers]`
```

## Database Coverage

The `references/mcu_database.json` contains **284 models** across all supported manufacturers:
- Silicon Labs: 71 models (EFR32BG21/22/24/27, EFM32PG22/23/26/28)
- GigaDevice: 85 models (GD32F10x, GD32F1x0)
- Fudan Micro: 25 models (FM33LC0xx, FM33LG0xx, FM33LE0xx)
- WCH: 40 models (CH32V00x/103/203/208/305/307, CH57x/58x/59x)
- XHSC: 18 models (HC32F0/F1/L/M)

Each entry includes:
- Part number
- Manufacturer
- Core architecture
- Flash size
- RAM size
- Pin count
- Package types
- Peripherals (ADC, UART, I2C, SPI, PWM, Timer, USB, CAN, etc.)
- Temperature range
- Voltage range

## Special Cases

### No Exact Match
If no MCU meets all requirements:
1. Relax non-critical requirements (e.g., package)
2. Suggest closest matches with workarounds
3. Recommend next-higher tier options

### Multiple Manufacturers
If user doesn't specify manufacturer:
- Present top candidates from each manufacturer
- Compare price/availability tradeoffs

### Obsolete/End-of-Life
Mark any candidates that are EOL or NRND:
- Warn user
- Suggest direct replacements

### Budget Constraints
If price is a constraint:
- Query live prices via price_query.py
- Compare LCSC vs HQChip pricing
- Suggest alternative models with similar specs

### Package Limitations
If specific package needed (e.g., QFN32):
- Filter database by package type
- Note any pin-count adjustments needed

## Usage

```
@skill mcu-selection
I need an MCU for battery monitoring with:
- At least 2 UART channels
- 12-bit ADC with 8+ channels
- 64KB+ Flash
- QFP32 or QFN32 package
- Operating temp -20 to 60°C
```

## Files
- `references/mcu_database.json`: Full MCU database (284 models)
- `scripts/price_query.py`: Price query tool for LCSC/HQChip
- `evals/evals.json`: Test cases for skill evaluation

## Workflow Linkage

**Position in superpowers workflow:** Parallel branch during brainstorming, or downstream of product-requirements.

**Upstream (feeds into this skill):**
- `product-requirements` — PRD may specify hardware requirements (peripherals, pin count, Flash/RAM, package). Use these as input for MCU selection.
- `brainstorming` — During design exploration (Phase 2: scope), if the project involves embedded/hardware, invoke this skill to constrain the design with a concrete MCU choice.

**Downstream (receives MCU selection result):**
- `brainstorming` — MCU selection result (peripheral limits, memory constraints, package options) feeds back into the design, constraining software architecture and feature scope.
- `writing-plans` — Plan steps must reference the selected MCU's toolchain, peripheral configuration, and memory layout.

**Decision rule:** If the word "MCU", "microcontroller", "firmware", "embedded", or specific chip names appear in the task, invoke this skill during brainstorming. The selected MCU becomes a hard constraint for all downstream planning and execution.
