[![img](https://img.shields.io/github/stars/f22363712-dotcom/BBDown?label=%E7%82%B9%E8%B5%9E)](https://github.com/f22363712-dotcom/BBDown)  [![img](https://img.shields.io/github/last-commit/f22363712-dotcom/BBDown?label=%E6%9C%80%E8%BF%91%E6%8F%90%E4%BA%A4)](https://github.com/f22363712-dotcom/BBDown)  [![img](https://img.shields.io/github/release/f22363712-dotcom/BBDown?label=%E6%9C%80%E6%96%B0%E7%89%88%E6%9C%AC)](https://github.com/f22363712-dotcom/BBDown/releases)  [![img](https://img.shields.io/github/license/f22363712-dotcom/BBDown?label=%E8%AE%B8%E5%8F%AF%E8%AF%81)](https://github.com/f22363712-dotcom/BBDown)

> ⚠️ **本仓库说明**
>
> 本仓库是 [nilaoda/BBDown](https://github.com/nilaoda/BBDown) 的社区维护分支。
> 原项目已于 **2026年5月14日** 被作者归档（只读状态），本分支接替维护，包含原项目 master 分支的所有最新代码修复。
>
> **主要变更：**
> - 目标框架从 `net9.0` 升级到 `net10.0`（适配 .NET 10 运行时环境）
> - 版本号更新为 1.6.4
> - 包含所有上游 master 分支的最新代码修复（合集API适配、断点续传修复等）
>
> 本项目仅供个人学习、研究和非商业性用途。用户在使用本工具时，需自行确保遵守相关法律法规，特别是与版权相关的法律条款。

# BBDown
一个命令行式哔哩哔哩下载器. Bilibili Downloader.

# 环境要求

### 运行时要求
- **Windows 10/11** 或 **Linux** 或 **macOS**
- **[.NET 10.0 运行时](https://dotnet.microsoft.com/download/dotnet/10.0)**（必须安装）

> 本版本基于 .NET 10 编译。如果你运行时报错 `You must install or update .NET to run this application`，说明没有安装 .NET 运行时，请下载安装：
> - Windows: https://dotnet.microsoft.com/en-us/download/dotnet/10.0
> - 或使用命令：`winget install Microsoft.DotNET.Runtime.10`

### 外部依赖（混流用）
本软件合并视频/音频时需要外部程序：

* **ffmpeg**（推荐）：https://www.gyan.dev/ffmpeg/builds/
* 或 **mp4box**：https://gpac.wp.imt.fr/downloads/

下载后将 ffmpeg.exe 所在目录加入系统 PATH，或使用 `--ffmpeg-path` 参数指定路径。

# 快速开始

## Windows 用户

### 方法一：下载 Release 版本（推荐）
1. 前往 [Releases](https://github.com/f22363712-dotcom/BBDown/releases) 页面
2. 下载最新版本的 `BBDown_1.6.4_win-x64.zip`
3. 解压到任意目录（如 `D:\BBDown`）
4. 打开命令行（CMD 或 PowerShell），进入解压目录：`cd D:\BBDown`
5. 开始使用

### 方法二：通过 dotnet tool 安装
```
dotnet tool install --global BBDown
```

## macOS / Linux 用户
```
dotnet tool install --global BBDown
```

# 详细使用教程

## 第一步：登录 B 站账号

### 扫码登录（推荐）
```
BBDown login
```
程序会生成二维码，用手机 B 站 App 扫码即可登录。Cookie 自动保存到 `BBDown.data`，后续使用无需重复登录。

### 使用 Cookie 登录（手动方式）
```
BBDown -c "SESSDATA=******" "视频地址"
```

## 第二步：下载视频

### 下载普通视频
```
BBDown "https://www.bilibili.com/video/BV1qt4y1X7TW"
```

### 仅下载音频
```
BBDown --audio-only "https://www.bilibili.com/video/BV1jy421B7Qz"
```

### 仅下载视频（无音频）
```
BBDown --video-only "https://www.bilibili.com/video/BV1qt4y1X7TW"
```

### 仅下载弹幕 / 封面 / 字幕
```
BBDown --danmaku-only "视频地址"
BBDown --cover-only "视频地址"
BBDown --sub-only "视频地址"
```

### 使用 TV 接口下载（无水印片源）
```
BBDown -tv "https://www.bilibili.com/video/BV1qt4y1X7TW"
```

### 指定画质
```
BBDown -q "8K 超高清, 1080P 高码率, HDR 真彩, 杜比视界" "视频地址"
```

### 指定编码格式
```
BBDown -e "hevc,av1,avc" "视频地址"
```

## 多分P下载

```
# 单个分P
BBDown -p 10 "视频地址"

# 多个分P
BBDown -p 1,2,10 "视频地址"

# 范围分P
BBDown -p 1-10 "视频地址"

# 下载所有分P（番剧全集）
BBDown -p ALL "https://www.bilibili.com/bangumi/play/ss33073"

# 下载最新分P
BBDown -p LAST "视频地址"
```

## 合集/列表/收藏夹下载
直接粘贴链接即可：
```
BBDown "https://www.bilibili.com/medialist/play/..."
BBDown "https://www.bilibili.com/space/.../collection/..."
```

## 番剧下载
```
BBDown "https://www.bilibili.com/bangumi/play/ss33073"
BBDown -p ALL "https://www.bilibili.com/bangumi/play/ss33073"
```

## 仅查看视频信息（不下载）
```
BBDown -info "视频地址"
```

## 使用 aria2c 加速下载
```
BBDown -aria2 "视频地址"
```

# 命令行参考

```
Description:
  BBDown是一个免费且便捷高效的哔哩哔哩下载/解析软件.

Usage:
  BBDown <url> [command] [options]

Arguments:
  <url>  视频地址 或 av|bv|BV|ep|ss

Options:
  -tv, --use-tv-api                              使用TV端解析模式
  -app, --use-app-api                            使用APP端解析模式
  -intl, --use-intl-api                          使用国际版(东南亚视频)解析模式
  --use-mp4box                                   使用MP4Box来混流
  -e, --encoding-priority <encoding-priority>    视频编码的选择优先级, 用逗号分割
  -q, --dfn-priority <dfn-priority>              画质优先级,用逗号分隔
  -info, --only-show-info                        仅解析而不进行下载
  --show-all                                     展示所有分P标题
  -aria2, --use-aria2c                           调用aria2c进行下载
  -ia, --interactive                             交互式选择清晰度
  -hs, --hide-streams                            不要显示所有可用音视频流
  -mt, --multi-thread                            使用多线程下载(默认开启)
  --video-only                                   仅下载视频
  --audio-only                                   仅下载音频
  --danmaku-only                                 仅下载弹幕
  --sub-only                                     仅下载字幕
  --cover-only                                   仅下载封面
  --debug                                        输出调试日志
  --skip-mux                                     跳过混流步骤
  --skip-subtitle                                跳过字幕下载
  --skip-cover                                   跳过封面下载
  --force-http                                   下载音视频时强制使用HTTP协议替换HTTPS
  -dd, --download-danmaku                        下载弹幕
  --skip-ai                                      跳过AI字幕下载
  --video-ascending                              视频升序
  --audio-ascending                              音频升序
  --allow-pcdn                                   不替换PCDN域名
  -F, --file-pattern <file-pattern>              自定义单P存储文件名
  -M, --multi-file-pattern <multi-file-pattern>  自定义多P存储文件名
  -p, --select-page <select-page>                选择指定分p或分p范围
  --language <language>                          设置混流的音频语言
  -c, --cookie <cookie>                          设置字符串cookie
  -token, --access-token <access-token>          设置access_token
  --work-dir <work-dir>                          设置程序的工作目录
  --ffmpeg-path <ffmpeg-path>                    设置ffmpeg的路径
  --version                                      显示版本信息
  -?, -h, --help                                 显示帮助信息

Commands:
  login    通过APP扫描二维码以登录您的WEB账号
  logintv  通过APP扫描二维码以登录您的TV账号
  serve    以服务器模式运行
```

## 文件命名变量

| 代码 | 含义 |
|------|------|
| `<videoTitle>` | 视频主标题 |
| `<pageNumber>` | 视频分P序号 |
| `<pageNumberWithZero>` | 视频分P序号(前缀补零) |
| `<pageTitle>` | 视频分P标题 |
| `<bvid>` | 视频BV号 |
| `<aid>` | 视频aid |
| `<cid>` | 视频cid |
| `<dfn>` | 视频清晰度 |
| `<res>` | 视频分辨率 |
| `<fps>` | 视频帧率 |
| `<videoCodecs>` | 视频编码 |
| `<videoBandwidth>` | 视频码率 |
| `<audioCodecs>` | 音频编码 |
| `<audioBandwidth>` | 音频码率 |
| `<ownerName>` | 上传者名称 |
| `<ownerMid>` | 上传者mid |
| `<publishDate>` | 发布时间 |
| `<apiType>` | API类型 |

# 配置文件

BBDown支持读取本地配置文件，默认读取程序同目录下的 `BBDown.config` 文件。

一个典型的配置文件:
```
# 以#开头的行会被忽略
--file-pattern
<videoTitle>[<dfn>]

--multi-file-pattern
<videoTitle>/[P<pageNumberWithZero>]<pageTitle>[<dfn>]

--delay-per-page
2

--download-danmaku
```

# 鉴权方式

## WEB鉴权
```
# 扫码登录
BBDown login

# 手动加载cookie
BBDown -c "SESSDATA=******" "https://www.bilibili.com/video/BV1qt4y1X7TW"
```

## TV鉴权
```
# 扫码登录云视听小电视
BBDown logintv

# 手动加载token
BBDown -tv -token "******" "https://www.bilibili.com/video/BV1qt4y1X7TW"
```

## APP鉴权
抓包获取access_token后：
```
BBDown -app -token "******" "https://www.bilibili.com/video/BV1qt4y1X7TW"
```

# API服务器
```
BBDown serve -l http://0.0.0.0:12450
```
详细API参考[json-api-doc.md](./json-api-doc.md)

# 常见问题

## Q: 运行报错 `输入有误`
A: 请使用最新版本。旧版 v1.6.3 因 Bilibili API 变更已无法正常使用。

## Q: 运行报错 `You must install or update .NET to run this application`
A: 请安装 .NET 10.0 运行时：https://dotnet.microsoft.com/en-us/download/dotnet/10.0

## Q: 登录报错 `The type initializer for 'Gdip' threw an exception`
A: 请参考 [原项目 #37](https://github.com/nilaoda/BBDown/issues/37)

## Q: 下载视频没有声音或没有画面
A: 请确保已安装 ffmpeg 并加入 PATH。

## Q: 下载速度慢
A: 尝试使用 aria2c：`BBDown -aria2 "视频地址"`，或使用 `--force-http`。

# 功能
- [x] 番剧下载(Web|TV|App)
- [x] 课程下载(Web)
- [x] 普通内容下载(Web|TV|App)
- [x] 合集/列表/收藏夹/个人空间解析
- [x] 多分P自动下载
- [x] 选择指定分P进行下载
- [x] 选择指定清晰度进行下载
- [x] 下载外挂字幕并转换为srt格式
- [x] 自动合并音频+视频流+字幕流+章节信息
- [x] 单独下载视频/音频/字幕
- [x] 二维码登录账号
- [x] 多线程下载
- [x] 支持调用aria2c下载
- [x] 支持AVC/HEVC/AV1编码
- [x] 支持8K/HDR/杜比视界/杜比全景声下载
- [x] 自定义存储文件名

# TODO
- [ ] 自动刷新cookie
- [ ] 支持更多自定义选项

# 致谢
- 原项目作者 [nilaoda](https://github.com/nilaoda)
- https://github.com/codebude/QRCoder
- https://github.com/icsharpcode/SharpZipLib
- https://github.com/protocolbuffers/protobuf
- https://github.com/grpc/grpc
- https://github.com/dotnet/command-line-api
- https://github.com/SocialSisterYi/bilibili-API-collect
- https://github.com/SeeFlowerX/bilibili-grpc-api
- https://github.com/FFmpeg/FFmpeg
- https://github.com/gpac/gpac
- https://github.com/aria2/aria2
