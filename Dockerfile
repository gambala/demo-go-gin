FROM golang:1.22.1-alpine AS builder
  WORKDIR /app
  COPY go.mod go.sum ./
  RUN go mod download # Will be cached if the go.mod and go.sum files are not changed
  COPY . .
  RUN go build -o server .


FROM alpine:latest
  COPY --from=builder /app/server /app/server
  EXPOSE 1323
  CMD ["/app/server"]
