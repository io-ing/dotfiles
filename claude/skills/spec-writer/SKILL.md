---
name: spec-writer
description: 读取需求文档，通过持续采访用户完善细节，生成完整的项目规范文件(app_spec.txt)。适用于将半完整的需求转化为可用于代码生成的结构化规范。
---

# Spec Writer - 项目规范生成器

## 职责

将用户的需求文档转化为结构化的项目规范文件，通过智能采访补充缺失细节。

## 工作流程

### 1. 读取需求文档

用户调用时提供需求文档路径：
```
/spec-writer /path/to/requirements.txt
```

如果未提供路径，询问用户：
- 需求文档路径
- 或者直接描述项目需求

### 2. 分析需求文档

读取文档后，分析已有信息和缺失内容。根据以下模块检查完整度：

| 模块 | 检查点 |
|------|--------|
| 概述 | 项目名称、目标、定位 |
| 技术栈 | 前端、后端、数据库、部署 |
| 核心功能 | 功能列表、优先级、边界情况 |
| 数据模型 | 主要实体、关系 |
| API 设计 | 需要的接口类型 |
| UI/UX | 页面结构、用户流程 |
| 实现步骤 | 开发顺序、依赖关系 |
| 成功标准 | 验收条件 |

### 3. 持续采访

使用 AskUserQuestion 工具进行深度采访：

**采访原则**：
- 动态决定问题数量和顺序，根据当前信息完整度调整
- 问题要深入，不问表面问题
- 涵盖：业务逻辑、技术实现、UI/UX、性能要求、安全考量、边界情况
- 模糊回答时智能判断：核心问题追问，次要问题标记待定
- 无轮数限制，直到判断信息足够生成完整规范

**采访维度**：
- 业务：核心用户场景、业务规则、异常处理
- 技术：技术栈偏好、性能要求、扩展性需求
- UI/UX：界面风格、交互方式、响应式需求
- 安全：认证方式、权限控制、数据保护
- 边界：并发处理、错误恢复、数据量级

### 4. 生成规范文件

采访完成后，生成 `app_spec.txt`，使用 XML 风格标记，中文内容。

**文件结构**：

```xml
<project_specification>
  <project_name>项目名称</project_name>

  <overview>
    项目概述，包括目标、定位、核心价值
  </overview>

  <technology_stack>
    <frontend>
      <framework>框架</framework>
      <styling>样式方案</styling>
    </frontend>
    <backend>
      <runtime>运行时</runtime>
      <database>数据库</database>
    </backend>
  </technology_stack>

  <core_features>
    <feature_group>
      - 功能点列表
    </feature_group>
  </core_features>

  <database_schema>
    <tables>
      <table_name>
        - 表名和字段
      </table_name>
    </tables>
  </database_schema>

  <api_design>
    <api_group>
      功能级别的 API 需求描述
    </api_group>
  </api_design>

  <ui_layout>
    <page_name>
      页面布局和主要组件（布局级别）
    </page_name>
  </ui_layout>

  <implementation_steps>
    <step number="1">
      <title>步骤标题</title>
      <tasks>
        - 具体任务
      </tasks>
    </step>
  </implementation_steps>

  <success_criteria>
    <functionality>功能验收标准</functionality>
    <user_experience>用户体验标准</user_experience>
    <technical_quality>技术质量标准</technical_quality>
  </success_criteria>
</project_specification>
```

### 5. 写入文件

直接将规范写入当前目录的 `app_spec.txt`。

## 完成判断标准

当满足以下条件时，结束采访并生成规范：

- [ ] 项目目标和核心价值清晰
- [ ] 技术栈选择已确定
- [ ] 核心功能列表完整
- [ ] 主要数据实体和关系明确
- [ ] 用户流程和页面结构清晰
- [ ] 实现步骤可以规划
- [ ] 成功标准可以定义

## 注意事项

- 仅支持纯文本需求文档（.txt, .md）
- 输出文件固定为 `app_spec.txt`
- 内容使用中文
- 技术栈由用户指定，可以适当预设推荐
