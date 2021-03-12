#!/bin/bash

set -e
set -o pipefail

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ..

if [ ! -d ${NEO4J_DATA_DIR} ]; then
    echo "Neo4j data directory does not exist"
    exit 1
fi

export NEO4JLABS_PLUGINS='["apoc", "graph-data-science"]'

singularity exec --writable $NEO4J_HOME neo4j start

echo "Waiting for the database to start..."
until singularity exec --writable $NEO4J_HOME cypher-shell "RETURN 'Database has started successfully' AS message"; do
    sleep 1
done
