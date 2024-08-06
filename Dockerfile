# Build stage
FROM golang:1.20-alpine AS build

WORKDIR /app

COPY webserver/go.mod webserver/go.sum ./
RUN go mod download

COPY webserver/ ./
RUN go build -o webserver .

# Final stage
FROM alpine:latest

WORKDIR /root/

COPY --from=build /app/webserver .

CMD ["./webserver"]
