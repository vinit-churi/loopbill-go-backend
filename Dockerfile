# Stage 1: Build
FROM golang:1.24.2-alpine AS builder
WORKDIR /app

# Cache dependencies
COPY go.mod go.sum ./
RUN go mod download

# Build binary
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o loopbill cmd/loopbill/main.go

# Stage 2: Runtime
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/loopbill .

# Expose application port
EXPOSE 8080

# Run the Go binary
CMD ["./loopbill"]