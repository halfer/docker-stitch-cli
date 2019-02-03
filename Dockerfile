# Docker image for the Mongo Stitch command

FROM golang:alpine AS build

# Do a system update
RUN apk update

RUN apk add git curl

# Declare base dir
WORKDIR /root/src

RUN git clone https://github.com/10gen/stitch-cli.git

WORKDIR /root/src/stitch-cli

# Remove the old dependencies
RUN rm -rf vendor

# Fetch the dependencies
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
RUN GOPATH=$GOPATH:/root dep ensure

# Now it should build
RUN GOPATH=$GOPATH:/root go build

# Second stage build to just expose the command
FROM alpine:3.9

# Do a system update
RUN apk update

# Add required stuff
RUN apk add ca-certificates

COPY --from=build /root/src/stitch-cli/stitch-cli /usr/bin/

CMD ["/bin/sh"]
