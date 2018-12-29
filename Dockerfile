FROM golang:1.9.7 as builder

ENV USER root
WORKDIR /go/src/github.com/yangl900/armclient-go
COPY . .

RUN go get -u github.com/golang/dep/cmd/dep && \
dep ensure && \
make build-docker

#WORKDIR /go/src/github.com/yangl900/armclient-go/bin/linux/amd64-static

#ENTRYPOINT ["./armclient"]
FROM golang:1.9.7-alpine
#RUN adduser -S -D -H -h /app appuser
#USER appuser
ENV USER root
COPY --from=builder /go/src/github.com/yangl900/armclient-go/bin/linux/amd64-static /app/
WORKDIR /app
ENTRYPOINT ["./armclient"]


