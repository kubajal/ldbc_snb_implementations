#!/bin/bash

set -e
set -o pipefail

singularity exec --writable $NEO4J_HOME neo4j stop
