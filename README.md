# zlmediakit pro 闭源专业版

## 介绍
基于zlmediakit最新开源版本源码，添加大量的功能增强后，现推出闭源专业版。
该项目为闭源专业版的发行仓库，提供功能介绍、技术文档、二进制下载等功能。
闭源专业版需要经过授权后才能开启专业版相关功能，如果授权失败或过期，则功能和用法和开源版完全一致。

## 联系方式
- 邮箱：1213642868@qq.com

## 注意事项
zlmediakit pro不提供源码授权，只提供二进制使用授权，用户正式商用需要采购激活码。

## 怎么开启专业版功能？
- 下载程序：
  点击[下载链接](https://github.com/xia-chu/zlmediakit-pro/releases), 选择您试用系统对应的程序包。

- 程序的试用：
  程序启动时会触发联网激活试用，每台机器默认支持7天全功能全额度试用；试用必须在非docker环境内开启，每台机器默认只能试用一次。

- 程序的激活：
  程序激活时必须联网，用户启动zlmediakit时可以添加启动参数`--key xxxxxxx`输入激活码，也可以配置文件`api.key`配置激活码激活。

- 离线运行：
  程序激活后，会在当前目录生成`licence.txt`证书文件，后续运行不需要依赖联网。

- 试用或授权过期：将退化为开源版本，用法和功能与开源版完全一致。

- 获取激活码、激活码吊销或重用、试用延长、开启docker试用请联系我邮箱。


## 功能介绍
- 音视频转码
  - 1、音视频间任意转码(包括h265/h264/opus/g711/aac/g722/g722.1/mp3/svac/vp8/vp9/av1等。
  - 2、基于配置文件的转码，支持设置比特率，codec类型等参数。
  - 3、基于http api的动态增减转码，支持设置比特率，分辨率倍数，codec类型、滤镜等参数。
  - 4、支持硬件、软件自适应转码。
  - 5、支持按需转码，有人观看才转码，支持透明转码模式，业务无需感知转码的存在，业务代码无需做任何调整。
  - 6、支持负载过高时，转码主动降低帧率且不花屏。
  - 7、支持滤镜，支持添加osd文本以及logo角标等能力。
  - 8、支持全GPU硬件编解码与滤镜，防止显存与内存频繁拷贝。
  - 9、对ffmpeg二次开发，支持g722.1，svac私有解码器。
    
- JT1078部标
  - 1、支持接收jt1078推流转其他协议；自适应音视频共享seq和单独seq模式。
  - 2、支持jt1078级联，支持jt1078对讲。
  - 3、jt1078相关接口、端口和用法与GB28181用法一致，保持兼容。
  - 4、支持h264/h265/g711/aac/mp3/g721/g722/g723/g729/g726/adpcm等编码。

- IPTV
  - 1、支持rtsp-ts/hls/http-ts/rtp组播/udp组播拉流转协议，支持ts透传模式，无需解复用转rtsp-ts/hls/http-ts/srt协议。
  - 2、支持接收rtsp-ts/srt/rtp-ts推流，支持ts透传模式，无需解复用转rtsp-ts/hls/http-ts/srt协议。
  - 3、上述功能同时支持解复用ts为es流再转rtsp/rtmp/flv/http-ts/hls/hls-fmp4/mp4/fmp4/webrtc等协议。

- S3云存储
  - 支持s3/minio云存储内存流直接写入，解决录像文件io系统瓶颈问题
  - 支持直接通过zlmediakit的http服务下载和点播云存储文件。
  - 支持遍历云存储文件并生成http菜单网页。
 
- WebRTC集群
  - 支持rtc流量代理，解决k8s部署zlmediakit webrtc服务时，http信令交互与rtc流量打不到同一个pod实例的问题。
 
- AI推理
  - 支持yolo推理插件，支持人员、车辆等目标AI识别，支持目标跟踪，支持多边形布防，支持ocr，支持c++/python插件快速混合开发。
  - 支持tensorRT 全cuda加速推理。
  - 支持onnxruntime(cpu/gpu) 推理。
  - python插件支持调用c++接口操作流媒体与绘制当前视频画面。


## 使用技术文档
请查看本仓库[wiki](https://github.com/xia-chu/zlmediakit-pro/wiki)


## 下载二进制包
请在[release列表](https://github.com/xia-chu/zlmediakit-pro/releases)下载您对应平台的二进制包。
二进制包分为:
- Linux版本:
  
  centos7上编译，支持svac、g722.1自定义解码器，vcpkg编译依赖项，支持cuda、qsv、amf、aom、opencl、openh264、vpx、vulkan等编解码器，支持s3云存储，功能全面。
  
- Windows版本:
  
  支持特性全面，vcpkg编译依赖项，支持cuda、qsv、amf、aom、dav1d、opencl、openh264、vpx、vulkan等编解码器，支持s3云存储，功能全面。


## docker下载
docker支持x86_64和arm64平台，支持硬件编解码器，支持s3云存储，功能全面。
```bash
docker pull zlmediakit/zlmediakit-pro:feature_all
```


## 更新记录
- 2025-11-7
  - 新增支持mp4录制内存流写入s3云存储，支持从s3云存储加载mp4文件点播为rtsp/rtmp/flv/webrtc等协议。
  - 新增支持截图写入云存储，并从云存储加载截图。
  - deleteRecordDirectory/deleteSnapDirectory/getMP4RecordFile/getSnap接口支持云存储。
  - 采用缓存机制优化云存储读写性能，降低读写请求qps。
