FROM golang:1.19 AS builder
COPY . /app
WORKDIR /app
RUN CGO_ENABLED=0 GOOS=linux GO11MODULE=on go build -a -o /main .

FROM gcr.io/distroless/static-debian11:nonroot
COPY --from=builder --chown=nonroot:nonroot /main /kubernetes-event-exporter
USER nonroot
ENTRYPOINT ["/kubernetes-event-exporter"]
