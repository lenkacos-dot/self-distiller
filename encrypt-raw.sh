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
# ==============================================================

set -euo pipefail

KEY_FILE=".enc_key"
RAW_DIR="raw"
ENCRYPTED=false
DECRYPTED=false

# 生成新密钥
gen_key() {
    if [ ! -f "$KEY_FILE" ]; then
        openssl rand -hex 32 > "$KEY_FILE"
        chmod 600 "$KEY_FILE"
        echo "🔑 密钥已生成 → 保存到 $(pwd)/$KEY_FILE"
        echo "⚠️  请将此密钥备份到安全位置（密码管理器等）"
        echo "   否则加密后的文件将永远无法恢复！"
    fi
}

# 加密 raw/ 下的明文文件
do_encrypt() {
    gen_key
    local key=$(cat "$KEY_FILE")
    
    for f in "$RAW_DIR"/*.md "$RAW_DIR"/*.txt "$RAW_DIR"/*.json "$RAW_DIR"/*.jsonl; do
        [ -f "$f" ] || continue
        local base=$(basename "$f")
        local enc_file="$RAW_DIR/${base}.enc"
        
        # 跳过已加密文件
        [ -f "$enc_file" ] && continue
        
        openssl enc -aes-256-cbc -salt -pbkdf2 -iter 100000 \
            -in "$f" -out "$enc_file" -pass "file:$KEY_FILE"
        rm "$f"
        
        echo "🔒 已加密: $base"
        ENCRYPTED=true
    done
    
    if [ "$ENCRYPTED" = false ]; then
        echo "📭 没有需要加密的明文文件（可能已加密）"
    else
        echo "✅ raw/ 目录已锁定！使用 ./encrypt-raw.sh unlock 解锁"
    fi
}

# 解密 raw/ 下的加密文件
do_decrypt() {
    if [ ! -f "$KEY_FILE" ]; then
        echo "❌ 未找到密钥文件 $KEY_FILE"
        echo "   请将备份的密钥内容写入 $(pwd)/$KEY_FILE"
        exit 1
    fi
    
    local key=$(cat "$KEY_FILE")
    
    for f in "$RAW_DIR"/*.enc; do
        [ -f "$f" ] || continue
        local base=$(basename "$f" .enc)
        local dec_file="$RAW_DIR/$base"
        
        openssl enc -d -aes-256-cbc -pbkdf2 -iter 100000 \
            -in "$f" -out "$dec_file" -pass "file:$KEY_FILE"
        
        echo "🔓 已解密: $base"
        DECRYPTED=true
    done
    
    if [ "$DECRYPTED" = false ]; then
        echo "📭 没有加密文件需要解密"
    else
        echo "✅ raw/ 目录已解锁！完成后请运行 ./encrypt-raw.sh lock 重新加密"
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
