# test18180: Checker for docker/docker#18180 (container hangs up)

[Available at Docker Hub](https://hub.docker.com/r/akihirosuda/test18180/)

## What's this?
[linux@296291cd](https://github.com/torvalds/linux/commit/296291cd) caused a regression [docker/docker#18180](https://github.com/docker/docker/issues/18180), which leads some processes (Java, MongoDB..) to hang up in a weird zombie state when they are running on Docker with AUFS.

This container checks whether you can hit [docker/docker#18180](https://github.com/docker/docker/issues/18180).
    
    $ docker run -it --rm akihirosuda/test18180
    [INFO] Checking whether hitting docker#18180.
    ....................................................................................................
    [INFO] OK. not hitting docker#18180.
    [INFO] Checking whether sendfile(2) is killable.
    [INFO] If the container hangs up here, you are still facing the bug that linux@296291cd tried to fix.
    /test.sh: line 43:  1411 Killed                  /sendfile-test
    [INFO] OK. sendfile(2) is killable when ( Fri Mar 18 10:34:09 UTC 2016 - Fri Mar 18 10:34:04 UTC 2016  => 5s ) and exit code 137 != 0.	

All the major distros have already fixed the issue: https://github.com/docker/docker/issues/18180#issuecomment-193708192

## Example failure cases
### boot2docker [v1.9.1](https://github.com/boot2docker/boot2docker/tree/v1.9.1) (includes [linux@296291cd](https://github.com/torvalds/linux/commit/296291cd))

    $ export VIRTUALBOX_BOOT2DOCKER_URL=https://github.com/boot2docker/boot2docker/releases/download/v1.9.1/boot2docker.iso
    $ docker-machine create --driver=virtualbox dm1
    $ eval "$(docker-machine env dm1)"
    $ docker run -it --rm akihirosuda/test18180
    [INFO] Checking whether hitting docker#18180.
    (hangs up here)

### my boot2docker [v1.9.1-fix1](https://github.com/AkihiroSuda/boot2docker/tree/v1.9.1-fix1) (_excludes_ [linux@296291cd](https://github.com/torvalds/linux/commit/296291cd))

    $ export VIRTUALBOX_BOOT2DOCKER_URL=https://github.com/AkihiroSuda/boot2docker/releases/download/v1.9.1-fix1/boot2docker-v1.9.1-fix1.iso
    $ docker-machine create --driver=virtualbox dm2
    $ eval "$(docker-machine env dm2)"
    $ docker run -it --rm akihirosuda/test18180
    [INFO] Checking whether hitting docker#18180.
    [INFO] OK. not hitting docker#18180.
    [INFO] Checking whether sendfile(2) is killable.
    [INFO] If the container hangs up here, you are still facing the bug that linux@296291cd tried to fix.
	(hangs up here)
