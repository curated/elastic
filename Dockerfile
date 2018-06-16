FROM golang:1.10 AS build
WORKDIR $GOPATH/src/github.com/curated/elastic
ADD https://github.com/golang/dep/releases/download/v0.4.1/dep-linux-amd64 /usr/bin/dep
RUN chmod +x /usr/bin/dep
COPY Gopkg.toml Gopkg.lock ./
RUN dep ensure --vendor-only
COPY . ./
COPY ./config/config.prod.json /
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags="-w -s" -o /app .

FROM scratch
COPY --from=build /config.prod.json config/
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /app ./
EXPOSE 1323
ENTRYPOINT ["/app", "-logtostderr=true"]
