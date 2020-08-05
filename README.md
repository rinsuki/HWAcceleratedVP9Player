# HWAcceleratedVP9Player

macOS 11.0 Big Sur beta 4 から VP9 のHW支援でのデコードに対応したのを利用し、VP9 入り MP4 のファイルを再生するデモです。

## How to build

git clone して HWAcceleratedVP9Player.xcodeproj を開きビルドしてください。
Team や 

## VP9 入り MP4 の作り方

通常通りに VP9 が入った WebM ファイルを用意し、 `ffmpeg -i vp9.webm -codec copy vp9.mp4` で作成できます。

ただし、現段階でOpusには対応していないようなので、`-acodec aac`などで音声を変換する必要があるかもしれません。

## How it works

VP9 のハードウェアデコーダは macOS 11.0 beta 4 から追加された [`VTRegisterSupplementalVideoDecoderIfAvailable(_:)`](https://developer.apple.com/documentation/videotoolbox/3666591-vtregistersupplementalvideodecod?changes=latest_beta) API に 0x7670303 (FourCode で vp09) を渡すと有効化できます。

このAPIを呼んで有効化した後に AVPlayer などに VP9 入り MP4 を読ませると普通に再生してくれます (ただし HW 支援がないと失敗するかも)。

詳しい呼び方は WebKit のこのへん https://trac.webkit.org/log/webkit/trunk/Source/WebCore/platform/graphics/cocoa/VP9UtilitiesCocoa.mm を見るとよいでしょう。