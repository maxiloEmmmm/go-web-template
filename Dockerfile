FROM golang:1.13.7 as builder
WORKDIR /usr/src/app
ENV GO111MODULE=on
COPY . .
RUN CGO_ENABLED=0 go build -ldflags "-s -w" -mod=vendor -o server *.go

FROM hairyhenderson/upx:latest as zip
WORKDIR /app
COPY --from=builder /usr/src/app/server /app/server
RUN upx server -5 -o _upx_server && \
 mv -f _upx_server server && chmod 777 server

FROM scratch as runner
COPY --from=builder /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=zip /app/server /opt/app/
CMD ["/opt/app/server"]