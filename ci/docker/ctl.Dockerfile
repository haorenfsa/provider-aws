
FROM golang:1.17-alpine AS builder

RUN apk add --no-cache git

ARG GITHUB_USER
ARG GITHUB_TOKEN

WORKDIR /go/src/github.com/haorenfsa/provider-aws

COPY go.mod go.sum ./
COPY cmd ./cmd
COPY apis  ./apis
COPY internal  ./internal
RUN mkdir -p ./bin && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./bin/crossplane-aws-provider ./cmd/provider

FROM alpine:3.13

COPY --from=builder /go/src/github.com/haorenfsa/provider-aws/bin/crossplane-aws-provider /usr/bin/crossplane-aws-provider

EXPOSE  8080
USER 65532:65532
ENTRYPOINT ["/usr/bin/crossplane-aws-provider"]