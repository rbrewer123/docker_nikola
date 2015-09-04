#!/bin/bash

# run the container as a user to simplify writing files outside the container
docker run --rm -it -v $(pwd):$(pwd) -w $(pwd) rbrewer123/nikola -U rbrewer -u 1000 -G rbrewer -g 1000 nikola "$@"
