FROM golang:1.27-alpine@sha256:70bd7ddea8b6cbe5d6943cde279d6b67feb10cc924fb9100d1d8757c1575b280 AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -ldflags="-s -w" -o demo-api .

FROM ghcr.io/cujarrett/base-distroless:static-debian13@sha256:76a6ba0713608e3fcca0246b7c1989bbedfcff9809cab66fb6d9388bc091938c
COPY --from=builder /app/demo-api /demo-api
EXPOSE 8080
ENTRYPOINT ["/demo-api"]
