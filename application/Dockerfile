#
# Builder
#
FROM golang:1.19 as builder

WORKDIR /tmp/build
COPY main.go .

RUN go build -o http-server main.go

#
# Runtime
#
FROM golang:1.19

COPY --from=builder /tmp/build/http-server /bin/http-server

CMD ["/bin/http-server"]
