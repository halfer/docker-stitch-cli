Dockerised MongoDB Stitch CLI
===

Introduction
---

This is a Dockerised version of the [Mongo Stitch console](https://github.com/10gen/stitch-cli).

This work will compile the command and let you run it without any Go or NPM dependency issues. It also offers the security isolation of containers.

Usage
---

To build the image:

    docker build -tag stitch-cli .

To run the image:

    docker run -it stitch-cli /root/src/stitch-cli

You will need to add volume statements to the `run` command for this to be useful - you will probably want to map your working directory to `/project` or similar, so that the command can read/write to your host's filing system.

Status
---

This has not been through much testing, but I will update these docs as I make use of it. I am also not a Go programmer, so there are undoubtedly better ways to build.
