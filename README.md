Dockerised MongoDB Stitch CLI
===

Introduction
---

This is a Dockerised version of the [Mongo Stitch console](https://github.com/10gen/stitch-cli).

This project will compile the Stitch binary and let you run it without any Go or NPM dependency issues. It also offers the security isolation of containers.

Usage
---

To build the image:

    docker build -t stitch-cli .

To run the image:

    docker run -it --rm stitch-cli --help

You will need to add a volume statement to the `run` command for the import/export commands, so that your project can be read or written.

The command saves authentication data in `~/.config/stitch/stitch`, so you will need to set up a folder volume for that too.

So, a workflow could look like this:

    # Log in
    docker run --rm -it --volume=/home/youruser/.config/stitch:/root/.config/stitch stitch-cli login --username=youremail@example.com --api-key=01234567-abcd-efgh-ijkl-mnopqrstuvwx

    # Check you're logged in
    docker run --rm -it --volume=/home/youruser/.config/stitch:/root/.config/stitch stitch-cli whoami

    # Import to Stitch, assumes you're in a local Stitch project folder
    docker run --rm -it --volume=/home/youruser/.config/stitch:/root/.config/stitch --volume=`pwd`:/project stitch-cli import --strategy=merge

    # Export from Stitch, this will copy it to /tmp/project/out on the host
    docker run --rm -it --volume=/home/youruser/.config/stitch:/root/.config/stitch --volume=/tmp/project:/project stitch-cli stitch-cli export --app-id=stackwatcher-prod-keysc --output=/project/out

Status
---

This has not been through much testing, but I will update these docs as I make use of it. I am also not a Go programmer, so there are undoubtedly better ways to build.

Future expansion
---

Some use of Docker Compose would be nice here, to remove the need to add volume specs on everything.

Also the export should really overwrite the on-host project automatically. That's possible with some shell scripting; on its own, the export command requires the output folder to not exist.
