FROM n8nio/n8n:latest
USER root

ARG TARGETARCH
RUN set -eux; \
    case "$TARGETARCH" in \
      amd64) FF_URL="https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz"; BIN_DIR_GLOB="/tmp/ffmpeg-*-amd64-static" ;; \
      arm64) FF_URL="https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-arm64-static.tar.xz"; BIN_DIR_GLOB="/tmp/ffmpeg-*-arm64-static" ;; \
      *) echo "Unsupported arch: $TARGETARCH" && exit 1 ;; \
    esac; \
    wget -O /tmp/ffmpeg.tar.xz "$FF_URL"; \
    tar -xf /tmp/ffmpeg.tar.xz -C /tmp; \
    mv $BIN_DIR_GLOB/ffmpeg /usr/local/bin/ffmpeg; \
    mv $BIN_DIR_GLOB/ffprobe /usr/local/bin/ffprobe; \
    chmod +x /usr/local/bin/ffmpeg /usr/local/bin/ffprobe; \
    rm -rf /tmp/ffmpeg*

USER node
