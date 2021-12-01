# 米粒垃圾

此处收集的是 `THE IDOLM@STER MILLION RADIO!` 相关的内容。

## 视频源获取

视频源来自兔佬，使用脚本 `scripts/mr-get.sh` 进行获取，如：

```bash
mr-get 420
```

脚本依赖 `curl`、`jq` 和 [annie](https://github.com/iawia002/annie)。

## 压制参数

> 声明：由于本人对压制不甚熟悉，因此只能以个人标准随便压压

```bash
ffmpeg -i "$VIDEO_SOURCE.mp4" -vf "ass=$SUBTITLE" -c:v libx264 -b:v 6000k -profile:v main -c:a aac -b:a 320k "$OUTPUT.mkv"
```