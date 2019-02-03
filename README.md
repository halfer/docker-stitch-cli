Dockerised MongoDB Stitch CLI
===

Introduction
---

This is a Dockerised version of the [Mongo Stitch console](https://github.com/10gen/stitch-cli).

This project will compile the Stitch binary and let you run it without any Go or NPM dependency issues. It also offers the security isolation of containers.

Usage
---

To build the image:

    docker build -tag stitch-cli .

To run the image:

    docker run -it stitch-cli stitch-cli --help

You will need to add volume statements to the `run` command for this to be useful - you will probably want to map your working directory to `/project` or similar, so that the command can read/write to your host's filing system.

The command saves authentication data in `~/.config/stitch/stitch`, so it would make sense to set up a folder volume for that too.

So, a workflow could look like this:

    # Log in
    docker run --volume=/home/youruser/.config/stitch:/root/.config/stitch -it stitch-cli stitch-cli login --username=youremail@example.com --api-key=01234567-abcd-efgh-ijkl-mnopqrstuvwx

    # Check you're logged in
    docker run --volume=/home/youruser/.config/stitch:/root/.config/stitch -it stitch-cli whoami

    # Assumes you're in a local Stitch project folder
    docker run --volume=/home/youruser/.config/stitch:/root/.config/stitch --volume=`pwd`:/root -it stitch-cli stitch-cli import --strategy=merge

Status
---

This has not been through much testing, but I will update these docs as I make use of it. I am also not a Go programmer, so there are undoubtedly better ways to build.

Future expansion
---

Some use of Docker Compose would be nice here, to remove the need to add volume specs on everything.
