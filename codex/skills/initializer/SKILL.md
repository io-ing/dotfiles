---
name: initializer
description: 项目初始化脚手架工具。当用户要求搭建新项目、初始化项目框架、或给出高层需求(如"做一个xxx应用")时使用此技能。只创建 4 个关键文件，不写任何业务代码。
---

# Initializer Agent (搭台子)

## 职责

把用户的高层需求拆解为功能清单，**只创建 4 个关键文件，不写任何业务代码**。

## 重要原则

**Initializer 只负责"规划"，不负责"实现"**

- 只创建：`init.sh` + `claude-progress.txt` + `feature_list.json` + git commit
- 不创建：目录结构、代码文件、配置文件等
- "创建目录结构"、"创建基础代码"等工作应作为功能点写入 feature_list.json，由 Coder 实现

## 工作流程

1. **理解需求**：与用户确认项目目标和技术栈
2. **拆解功能**：将需求拆解为细粒度功能点（通常 50-200 个）
3. **只创建 4 个文件**：不写任何业务代码
4. **初始提交**：git commit 标记项目起点

## 必须创建的 4 个文件

### 1. init.sh

启动开发环境 + 冒烟测试的脚本（**不安装依赖，假设依赖已手动安装**）：

```bash
#!/bin/bash
set -e

# 启动开发服务器（后台运行）
npm run dev &
DEV_PID=$!

# 等待服务就绪
sleep 5

# 冒烟测试：验证应用能正常响应
if curl -s -o /dev/null -w "%{http_code}" http://localhost:3000 | grep -q "200"; then
    echo "Smoke test PASSED: Server responding"
else
    echo "Smoke test FAILED: Server not responding"
    kill $DEV_PID 2>/dev/null
    exit 1
fi

echo "Development environment ready (PID: $DEV_PID)"
```

**注意**：
- 不包含 `npm install` / `pip install` 等安装命令
- 依赖安装由用户手动完成
- init.sh 只负责：启动服务 + 冒烟测试

**冒烟测试标准**：
- Web 应用：HTTP 200 响应
- API 服务：健康检查接口返回成功
- CLI 工具：--help 命令正常退出

### 2. claude-progress.txt

人类可读的工作日志：

```
[YYYY-MM-DD HH:MM] 项目初始化，创建基础框架
```

### 3. feature_list.json

细粒度功能清单，**steps 就是测试用例，而不是实现需求的步骤，必须实际执行验证**。

**格式**：
```json
[
  {
    "category": "functional",
    "description": "功能简述及此测试验证的内容",
    "steps": [
      "Step 1: 测试步骤一",
      "Step 2: 测试步骤二",
      "Step 3: 测试步骤三"
    ],
    "passes": false
  }
]
```

**要求**：
- **最少 100 个功能点，多多益善**，详尽覆盖规格中的每个功能
- 必须包含 `functional` 和 `style` 两种类别
- 混合窄测试(2-5步)和综合测试(10+步)
- 按优先级排序：基础功能优先
- 所有测试初始 `passes: false`
- step 中必须描述测试验证方法

**功能点排序（按优先级）**：
1. 项目初始化（创建目录）
2. 基础配置（数据库、认证）
3. 数据模型
4. API 接口
5. 业务逻辑
6. 前端页面
7. 样式和交互

### 4. 初始 git commit

```bash
git add .
git commit -m "Initialize project scaffold with feature list"
```

## 完成标准

- [ ] init.sh 可执行且冒烟测试通过
- [ ] feature_list.json 包含 100+ 个细粒度功能点
- [ ] 每个功能点的 steps 都是可执行的测试用例
- [ ] claude-progress.txt 记录初始化信息
- [ ] 代码已提交到 git
