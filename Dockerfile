FROM golang:1.27-alpine@sha256:d200d2dd76b03a99b52651fd1325aff7dcd35422c35c01bac56571b0507f3deb AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -ldflags="-s -w" -o demo-api .

FROM ghcr.io/cujarrett/base-go:static-debian13@sha256:c52fc98ed00a23a3301b396062feb4385e86dd64fa1a6549ffa39791b2317904
COPY --from=builder /app/demo-api /demo-api
EXPOSE 8080
ENTRYPOINT ["/demo-api"]
