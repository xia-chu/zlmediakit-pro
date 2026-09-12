# zlmediakit pro Closed-Source Professional Edition

[简体中文](./README.md) | English

## Introduction

Built on top of the latest open-source zlmediakit codebase with extensive feature enhancements, we now present the closed-source professional edition.
This repository is the distribution channel for the professional edition, providing feature descriptions, technical documentation, and binary downloads.
The professional edition requires a valid license to unlock pro-only features. If the license fails validation or expires, the software falls back to the open-source edition with identical features and usage.

## Contact

- WeChat: xiachuziyue
- Email: 1213642868@qq.com

## Notice

zlmediakit pro does not provide source-code licensing by default (negotiable at a suitable price); only binary usage licenses are offered. Commercial deployment requires purchasing an activation key.
For licensing prices, please refer to the [License Pricing Table](https://github.com/xia-chu/zlmediakit-pro/wiki/%E6%8E%88%E6%9D%83%E5%AE%9A%E4%BB%B7%E8%A1%A8).

## How to Enable Pro Features

- Download the binary:
  Click the [download link](https://github.com/xia-chu/zlmediakit-pro/issues) and pick the package that matches your target OS.

- Trial usage:
  On startup the program triggers online trial activation. Each machine gets a 15-day full-feature, full-quota trial by default; the trial must run outside docker, and each machine may trial only once by default.

- Online activation:
  Activation requires internet access. Start MediaServer with the argument `--key xxxxxxx` to supply the activation code, or set `api.key` in the config file.

- Offline activation:
  Start MediaServer with the `--req` argument. The program will generate a `licence_req.txt` file in the same directory. Copy that file, upload it to the [license site](https://licence.zlmediakit.com/) to complete activation, download the resulting `licence.txt` certificate, place it back into the same directory, and restart MediaServer.

- Offline operation:
  Once activated, the program writes a `licence.txt` certificate to the current directory, and subsequent runs no longer require network access.

- Trial or license expiry: The program falls back to the open-source edition with identical usage and features.

- To obtain activation codes, revoke or reuse codes, extend a trial, or enable docker trials, please contact me.


## Features

- Audio/Video Transcoding
  - 1. Arbitrary transcoding across audio/video codecs (including h265/h264/opus/g711/aac/g722/g722.1/mp3/svac/vp8/vp9/av1, etc.).
  - 2. Config-file-driven transcoding with bitrate, codec type and other parameters.
  - 3. Dynamic transcoding add/remove via HTTP API with bitrate, resolution scaling, codec type, filters and other parameters.
  - 4. Adaptive hardware/software transcoding.
  - 5. On-demand transcoding — only transcodes when viewers are present. Supports transparent transcoding, so business logic stays unaware of transcoding and requires zero code changes.
  - 6. Under heavy load, transcoding proactively lowers frame rate without introducing visual artifacts (glitches).
  - 7. Filter support, including OSD text overlays and logo watermarks.
  - 8. Full-GPU hardware encode/decode and filtering, avoiding frequent VRAM-to-RAM copies.
  - 9. Secondary development on FFmpeg to support the private g722.1 and svac decoders.
  - 10. Multi-GPU parallel transcoding with automatic load balancing.

- JT1078 (Chinese National Standard)
  - 1. Accepts JT1078 publishing and converts it to other protocols; adapts to both shared-seq and separate-seq modes for audio/video.
  - 2. Supports JT1078 cascading and JT1078 intercom.
  - 3. JT1078 APIs, ports and usage remain compatible with GB28181.
  - 4. Supports h264/h265/g711/aac/mp3/g721/g722/g723/g729/g726/adpcm codecs.

- IPTV
  - 1. Origin pull from rtsp-ts/hls/http-ts/rtp-multicast/udp-multicast with protocol conversion; supports TS passthrough that skips demuxing and converts directly to rtsp-ts/hls/http-ts/srt.
  - 2. Accepts rtsp-ts/srt/rtp-ts publishing; supports TS passthrough that skips demuxing and converts directly to rtsp-ts/hls/http-ts/srt.
  - 3. The above features also support demuxing TS into ES streams and re-converting to rtsp/rtmp/flv/http-ts/hls/hls-fmp4/mp4/fmp4/webrtc.

- S3 Cloud Storage
  - 1. Direct in-memory stream writes to s3/minio cloud storage, eliminating the recording-file I/O bottleneck.
  - 2. Download and on-demand playback of cloud-stored files directly through zlmediakit's built-in HTTP service.
  - 3. Enumerate cloud-stored files and generate an HTTP menu web page.
  - 4. Fully in-memory S3 read/write path — no disk involvement and no disk I/O bottleneck.
  - 5. Record MP4/HLS to cloud storage; play MP4 back from cloud storage as rtsp/rtmp/flv/webrtc.
  - 6. Cloud-storage read/write is supported for the vast majority of file types.

- AI Inference
  - 1. YOLO inference plugin with person/vehicle and other object recognition, object tracking, polygon arming zones, OCR, and rapid C++/Python hybrid plugin development.
  - 2. TensorRT full-CUDA-accelerated inference.
  - 3. ONNXRuntime (CPU/GPU) inference.
  - 4. Sophgo (Bitmain) platform inference.
  - 5. Huawei Ascend platform inference.
  - 6. Python plugins can call C++ APIs to operate media streams and draw on the current video frame.
  - 7. Multi-GPU parallel inference with automatic load balancing.
  - 8. Multi-thread, multi-instance parallel inference; real-time inference is achievable even for CPU-published streams.
  - 9. Resource inspection, rate limiting, circuit breaking, latency/frame-rate statistics, exception protection and reporting; supports real-time and sampling modes.
  - 10. Event-point snapshot, retrospective recording, and MQTT push.
  - 11. Rich post-inference business logic and HTTP APIs.

- WebRTC Cluster
  - 1. RTC traffic proxying, which resolves the Kubernetes deployment issue where HTTP signaling and RTC traffic fail to land on the same zlmediakit WebRTC pod instance.

- WebRTC MCU Voice Chat Room
  - 1. MCU-based multi-party voice chat room with pre-mix background noise suppression and silence exclusion from the mix, solving the SFU scalability limits for very large voice rooms.
  - 2. Supports 100 concurrent voice speakers and thousand-plus listener-scale conferences.
  - 3. Supports SFU video conferencing over a single PeerConnection with multiple m-lines, and simulcast multi-resolution streams.


## Technical Documentation

Please refer to this repository's [wiki](https://github.com/xia-chu/zlmediakit-pro/wiki).


## Binary Downloads

Download the latest binaries for each platform at the bottom of the [release list](https://github.com/xia-chu/zlmediakit-pro/issues/3). All non-onnx builds include every pro feature except AI inference. Because the onnx builds depend on a Python environment and are more involved to deploy, they are provided separately:

- Linux build:

    Compiled on CentOS 7. Supports the svac and g722.1 custom decoders. Dependencies built with vcpkg. Supports cuda, qsv, amf, aom, opencl, openh264, vpx, vulkan and other codecs.

- Linux ARM build:

    Functionally equivalent to the standard Linux build, with svac and g722.1 custom decoder support removed. Compiled on kylin:v10sp1-aarch64.

- Linux onnx build:

    Adds ONNX CPU inference on top of the standard Linux build. Requires a Python runtime; Python 3.11 must be installed via miniconda before launch.

- Linux trt118 build:

    Adds TensorRT (11.8) GPU-accelerated inference on top of the standard Linux build. Full hardware encode/decode + TensorRT inference + CUDA acceleration, with an all-VRAM pipeline for peak performance. Depends on Python 3.9 and supports older NVIDIA GPU models.

- Linux trt129 build:

    Adds TensorRT (12.9) GPU-accelerated inference on top of the standard Linux build. Full hardware encode/decode + TensorRT inference + CUDA acceleration, with an all-VRAM pipeline for peak performance. Depends on Python 3.12 and supports newer NVIDIA GPU models (e.g., RTX 50-series).

- Linux Jetson build:

    Functionally equivalent to the Linux trt build with TensorRT inference support, running on NVIDIA Jetson (ARM) JetPack 3.5.

- Linux Jetson2 build:

    Functionally equivalent to the Linux trt build with TensorRT inference support, running on NVIDIA Jetson (ARM) JetPack 3.6.

- Linux CANN build:

    Built on openEuler 22 (aarch64). Supports Huawei Ascend hardware encode/decode and AI inference.

- Windows build:

    Comprehensive feature support. Dependencies built with vcpkg. Supports cuda, qsv, amf, aom, dav1d, opencl, openh264, vpx, vulkan and other codecs.

- Windows onnx build:

    Adds ONNX CUDA inference on top of the standard Windows build. Requires a Python runtime plus CUDA and cuDNN environments.

- [Windows trt build](https://github.com/xia-chu/zlmediakit-pro/releases/download/release/windows-trt-2026-1-20.zip):

    Adds CUDA + TensorRT inference on top of the standard Windows build. Requires a Python 3.14 + CUDA 12 runtime.

- macOS build:

    Supports aom, openh264, vpx, videotoolbox and other codecs.

- macOS onnx build:

    Adds ONNX CoreML inference on top of the standard macOS build. Requires a Python runtime; `brew install python@3.14` must be run before launch.


## Docker Downloads

Docker images support x86_64 and arm64 platforms, hardware codecs, and s3 cloud storage, with a full feature set.
```bash
docker run -id -p 1935:1935 -p 8080:80 -p 8443:443 -p 8554:554 -p 10000:10000 -p 10000:10000/udp -p 8000:8000/udp -p 9000:9000/udp zlmediakit/zlmediakit-pro:feature_all
```
