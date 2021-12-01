# 米粒垃圾

此处收集的是 `THE IDOLM@STER MILLION RADIO!` 相关的内容。

## 视频源获取

视频源来自兔佬，使用脚本 `scripts/mr-get.sh` 进行获取，如：

```bash
mr-get 420
```

脚本依赖 `curl`、`jq` 和 [annie](https://github.com/iawia002/annie)。

## 讲话人检查

基于文本样式的讲话人检查，防止叠轴。位于 `aegisub/speaker-check.lua`。需将文件放置到 `Aegisub` 的 `lua` 脚本目录。

选中字幕第一行，点击`自动化 > Speaker Check - 讲话人检查`。如果存在叠轴或样式为 `Default` 的字幕行，会自动跳转到对应位置。

## 压制参数

> 声明：由于本人对压制不甚熟悉，因此只能以个人标准随便压压

```bash
ffmpeg -i "$VIDEO_SOURCE.mp4" -vf "ass=$SUBTITLE" -c:v libx264 -b:v 6000k -profile:v main -c:a aac -b:a 320k "$OUTPUT.mkv"
```