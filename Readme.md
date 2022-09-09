# 米粒垃圾

此处收集的是 `THE IDOLM@STER MILLION RADIO!` 相关的内容。

## 视频源

### 静音切除

视频源须自行下载，得到 `ts` 文件后通过 `cut.sh` 进行切分：

```bash
./cut.sh 479本篇.ts
```

可以获得切除了开头和结尾静音部分的结果。产物文件为 `mkv` 视频和用于表示与原视频切分关系的 `JSON` 。

脚本依赖 `ffmpeg`、`sed`、`head`、`tail` 和 `qalc`。

### 弹幕压入

获得弹幕的 `ass` 文件后，`ass`、`json` 和 `mkv` 保持相同文件名（除扩展名），然后运行：

```bash
./danmaku.sh 479本篇.mkv
```

即可压制得到弹幕版。系统字体须包含 `YuGoth` 和 `MS Gothic`。`Windows` 默认自带，可以复制一份过来。

脚本依赖 `ffmpeg`、`mkvmerge` 和 `jq`。

## 讲话人检查

基于文本样式的讲话人检查，防止叠轴。位于 `aegisub/speaker-check.lua`。需将文件放置到 `Aegisub` 的 `lua` 脚本目录。

选中字幕第一行，点击`自动化 > Speaker Check - 讲话人检查`。如果存在叠轴或样式为 `Default` 的字幕行，会自动跳转到对应位置。

## 压制参数

> 声明：由于本人对压制不甚熟悉，因此只能以个人标准随便压压

```bash
ffmpeg -i "$VIDEO_SOURCE.mp4" -vf "ass=$SUBTITLE" -c:v h264_nvenc -b:v 6000k -profile:v main -c:a aac -b:a 320k "$OUTPUT.mkv"
```

## 投稿

投稿使用 [sswa](https://github.com/Yesterday17/sswa) 进行，投稿模板位于 [mr.toml](templates/mr.toml)

投稿用到的文件如下：

```text
# 445.txt
num=445
title=kraz回归！
translators="Shopping  Neila  てい  炭酸"
jiaodui=洗濯機P
subtitle=xue
date=2022-01-13
```

命令如下：

```bash
sswa upload --template mr 445.txt 445本篇.mkv 445omake.mkv
```
