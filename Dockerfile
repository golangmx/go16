FROM ubuntu:14.04

RUN apt-get update

RUN apt-get install -y curl ca-certificates gcc build-essential git

RUN curl --silent https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz | tar -xvzf - -C /usr/local

ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

ENV SLIDEDIR $GOPATH/src/github.com/golangmx/go16

RUN mkdir -p $SLIDEDIR

COPY ./ $SLIDEDIR

RUN go get golang.org/x/tools/cmd/present

WORKDIR $SLIDEDIR

EXPOSE 3999

ENTRYPOINT ["present", "-http", "0.0.0.0:3999", "-orighost", "go16.golang.mx"]
