# Build the manager binary
FROM docker.io/golang:1.20 as builder
WORKDIR /workspace
COPY . /workspace
# Build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o cluster-autoscaler main.go

FROM gcr.io/distroless/static:nonroot-amd64
COPY --from=builder /workspace/cluster-autoscaler /cluster-autoscaler

ENTRYPOINT [/cluster-autoscaler]
