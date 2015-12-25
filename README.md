# test18180: Checker for docker/docker#18180 (container hangs up)

[linux@296291cd](https://github.com/torvalds/linux/commit/296291cd) caused a regression [docker/docker#18180](https://github.com/docker/docker/issues/18180).

This container check whether [docker/docker#18180](https://github.com/docker/docker/issues/18180) has been resolved.
    
    $ docker run -it --rm akihirosuda/test18180
    [INFO] Checking whether hitting docker#18180.
    [INFO] OK. not hitting docker#18180.
    [INFO] Checking whether sendfile(2) is killable.
    [INFO] If the container hangs up here, you are still facing the bug that linux@296291cd tried to fix.
    [INFO] OK. sendfile(2) is killable.
    [INFO] PERFECT!

Note that you won't be able to see the above "PERFECT" output with any kernel at the moment.. (Dec 25, 2015)
