---
name: codex-helper
description: 使用 Codex AI 编程助手的非交互式命令完成编程任务。Codex 可以执行任务、审查代码、应用变更。当用户需要代码实现、审查、修复或明确提到 codex 时使用
allowed-tools: Bash, Read, Grep, Glob
---

# codex-helper

codex 是 AI 编程助手，需要使用非交互命令模式调用，命令后面接 2>/dev/null 隐藏推理过程

## Codex 帮助命令

```bash
codex -help
codex exec --help
```

## Codex 非交互式常见命令

```codex exec --help
Run Codex non-interactively

Usage: codex exec [OPTIONS] [PROMPT] [COMMAND]

Commands:
  resume  Resume a previous session by id or pick the most recent with --last
  review  Run a code review against the current repository
  help    Print this message or the help of the given subcommand(s)

Arguments:
  [PROMPT]
          Initial instructions for the agent. If not provided as an argument (or if `-` is used), instructions are read from stdin

Options:
  -c, --config <key=value>
          Override a configuration value that would otherwise be loaded from `~/.codex/config.toml`. Use a dotted path (`foo.bar.baz`) to override nested values. The `value` portion is parsed as TOML. If it fails to parse as TOML, the raw string is used as a literal.

          Examples: - `-c model="o3"` - `-c 'sandbox_permissions=["disk-full-read-access"]'` - `-c shell_environment_policy.inherit=all`

  -i, --image <FILE>...
          Optional image(s) to attach to the initial prompt

  -m, --model <MODEL>
          Model the agent should use

  -s, --sandbox <SANDBOX_MODE>
          Select the sandbox policy to use when executing model-generated shell commands

          [possible values: read-only, workspace-write, danger-full-access]

  -p, --profile <CONFIG_PROFILE>
          Configuration profile from config.toml to specify default options

      --full-auto
          Convenience alias for low-friction sandboxed automatic execution (-a on-request, --sandbox workspace-write)

      --dangerously-bypass-approvals-and-sandbox
          Skip all confirmation prompts and execute commands without sandboxing. EXTREMELY DANGEROUS. Intended solely for running in environments that are externally sandboxed

  -C, --cd <DIR>
          Tell the agent to use the specified directory as its working root

      --skip-git-repo-check
          Allow running Codex outside a Git repository

      --output-schema <FILE>
          Path to a JSON Schema file describing the model's final response shape

      --json
          Print events to stdout as JSONL

  -o, --output-last-message <FILE>
          Specifies file where the last message from the agent should be written
```

## codex exec 使用示例

### 基础使用
```bash
codex exec "列出当前目录的文件"
codex exec "检查项目中是否有未使用的导入"
codex exec "修复 main.py 中的语法错误"
```

### 使用基本选项

```bash
# 指定模型
codex exec -m gpt-5.1-codex-max "重构 utils.py 使其更简洁"

# 指定工作目录
codex exec -C /path/to/project "运行测试并修复失败的用例"

# 只读模式（安全）
codex exec -s read-only "分析项目架构并生成文档"

# 带图片输入
codex exec -i design.png "根据这个设计图实现 HTML/CSS"
```

### 自动化场景

```
# 全自动模式
codex exec --full-auto "运行 npm test 并修复所有失败的测试"

# 完全自动化（CI/CD）
# 注意：**极度危险**，仅用于已沙箱化的 CI/CD 环境。
codex exec --dangerously-bypass-approvals-and-sandbox \
  --skip-git-repo-check \
  "部署到测试环境"
```
