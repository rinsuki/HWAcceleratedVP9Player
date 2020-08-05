# HWAcceleratedVP9Player

macOS 11.0 Big Sur beta 4 から VP9 のHW支援でのデコードに対応したのを利用し、VP9 入り MP4 のファイルを再生するデモです。

## How to build

git clone して HWAcceleratedVP9Player.xcodeproj を開きビルドしてください。

## VP9 入り MP4 の作り方

通常通りに VP9 が入った WebM ファイルを用意し、 `ffmpeg -i vp9.webm -codec copy vp9.mp4` で作成できます。

ただし、現段階でOpusには対応していないようなので、`-acodec aac`などで音声を変換する必要があるかもしれません。