#!/bin/bash

# run the container as a user to simplify writing files outside the container
docker run --rm -it -v $(pwd):$(pwd) -w $(pwd) -p 8000:8000 rbrewer123/nikola -U rbrewer -u 1000 -G rbrewer -g 1000 nikola "$@"
