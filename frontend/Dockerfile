# --- Build stage ---
FROM golang:1.24 AS builder
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o frontend .

# --- Run stage ---
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/frontend .
COPY --from=builder /app/static ./static
COPY --from=builder /app/templates ./templates
EXPOSE 8080
CMD ["./frontend"]
