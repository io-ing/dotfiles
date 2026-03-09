#!/usr/bin/env python3
"""
简单的提交消息检查脚本
"""

import sys
import re


def check_commit_message(message):
    """检查提交消息"""

    print("=" * 50)
    print("📋 提交消息检查")
    print("=" * 50)
    print()
    print(f"消息：{message}")
    print()
    print("=" * 50)
    print()

    issues = []
    warnings = []
    score = 100

    # 1. 检查类型前缀
    types = ['feat', 'fix', 'docs', 'style', 'refactor', 'test', 'chore']
    has_type = any(message.startswith(f"{t}:") for t in types)

    if not has_type:
        issues.append("❌ 缺少类型前缀（feat/fix/docs 等）")
        score -= 30
    else:
        print("✅ 类型前缀：正确")

    # 2. 检查长度
    if ':' in message:
        desc = message.split(':', 1)[1].strip()
    else:
        desc = message

    if len(desc) > 50:
        issues.append(f"❌ 描述过长（{len(desc)} 字符，建议 ≤ 50）")
        score -= 20
    elif len(desc) < 10:
        warnings.append(f"⚠️ 描述过短（{len(desc)} 字符）")
        score -= 10
    else:
        print(f"✅ 长度：合适（{len(desc)} 字符）")

    # 3. 检查结尾句号
    if message.endswith('.'):
        issues.append("❌ 不应以句号结尾")
        score -= 10
    else:
        print("✅ 格式：无句号结尾")

    # 4. 检查首字母
    if ':' in message:
        desc_start = message.split(':', 1)[1].strip()
        if desc_start and desc_start[0].isupper():
            warnings.append("⚠️ 描述首字母应小写")
            score -= 5
        else:
            print("✅ 大小写：正确")

    # 5. 检查模糊词汇
    vague_words = ['修复', '更新', '优化', 'update', 'fix bugs', 'improve']
    if any(word in message.lower() for word in vague_words):
        warnings.append("⚠️ 使用了模糊词汇，建议更具体")
        score -= 10

    print()
    print("=" * 50)
    print()

    # 输出问题
    if issues:
        print("❌ 发现问题：")
        for issue in issues:
            print(f"  {issue}")
        print()

    if warnings:
        print("⚠️ 警告：")
        for warning in warnings:
            print(f"  {warning}")
        print()

    if not issues and not warnings:
        print("✅ 所有检查通过！")
        print()

    print("=" * 50)
    print(f"📊 评分：{max(0, score)}/100")
    print("=" * 50)

    return len(issues) == 0


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("用法: python check_commit.py '提交消息'")
        sys.exit(1)

    message = sys.argv[1]
    success = check_commit_message(message)
    sys.exit(0 if success else 1)
