#!/bin/bash

if [ $# -ne 2 ]; then
    echo "エラー: 2つの数値を引数に指定してください。"
    echo "使い方: $0 <数値1> <数値2>"
    exit 1
fi

if [[ ! $1 =~ ^[0-9]+$ ]] || [[ ! $2 =~ ^[0-9]+$ ]]; then
    echo "エラー: 正の整数を入力してください。"
    exit 1
fi

gcd() {
    local a=$1
    local b=$2
    while [ $b -ne 0 ]; do
        local remainder=$((a % b))
        a=$b
        b=$remainder
    done
    echo $a
}

result=$(gcd $1 $2)
echo "最大公約数 ($1, $2) = $result"
