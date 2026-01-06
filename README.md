# zlmediakit pro 闭源专业版

## 介绍
基于zlmediakit最新开源版本源码，添加大量的功能增强后，现推出闭源专业版。
该项目为闭源专业版的发行仓库，提供功能介绍、技术文档、二进制下载等功能。
闭源专业版需要经过授权后才能开启专业版相关功能，如果授权失败或过期，则功能和用法和开源版完全一致。

## 联系方式
- 微信：xiachuziyue
- 邮箱：1213642868@qq.com

## 注意事项
zlmediakit pro原则上不提供源码授权，只提供二进制使用授权，用户正式商用需要采购激活码。
授权价格请参考[授权定价表](https://github.com/xia-chu/zlmediakit-pro/wiki/%E6%8E%88%E6%9D%83%E5%AE%9A%E4%BB%B7%E8%A1%A8)

## 怎么开启专业版功能？
- 下载程序：
  点击[下载链接](https://github.com/xia-chu/zlmediakit-pro/issues/3), 选择您试用系统对应的程序包。

- 程序的试用：
  程序启动时会触发联网激活试用，每台机器默认支持15天全功能全额度试用；试用必须在非docker环境内开启，每台机器默认只能试用一次。

- 程序在线激活：
  程序激活时需要联网，用户启动MediaServer时可以添加启动参数`--key xxxxxxx`输入激活码，也可以配置文件`api.key`配置激活码激活。

- 程序离线激活：
  用户启动时MediaServer时，添加启动参数`--req`, 这样程序会在同目录下生成`licence_req.txt`文件，拷贝出此文件，在[网站](https://licence.zlmediakit.com/)上传完成激活并下载证书`licence.txt`拷贝到同目录然后重启MediaServer服务即可。

- 离线运行：
  程序激活后，会在当前目录生成`licence.txt`证书文件，后续运行不需要依赖联网。

- 试用或授权过期：将退化为开源版本，用法和功能与开源版完全一致。

- 获取激活码、激活码吊销或重用、试用延长、开启docker试用请联系我。


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
  - 10、支持多显卡并联自动负载均衡转码。
    
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
  - 1、支持s3/minio云存储内存流直接写入，解决录像文件io系统瓶颈问题
  - 2、支持直接通过zlmediakit的http服务下载和点播云存储文件。
  - 3、支持遍历云存储文件并生成http菜单网页。
  - 4、s3云存储读写全内存流方式，不经过磁盘，无磁盘io瓶颈。
  - 5、支持mp4/hls录制至云存储，支持从云存储点播mp4为rtsp/rtmp/flv/webrtc等协议。
  - 6、绝大部分文件都支持云存储读写。
 
- AI推理
  - 1、支持yolo推理插件，支持人员、车辆等目标AI识别，支持目标跟踪，支持多边形布防，支持ocr，支持c++/python插件快速混合开发。
  - 2、支持tensorRT 全cuda加速推理。
  - 3、支持onnxruntime(cpu/gpu) 推理。
  - 4、支持算能(比特大陆)平台推理。
  - 5、支持华为昇腾(ascend)平台推理。
  - 6、python插件支持调用c++接口操作流媒体与绘制当前视频画面。
  - 7、支持多显卡并联自动负载均衡推理。
  - 8、支持多线程多实例并联推理，cpu推流也可以做到实时推理。
  - 9、支持资源检视、限流、熔断、耗时/帧率统计、异常保护上报，支持实时、抽检等模式。
  - 10、支持事件点截图、回溯录像并mqtt推送。
  - 11、丰富的推理后处理业务逻辑与http接口。

- WebRTC集群
  - 1、支持rtc流量代理，解决k8s部署zlmediakit webrtc服务时，http信令交互与rtc流量打不到同一个pod实例的问题。
 
- WebRTC mcu语音聊天室
  - 1、支持mcu多人语音聊天室，混音前支持背景噪声消除，静音不参与混音，解决超大规模多人语音聊天室sfu方案不可用的问题。
  - 2、支持100人语音连麦，上千人旁听级会议。


## 使用技术文档
请查看本仓库[wiki](https://github.com/xia-chu/zlmediakit-pro/wiki)


## 下载二进制包
请在[发行包列表](https://github.com/xia-chu/zlmediakit-pro/issues/3)最下面下载各平台最新的二进制发行包，非onnx版本支持ai推理外所有专业版功能，onnx版本由于依赖Python环境，部署比较麻烦，所以单独提供：

- Linux版本:

    centos7上编译，支持svac、g722.1自定义解码器，vcpkg编译依赖项，支持cuda、qsv、amf、aom、opencl、openh264、vpx、vulkan等编解码器。

- Linux ARM版本：

    和Linux普通版本相比功能基本一致，移除了对svac、g722.1自定义解码器的支持，在kylin:v10sp1-aarch64上编译。

- Linux onnx版本：

    和Linux普通版本相比增加onnx cpu推理功能，依赖python运行环境，需要先miniconda安装python3.11才能启动。

- Windows版本:

    支持特性全面，vcpkg编译依赖项，支持cuda、qsv、amf、aom、dav1d、opencl、openh264、vpx、vulkan等编解码器。

- Windows onnx版本:

    和Windows普通版本相比增加onnx cuda推理功能，依赖python运行环境，依赖cuda和cudnn环境。

- macOS版本：

    支持aom、openh264、vpx、videotoolbox等编解码器。

- macOS onnx版本：

    和macOS普通版本相比增加onnx coreml推理功能，依赖python运行环境，需要先brew install python@3.14才能启动。


## docker下载
docker支持x86_64和arm64平台，支持硬件编解码器，支持s3云存储，功能全面。
```bash
docker pull zlmediakit/zlmediakit-pro:feature_all
```


## 更新记录
- 2026-1-5
  - 新增获取语音聊天室列表和用户列表相关接口。
  - 新增支持语音聊天室旁听直播流。
  - 优化语音音质，解决沙沙声与卡顿问题。
    
- 2026-1-1
  - 新增支持mcu多人语音聊天室，混音前支持背景噪声消除，静音不参与混音。
  
- 2025-12-29
  - 流式录像mp4至s3云存储支持非fmp4格式，解决fmp4录像http点播无法秒开的问题。
    
- 2025-12-26
  - 增强事件视频录制，回溯和前向录制时间均支持负数。
  - 音频nack反馈包个数可单独设置，提高音频重传速度。
  - 配置文件新增支持优先webrtc over tcp配置。
  - getAllSession http api返回连接类型。
  - 媒体注册注销、拉流代理失败事件回调到Python层。
  - 插件层支持获取解码列队缓存长度、支持清空解码列队缓存(降低延时)。
  - 新增get_full_path(pybin11)接口。
  - 新增单帧推理耗时统计。
  - 解码丢帧事件支持回调至Python层，支持推理失败重试次数配置。
    
- 2025-12-23
  - 新增支持删除s3云存储文件夹，修复s3云存储目录遍历相关问题。
  - 优化webrtc抗丢包乱序逻辑。
  - 修复WebRtcSession对象可能泄露的bug。
    
- 2025-12-15
  - 新增支持python编写zlm http api接口和对接处理hook事件回调。
  - ai推理新增支持设置任务优先级，支持抢占式实时模式。
  - 支持ai推理多线程多实例并发模式，在cpu环境下也能实现实时推理。
  - ai推理间隔改成毫秒模式，新增支持获取帧率(推理、解码、丢帧)等统计信息。
    
- 2025-11-27
  - 支持新版语音对讲webrtc插件，降低使用难道，支持对讲音频转码。
  - 稳定性增强。
  - 同步开源代码。
  
- 2025-11-23
  - linux发行包新增支持G722.1C编码器，支持svac解码，G722.1C编解码。
  - 解决websocket-flv/fmp4/ts多路播放请求pending问题。
  - 初步添加onvif客户端。
  - 稳定性增强。
  
- 2025-11-7
  - 新增支持mp4录制内存流写入s3云存储，支持从s3云存储加载mp4文件点播为rtsp/rtmp/flv/webrtc等协议。
  - 新增支持截图写入云存储，并从云存储加载截图。
  - deleteRecordDirectory/deleteSnapDirectory/getMP4RecordFile/getSnap接口支持云存储。
  - 采用缓存机制优化云存储读写性能，降低读写请求qps。
