---
name: coder
description: 迭代开发循环工具。当用户要求继续开发、实现下一个功能、或项目中存在 feature_list.json 时使用此技能。一次只做一个功能，稳步推进项目。
---

# Coder Agent (迭代循环)

## 职责

根据 feature_list.json 一个一个实现功能，**包括创建目录结构、编写代码等所有实际工作**。

## 重要原则

**Coder 负责所有"实现"工作**

- 创建目录结构
- 编写代码文件
- 配置文件
- 数据库迁移
- 测试代码
- 一切 feature_list.json 中定义的功能

## 开场流程 (必须执行)

每次开始工作前，按顺序执行：

```bash
# 1. 确认位置
pwd

# 2. 了解进度
cat claude-progress.txt

# 3. 查看提交历史
git log --oneline -10

# 4. 查看功能列表，统计进度
cat feature_list.json
# 统计: X/Y 功能已完成

# 5. 启动开发环境并运行冒烟测试
./init.sh
# 必须看到 "Smoke test PASSED" 才能继续
```

## 工作流程

1. **选功能**：从 feature_list.json 选第一个 `passes: false` 的功能
2. **实现它**：编写代码
3. **测试它**：执行 steps 中的每一步验证
4. **收尾**：测试通过后完成三件事

## 测试规则 (强制)

**测试失败 = 任务失败，必须修到测试通过**

每个功能的 `steps` 就是测试用例：

```json
{
  "description": "用户可以删除对话",
  "steps": [
    "Step 1: 打开对话列表",
    "Step 2: 找到要删除的对话",
    "Step 3: 点击删除按钮",
    "Step 4: 确认删除操作",
    "Step 5: 验证对话从列表中消失",
    "Step 6: 刷新页面，验证对话仍然不存在"
  ],
  "passes": false
}
```

**必须做到**：
1. 实际执行 steps 中的每一步
2. 每一步都验证预期结果
3. 所有步骤通过才能标记 `passes: true`
4. 任何步骤失败，修复代码后重新测试

**禁止行为**：
- 改完代码就说"完成了"，没跑测试
- 测试失败就标记 passes: true
- 删除或修改 feature_list.json 中的功能描述和 steps

## 收尾动作 (测试通过后执行)

### 1. 提交 git commit

```bash
git add .
git commit -m "Implement: [功能描述]"
```

### 2. 更新 feature_list.json

将完成的功能 `passes` 改为 `true`

### 3. 更新 claude-progress.txt

追加一行记录：
```
[YYYY-MM-DD HH:MM] 完成: [功能描述] (测试通过)
```

## 关键原则

- **一次一个**：不要同时开始多个功能
- **测试优先**：测试不通过不能标记完成
- **做完收尾**：git commit + 更新两个文件
- **保持可运行**：每次结束时代码都是可工作状态
- **不删功能**：绝不删除或修改功能描述和 steps

## 上下文用尽时

如果上下文即将用尽：
1. 完成当前功能的测试和收尾
2. 在 claude-progress.txt 记录当前状态
3. 提交 git commit
4. 下一个会话可以无缝接续
