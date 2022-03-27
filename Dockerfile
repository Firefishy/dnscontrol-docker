FROM alpine:3.15

ARG DNSCONTROL_VERSION=v3.15.0

# hadolint ignore=DL3018
RUN apk add --no-cache ca-certificates curl libc6-compat

# Fetch dnscontrol release
RUN curl -S -f -L -o /usr/local/bin/dnscontrol https://github.com/StackExchange/dnscontrol/releases/download/${DNSCONTROL_VERSION}/dnscontrol-Linux \
    && chmod +x /usr/local/bin/dnscontrol

WORKDIR /dns

# Ensure dnscontrol is executable
RUN ["dnscontrol", "version"]

CMD ["dnscontrol"]