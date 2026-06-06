#!/bin/bash

TARGET="./gcd.sh"

# テスト結果のカウンター
PASSED=0
FAILED=0

assert_output() {
    local test_name="$1"
    local args="$2"
    local expected_output="$3"
    
    # 標準出力と標準エラー出力を両方キャッチ
    actual_output=$($TARGET $args 2>&1)
    
    if [[ "$actual_output" == *"$expected_output"* ]]; then
        echo "[ PASS ] $test_name"
        ((PASSED++))
    else
        echo "[ FAIL ] $test_name"
        echo "  引数: $args"
        echo "  期待値: $expected_output"
        echo "  実際の出力: $actual_output"
        ((FAILED++))
    fi
}

echo "=== テストを開始 ==="

# 1. 引数の数と形式のチェック（機能テスト）

assert_output "引数なし" "" "エラー: 2つの数値を引数に指定してください。"
assert_output "引数が1つ" "24" "エラー: 2つの数値を引数に指定してください。"
assert_output "引数が3つ" "24 36 48" "エラー: 2つの数値を引数に指定してください。"
assert_output "文字列の混入" "24abc 36" "エラー: 正の整数を入力してください。"

# 2. 負の数のチェック（機能テスト）

assert_output "マイナスの数" "-24 36" "エラー: 正の整数を入力してください。"
assert_output "マイナスの数" "24 -36" "エラー: 正の整数を入力してください。"

# 3. 正常系の計算チェック
assert_output "通常の計算（公約数あり）" "24 36" "最大公約数 (24, 36) = 12"
assert_output "互いに素" "101 103" "最大公約数 (101, 103) = 1"
assert_output "片方が1" "1 50" "最大公約数 (1, 50) = 1"
assert_output "同じ数字" "77 77" "最大公約数 (77, 77) = 77"

echo "--------------------------------------------------"
echo "テスト完了: PASS=$PASSED, FAIL=$FAILED"

if [ $FAILED -ne 0 ]; then
    echo "⚠️ いくつかのテストが失敗しました。修正が必要です。"
    exit 1
else
    echo "🎉 すべてのテストに成功しました！"
    exit 0
fi