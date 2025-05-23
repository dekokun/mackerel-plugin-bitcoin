FROM golang:1.24-bookworm AS plugin-build

WORKDIR /go/app

COPY go.sum go.mod ./
RUN go mod download

COPY . .
RUN make build

FROM mackerel/mackerel-container-agent:v0.11.5

COPY --from=plugin-build /go/app/mackerel-plugin-bitcoin /usr/local/bin

ENTRYPOINT ["/usr/local/bin/mackerel-container-agent"]
