FROM mcr.microsoft.com/dotnet/sdk:10.0 AS builder

WORKDIR /app

COPY . .

RUN apt-get update && \
    apt-get install -y --no-install-recommends clang zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

RUN dotnet publish BBDown -r linux-x64 -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/runtime-deps:10.0

WORKDIR /app

COPY --from=builder /app/publish .

EXPOSE 23333

# install ffmpeg
RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    chmod +x /app/BBDown

ENTRYPOINT ["/app/BBDown", "serve", "-l", "http://0.0.0.0:23333"]
