FROM golang:1.18-alpine3.15 as build

# dnscontrol version to install
ARG DNSCONTROL_VERSION=latest

RUN go install -v -ldflags="-s -w" github.com/StackExchange/dnscontrol/v3@${DNSCONTROL_VERSION}

FROM alpine:3.15

# hadolint ignore=DL3018
RUN apk -U --no-cache upgrade && \
    apk add --no-cache ca-certificates

COPY --from=build /go/bin/dnscontrol /usr/local/bin/dnscontrol

# Ensure dnscontrol is executable
RUN ["dnscontrol", "version"]

WORKDIR /dns

# ENTRYPOINT ["/usr/local/bin/dnscontrol"]
CMD ["dnscontrol"]