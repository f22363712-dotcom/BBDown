# BBDown 全面部署与使用指南

> 本文档适用于 `f22363712-dotcom/BBDown` 社区维护分支。
> 当前版本基于 .NET 10 和 Native AOT 发布，主要用于个人学习、研究和非商业用途。

## 一、环境准备

### 1. 安装 BBDown

推荐从 GitHub Releases 下载当前社区维护分支发布包：

1. 打开 https://github.com/f22363712-dotcom/BBDown/releases
2. 按系统选择对应压缩包，例如 `win-x64`、`linux-x64`、`osx-arm64`
3. 解压后在终端进入解压目录
4. 运行 `BBDown --help` 验证

使用 Releases 中的 Native AOT 单文件版本时，通常不需要额外安装 .NET 运行时。

如果使用源码运行、`dotnet tool` 或框架依赖发布版本，需要安装 .NET 10 SDK/Runtime：

```bash
dotnet --version
```

### 2. 安装 FFmpeg

BBDown 合并音视频流时需要 FFmpeg 或 MP4Box，推荐 FFmpeg。

Windows:

```powershell
# 下载并解压 FFmpeg 后，将 bin 目录加入 PATH
ffmpeg -version
```

Linux:

```bash
sudo apt-get install ffmpeg
ffmpeg -version
```

macOS:

```bash
brew install ffmpeg
ffmpeg -version
```

也可以使用 `--ffmpeg-path` 指定 FFmpeg 可执行文件路径。

### 3. 可选安装 aria2c

需要外部下载器加速时安装 aria2c，并通过 `-aria2` 启用：

```bash
BBDown -aria2 "视频链接"
```

## 二、登录授权

公开视频通常可以直接解析；需要更高清晰度、会员内容、TV/App 接口时，建议先登录。

网页登录：

```bash
BBDown login
```

TV 登录：

```bash
BBDown logintv
```

手动传入 Cookie 或 token：

```bash
BBDown -c "SESSDATA=******" "视频链接"
BBDown -tv -token "******" "视频链接"
```

## 三、常用下载命令

下载普通视频：

```bash
BBDown "https://www.bilibili.com/video/BVxxxxxx"
```

使用 TV 接口：

```bash
BBDown -tv "视频链接"
```

仅下载音频：

```bash
BBDown --audio-only "视频链接"
```

仅下载弹幕、字幕或封面：

```bash
BBDown --danmaku-only "视频链接"
BBDown --sub-only "视频链接"
BBDown --cover-only "视频链接"
```

下载弹幕并保留视频：

```bash
BBDown -dd "视频链接"
```

指定画质与编码优先级：

```bash
BBDown -q "8K 超高清, 1080P 高码率, HDR 真彩, 杜比视界" "视频链接"
BBDown -e "hevc,av1,avc,flac,eac3,m4a" "视频链接"
```

## 四、批量与分 P

选择单个分 P：

```bash
BBDown -p 3 "视频链接"
```

选择多个分 P：

```bash
BBDown -p 1,2,10 "视频链接"
```

选择范围：

```bash
BBDown -p 1-10 "视频链接"
```

下载全部分 P 或番剧全集：

```bash
BBDown -p ALL "视频链接"
```

下载最新分 P：

```bash
BBDown -p LAST "视频链接"
```

## 五、文件命名与输出目录

指定工作目录：

```bash
BBDown --work-dir "D:\MyVideos" "视频链接"
```

自定义单 P 文件名：

```bash
BBDown -F "<videoTitle>[<dfn>]" "视频链接"
```

自定义多 P 文件名：

```bash
BBDown -M "<videoTitle>/[P<pageNumberWithZero>]<pageTitle>[<dfn>]" "视频链接"
```

常用变量：

| 变量 | 说明 |
| --- | --- |
| `<videoTitle>` | 视频主标题 |
| `<pageNumber>` | 分 P 序号 |
| `<pageNumberWithZero>` | 补零后的分 P 序号 |
| `<pageTitle>` | 分 P 标题 |
| `<bvid>` | BV 号 |
| `<aid>` | aid |
| `<cid>` | cid |
| `<dfn>` | 清晰度 |
| `<res>` | 分辨率 |
| `<fps>` | 帧率 |
| `<videoCodecs>` | 视频编码 |
| `<audioCodecs>` | 音频编码 |
| `<ownerName>` | 上传者名称 |
| `<publishDate>` | 收藏夹/番剧/合集发布时间 |
| `<videoDate>` | 视频发布时间 |
| `<apiType>` | API 类型 |

## 六、配置文件

默认读取程序同目录下的 `BBDown.config`，也可以用 `--config-file` 指定。

示例：

```text
# 以 # 开头的行会被忽略
--file-pattern
<videoTitle>[<dfn>]

--multi-file-pattern
<videoTitle>/[P<pageNumberWithZero>]<pageTitle>[<dfn>]

--delay-per-page
2

--download-danmaku
```

## 七、知识库场景模板

仅保留音频和弹幕，适合转写、摘要和知识库整理：

```bash
BBDown --audio-only -dd "视频链接"
```

使用 TV 接口并下载全集：

```bash
BBDown -tv -p ALL "番剧或合集链接"
```

使用 aria2c 控制并发：

```bash
BBDown -aria2 --aria2c-args "-x4 -s4 -j4 -k 2M" "视频链接"
```

## 八、源码构建与发版

基础构建：

```bash
git clone https://github.com/f22363712-dotcom/BBDown.git
cd BBDown
dotnet build BBDown.sln -c Release
dotnet run --project BBDown -- --help
```

Native AOT 发布：

```bash
dotnet publish BBDown -r win-x64 -c Release -o artifact
```

如果遇到 `Platform linker not found`，请安装当前平台所需的本机编译工具链：

- Windows: Visual Studio 的 Desktop development with C++ 工作负载
- Linux: `clang`、`zlib1g-dev`
- macOS: Xcode Command Line Tools

## 九、常见问题

### 找不到 FFmpeg

确认 FFmpeg 已加入 PATH，或使用 `--ffmpeg-path` 指定路径。

### 提示需要安装 .NET

说明当前使用的是框架依赖版本，安装 .NET 10 Runtime/SDK 后重试。

### Native AOT 发布失败

优先检查本机编译工具链是否安装完整。普通 `dotnet build` 成功不代表 Native AOT 发布环境也完整。

### 下载没有声音或没有画面

通常是音视频未混流或 FFmpeg 不可用。先确认 FFmpeg，再检查是否使用了 `--skip-mux`。

## 十、合规提醒

- 仅用于个人学习、研究和非商业用途。
- 不要传播、售卖、二次发布受版权保护的内容。
- 下载和使用内容前请确认你有相应授权。
