# !/bin/bash

dockerExecBash () {
    docker exec -it $1 bash
}

dockerExecSh () {
    docker exec -it $1 sh
}
