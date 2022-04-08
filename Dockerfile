FROM golang:1.18-alpine3.15 as build

ARG DNSCONTROL_VERSION=v3.15.0

RUN go install -v github.com/StackExchange/dnscontrol/v3@${DNSCONTROL_VERSION}

FROM alpine:3.15

# hadolint ignore=DL3018
RUN apk -U --no-cache upgrade && \
    apk add --no-cache ca-certificates

# Fetch dnscontrol release
COPY --from=build /go/bin/dnscontrol /usr/local/bin/dnscontrol

WORKDIR /dns

# Ensure dnscontrol is executable
RUN ["dnscontrol", "version"]

CMD ["dnscontrol"]