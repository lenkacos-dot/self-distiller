#!/bin/bash
# ==============================================================
# Self-Distiller — raw/ 目录加密/解密工具
# 使用 OpenSSL AES-256-CBC 加密敏感原始材料文件
#
# 用法:
#   ./encrypt-raw.sh lock    # 加密 raw/ 目录（删除明文）
#   ./encrypt-raw.sh unlock  # 解密 raw/ 目录（恢复明文）
#
# 密钥文件: .enc_key（自动生成，请务必保存）
#
# 特性:
#   - 支持子目录嵌套（raw/subdir/file.md 也会被加密）
#   - SIGINT/Ctrl+C 时自动清理未完成的解密文件
#   - 空目录自动创建
# ==============================================================

set -euo pipefail

KEY_FILE=".enc_key"
RAW_DIR="raw"

# ----- 清理函数：SIGINT 时删除解密到一半的文件 -----
CLEANUP_FILES=()
cleanup() {
    if [ ${#CLEANUP_FILES[@]} -gt 0 ]; then
        echo ""
        echo "⚠️  收到中断信号，清理未完成的文件..."
        for f in "${CLEANUP_FILES[@]}"; do
            if [ -f "$f" ]; then
                rm -f "$f"
                echo "   🗑️  已删除: $f"
            fi
        done
    fi
    exit 1
}
trap cleanup SIGINT SIGTERM

# ----- 确保 raw/ 目录存在 -----
ensure_raw_dir() {
    if [ ! -d "$RAW_DIR" ]; then
        mkdir -p "$RAW_DIR"
        echo "📁 已创建 $RAW_DIR/ 目录"
    fi
}

# ----- 生成新密钥 -----
gen_key() {
    if [ ! -f "$KEY_FILE" ]; then
        openssl rand -hex 32 > "$KEY_FILE"
        chmod 600 "$KEY_FILE"
        echo "🔑 密钥已生成 → 保存到 $(pwd)/$KEY_FILE"
        echo "⚠️  请将此密钥备份到安全位置（密码管理器等）"
        echo "   否则加密后的文件将永远无法恢复！"
    fi
}

# ----- 加密 raw/ 下的文件（含子目录） -----
do_encrypt() {
    ensure_raw_dir
    gen_key

    local count=0
    # 查找所有明文文件（递归子目录）
    while IFS= read -r -d '' f; do
        local base=$(basename "$f")
        local dir=$(dirname "$f")
        local enc_file="${dir}/${base}.enc"

        # 跳过已加密的文件
        [ -f "$enc_file" ] && continue

        openssl enc -aes-256-cbc -salt -pbkdf2 -iter 100000 \
            -in "$f" -out "$enc_file" -pass "file:$KEY_FILE"
        rm "$f"
        echo "🔒 已加密: $f"
        count=$((count + 1))
    done < <(find "$RAW_DIR" \( -name '*.md' -o -name '*.txt' -o -name '*.json' -o -name '*.jsonl' -o -name '*.csv' -o -name '*.log' \) -type f -print0)

    if [ "$count" -eq 0 ]; then
        echo "📭 没有需要加密的明文文件（可能已加密或 raw/ 为空）"
    else
        echo "✅ raw/ 目录已锁定（含子目录）！共加密 $count 个文件"
        echo "   使用 ./encrypt-raw.sh unlock 解锁"
    fi
}

# ----- 解密 raw/ 下的加密文件（含子目录） -----
do_decrypt() {
    if [ ! -f "$KEY_FILE" ]; then
        echo "❌ 未找到密钥文件 $KEY_FILE"
        echo "   请将备份的密钥内容写入 $(pwd)/$KEY_FILE"
        exit 1
    fi

    local count=0
    # 查找所有 .enc 文件（递归子目录）
    while IFS= read -r -d '' f; do
        local dec_file="${f%.enc}"

        # 注册清理：中断时删除这个解密到一半的文件
        CLEANUP_FILES+=("$dec_file")

        openssl enc -d -aes-256-cbc -pbkdf2 -iter 100000 \
            -in "$f" -out "$dec_file" -pass "file:$KEY_FILE"

        # 解密成功，从清理列表移除
        CLEANUP_FILES=("${CLEANUP_FILES[@]/$dec_file}")
        echo "🔓 已解密: $dec_file"
        count=$((count + 1))
    done < <(find "$RAW_DIR" -name '*.enc' -type f -print0)

    if [ "$count" -eq 0 ]; then
        echo "📭 没有加密文件需要解密"
    else
        echo "✅ raw/ 目录已解锁（含子目录）！共解密 $count 个文件"
        echo "   完成后请运行 ./encrypt-raw.sh lock 重新加密"
    fi
}

case "${1:-}" in
    lock)
        do_encrypt
        ;;
    unlock)
        do_decrypt
        ;;
    *)
        echo "用法: $0 {lock|unlock}"
        echo ""
        echo "  lock   — 加密 raw/ 目录（删除明文）"
        echo "  unlock — 解密 raw/ 目录（恢复明文）"
        exit 1
        ;;
esac
