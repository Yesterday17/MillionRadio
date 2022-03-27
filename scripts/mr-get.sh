#!/bin/bash

BILI_SEARCH='https://api.bilibili.com/x/space/arc/search?mid=47653&ps=30&tid=0&pn=1&order=pubdate&keyword='

resp=$(curl -s "$BILI_SEARCH$1")
echo "正在获取：$(echo $resp | jq -r .data.list.vlist[0].title)"

BVID=$(echo $resp | jq -r '.data.list.vlist[0].bvid')
echo "bvid: $BVID"

LEN=$(echo $resp | jq -r '.data.list.vlist[0].length' | cut -d: -f1)
if (( "$LEN" < 60 )); then
  # 兔佬还没有上传弹幕版
  echo "弹幕版尚未上传，请等待完整上传后再尝试下载！"
  exit 1
fi

lux -p "$BVID"

echo "下载完成！"
