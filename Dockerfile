# Docker image for the Mongo Stitch command

FROM golang:alpine AS build

# Do a system update
# No need to put this into separate steps.
RUN apk update && apk add git curl

# Declare base dir
WORKDIR /go/src/github.com/10gen/stitch-cli

RUN git clone https://github.com/10gen/stitch-cli.git .

# Remove the old dependencies
RUN rm -rf vendor

# Fetch the dependencies
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

# We build in case all depencies are pulled in corrctly.
RUN dep ensure && go build

# Second stage build to just expose the command
FROM alpine:3.9

# Set new default folder
WORKDIR /project

# Do a system update
# We can run it in one step, as it is more likely that an update
# is available than that ca-certificates have changed
RUN apk update && apk add --no-cache ca-certificates

COPY --from=build /go/src/github.com/10gen/stitch-cli/stitch-cli /usr/bin/

ENTRYPOINT ["/usr/bin/stitch-cli"]
