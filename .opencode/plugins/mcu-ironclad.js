/**
 * MCU Ironclad plugin for OpenCode.ai
 *
 * Works with the mcu-ironclad skill collection repo.
 * - Injects bootstrap context via system prompt transform.
 * - Auto-registers skills directory via config hook.
 * - Validates skill graph integrity at startup.
 *
 * Compatible with both:
 *   1. The obra/superpowers upstream (14 core skills)
 *   2. The mcu-ironclad repo (25 skills: 14 core + 11 independent in skills/)
 */

import path from 'path';
import fs from 'fs';
import os from 'os';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// Simple frontmatter extraction (avoid dependency on skills-core for bootstrap)
const extractAndStripFrontmatter = (content) => {
  const match = content.match(/^---\n([\s\S]*?)\n---\n([\s\S]*)$/);
  if (!match) return { frontmatter: {}, content };

  const frontmatterStr = match[1];
  const body = match[2];
  const frontmatter = {};

  for (const line of frontmatterStr.split('\n')) {
    const colonIdx = line.indexOf(':');
    if (colonIdx > 0) {
      const key = line.slice(0, colonIdx).trim();
      const value = line.slice(colonIdx + 1).trim().replace(/^["']|["']$/g, '');
      frontmatter[key] = value;
    }
  }

  return { frontmatter, content: body };
};

// Normalize a path: trim whitespace, expand ~, resolve to absolute
const normalizePath = (p, homeDir) => {
  if (!p || typeof p !== 'string') return null;
  let normalized = p.trim();
  if (!normalized) return null;
  if (normalized.startsWith('~/')) {
    normalized = path.join(homeDir, normalized.slice(2));
  } else if (normalized === '~') {
    normalized = homeDir;
  }
  return path.resolve(normalized);
};

// Core workflow skills (originally from obra/superpowers)
const CORE_SKILLS = [
  'brainstorming',
  'dispatching-parallel-agents',
  'executing-plans',
  'finishing-a-development-branch',
  'receiving-code-review',
  'requesting-code-review',
  'subagent-driven-development',
  'systematic-debugging',
  'test-driven-development',
  'using-git-worktrees',
  'using-superpowers',
  'verification-before-completion',
  'writing-plans',
  'writing-skills',
];

// Independent skills (from other sources, expected in the same skills/ directory)
const INDEPENDENT_SKILLS = [
  'careful',
  'find-skills',
  'freeze',
  'gateguard',
  'karpathy-guidelines',
  'mcu-selection',
  'product-requirements',
  'skill-creator',
  'skill-install',
  'sparv',
  'test-cases',
];

const ALL_KNOWN_SKILLS = [...CORE_SKILLS, ...INDEPENDENT_SKILLS];

// Validate that all expected skills exist on disk.
// Returns { missing: string[], extra: string[] }
const validateSkillGraph = (skillsDir) => {
  const missing = [];
  const extra = [];

  // Check core workflow skills (these are critical for workflow)
  for (const name of CORE_SKILLS) {
    const skillFile = path.join(skillsDir, name, 'SKILL.md');
    if (!fs.existsSync(skillFile)) {
      missing.push(name);
    }
  }

  // Check for unexpected skill directories (not in ALL_KNOWN_SKILLS)
  try {
    const entries = fs.readdirSync(skillsDir, { withFileTypes: true });
    for (const entry of entries) {
      if (entry.isDirectory() && !ALL_KNOWN_SKILLS.includes(entry.name)) {
        const hasSkillMd = fs.existsSync(path.join(skillsDir, entry.name, 'SKILL.md'));
        if (hasSkillMd) {
          extra.push(entry.name);
        }
      }
    }
  } catch {
    // skillsDir may not exist yet
  }

  return { missing, extra };
};

export const McuIroncladPlugin = async ({ client, directory }) => {
  const homeDir = os.homedir();
  const skillsDir = path.resolve(__dirname, '../../skills');
  const envConfigDir = normalizePath(process.env.OPENCODE_CONFIG_DIR, homeDir);
  const configDir = envConfigDir || path.join(homeDir, '.config/opencode');

  // Run skill graph health check at startup
  const healthCheck = validateSkillGraph(skillsDir);
  const hasWarnings = healthCheck.missing.length > 0 || healthCheck.extra.length > 0;
  if (hasWarnings) {
    if (healthCheck.missing.length > 0) {
      console.warn(`[mcu-ironclad] ⚠️ Missing core skills: ${healthCheck.missing.join(', ')}`);
    }
    if (healthCheck.extra.length > 0) {
      console.warn(`[mcu-ironclad] ℹ️ Unregistered skills (not in known list): ${healthCheck.extra.join(', ')}`);
    }
    console.warn('[mcu-ironclad] Run `git pull` in the mcu-ironclad directory or update the skill list in the plugin to fix.');
  } else {
    console.log(`[mcu-ironclad] ✅ Skill graph validated: ${CORE_SKILLS.length} core + ${INDEPENDENT_SKILLS.length} independent skills present`);
  }

  // Helper to generate bootstrap content
  const getBootstrapContent = () => {
    // Try to load using-superpowers skill
    const skillPath = path.join(skillsDir, 'using-superpowers', 'SKILL.md');
    if (!fs.existsSync(skillPath)) return null;

    const fullContent = fs.readFileSync(skillPath, 'utf8');
    const { content } = extractAndStripFrontmatter(fullContent);

    const toolMapping = `**Tool Mapping for OpenCode:**
When skills reference tools you don't have, substitute OpenCode equivalents:
- \`TodoWrite\` → \`todowrite\`
- \`Task\` tool with subagents → Use OpenCode's subagent system (@mention)
- \`Skill\` tool → OpenCode's native \`skill\` tool
- \`Read\`, \`Write\`, \`Edit\`, \`Bash\` → Your native tools

Use OpenCode's native \`skill\` tool to list and load skills.`;

    return `<EXTREMELY_IMPORTANT>
You have mcu-ironclad skills.

**IMPORTANT: The using-superpowers skill content is included below. It is ALREADY LOADED - you are currently following it. Do NOT use the skill tool to load "using-superpowers" again - that would be redundant.**

${content}

${toolMapping}
</EXTREMELY_IMPORTANT>`;
  };

  return {
    // Inject skills path into live config so OpenCode discovers ALL skills
    // (both core and independent) from the single skills/ directory.
    config: async (config) => {
      config.skills = config.skills || {};
      config.skills.paths = config.skills.paths || [];
      if (!config.skills.paths.includes(skillsDir)) {
        config.skills.paths.push(skillsDir);
      }
    },

    // Inject bootstrap into the first user message of each session.
    'experimental.chat.messages.transform': async (_input, output) => {
      const bootstrap = getBootstrapContent();
      if (!bootstrap || !output.messages.length) return;
      const firstUser = output.messages.find(m => m.info.role === 'user');
      if (!firstUser || !firstUser.parts.length) return;
      // Only inject once
      if (firstUser.parts.some(p => p.type === 'text' && p.text.includes('EXTREMELY_IMPORTANT'))) return;

      // Build health warning if skills are missing
      let healthWarning = '';
      if (hasWarnings && healthCheck.missing.length > 0) {
        healthWarning = `\n\n<MCU_IRONCLAD_HEALTH_WARNING>\n⚠️ Skill graph inconsistency detected: ${healthCheck.missing.length} core skill(s) missing — ${healthCheck.missing.map(s => `\`${s}\``).join(', ')}. Workflow links referencing these skills may be broken. Inform the user and suggest running \`git pull\` in the mcu-ironclad directory or checking skill installation.\n</MCU_IRONCLAD_HEALTH_WARNING>`;
      }

      const ref = firstUser.parts[0];
      firstUser.parts.unshift({ ...ref, type: 'text', text: bootstrap + healthWarning });
    }
  };
};
