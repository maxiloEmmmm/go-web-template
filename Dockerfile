FROM golang:1.13.7 as builder
WORKDIR /usr/src/app
ENV GOPROXY=https://goproxy.cn
RUN apt-get update && apt-get install -y xz-utils \
    && rm -rf /var/lib/apt/lists/*
ADD https://github.com/upx/upx/releases/download/v3.95/upx-3.95-amd64_linux.tar.xz /usr/local
RUN xz -d -c /usr/local/upx-3.95-amd64_linux.tar.xz | tar -xOf - upx-3.95-amd64_linux/upx > /bin/upx && \
    chmod a+x /bin/upx
COPY ./go.mod ./
COPY ./go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -ldflags "-s -w" -o server *.go &&\
 upx server -5 -o _upx_server && \
 mv -f _upx_server server && chmod 777 server

FROM scratch as runner
COPY --from=builder /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /usr/src/app/server /opt/app/
EXPOSE 8080
CMD ["/opt/app/server"]