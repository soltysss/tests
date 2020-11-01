FROM golang:latest AS builder

WORKDIR /
ARG VERSION=1.5.0
RUN git clone https://github.com/drone-runners/drone-runner-docker.git && \
    cd drone-runner-docker && \
    git checkout v$VERSION

WORKDIR /drone-runner-docker

# Drone upstream build instructions
# HEAD: 4b10e95195e5552f5c0b5dc38bafcc402f60fd92
# ----------------------------------------------

ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
RUN go build

FROM alpine:3.6 as alpine
RUN apk add -U --no-cache ca-certificates

FROM alpine:3.6
EXPOSE 3000

ENV GODEBUG netdns=go
ENV DRONE_PLATFORM_OS=linux
ENV DRONE_PLATFORM_ARCH=amd64

COPY --from=alpine /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

LABEL com.centurylinklabs.watchtower.stop-signal="SIGINT"

# End-of: Drone upstream build instructions

COPY --from=builder /drone-runner-docker/drone-runner-docker /bin/

ENTRYPOINT ["/bin/drone-runner-docker"]