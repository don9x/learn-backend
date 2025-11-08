# Step 1: Build the Go binary
FROM golang:1.25 AS builder

WORKDIR /app

# Copy go mod files and download dependencies first (better caching)
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the source
COPY . .

# Build statically linked binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -o server .

# Step 2: Run with a minimal image
FROM alpine:latest

WORKDIR /root/

# Copy the binary from builder
COPY --from=builder /app/server .

# Expose port (optional, adjust to your app)
EXPOSE 8080

# Command to run the binary
CMD ["./server"]
