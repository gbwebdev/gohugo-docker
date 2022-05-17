FROM golang:1.18.2-alpine3.15 AS builder

ARG HUGO_VERSION=0.99.0

RUN mkdir /build \
    && apk add build-base \
    && wget https://github.com/gohugoio/hugo/archive/refs/tags/v${HUGO_VERSION}.tar.gz -O /tmp/hugo.tar.gz \
    && tar -xzf /tmp/hugo.tar.gz -C /build --strip-components 1 

WORKDIR /build

RUN go build -ldflags="-extldflags=-static" --tags extended

FROM scratch

COPY --from=builder /build/hugo /hugo

