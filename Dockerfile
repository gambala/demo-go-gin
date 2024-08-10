# Use the official Golang image as a build stage
FROM golang:1.22.1-alpine AS builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY . .

# Build the Go app
RUN go build -o server .

# Start a new stage from scratch
FROM alpine:latest

# Install curl for Kamal health checks
RUN apk add --no-cache curl

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/server /app/server

# Expose port 1323 to the outside world
EXPOSE 1323

# Command to run the executable
CMD ["/app/server"]
