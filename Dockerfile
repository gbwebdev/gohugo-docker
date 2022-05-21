FROM golang:1.18.2-alpine3.15 AS builder

ARG HUGO_VERSION=0.99.0

RUN mkdir /build \
    && apk add build-base \
    && wget https://github.com/gohugoio/hugo/archive/refs/tags/v${HUGO_VERSION}.tar.gz -O /tmp/hugo.tar.gz \
    && tar -xzf /tmp/hugo.tar.gz -C /build --strip-components 1 

WORKDIR /build

RUN go build -ldflags="-extldflags=-static" --tags extended


FROM alpine:3.15


ENV FORMAT="yaml"


COPY --from=builder /build/hugo /usr/bin/
COPY --chown=hugo:root entrypoint /entrypoint

RUN apk add bash bash-completion \
    && adduser -D -u 1000 -s /bin/bash -h /hugo hugo \
    && hugo completion bash > /usr/share/bash-completion/completions/hugo \
    && chmod +x /entrypoint \
    && mkdir /mnt/workdir \
    && chown hugo /mnt/workdir

USER hugo
WORKDIR /mnt/workdir
EXPOSE 1313

ENTRYPOINT ["/entrypoint"]