#!/bin/bash

set -e
set -o pipefail

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo ===============================================================================
echo Loading the Neo4j database with the following parameters
echo -------------------------------------------------------------------------------
echo NEO4J_DATA_DIR: ${NEO4J_DATA_DIR}
echo NEO4J_CSV_POSTFIX: ${NEO4J_CSV_POSTFIX}
echo NEO4J_VERSION: ${NEO4J_VERSION}
echo NEO4J_ENV_VARS: ${NEO4J_ENV_VARS}
echo ===============================================================================

: ${NEO4J_HOME:?"Environment variable NEO4J_HOME is unset or empty"}
# env vars can be empty, hence no check is required


echo "./stop-neo4j.sh"
./stop-neo4j.sh
echo "./delete-neo4j-database.sh"
./delete-neo4j-database.sh
echo "./import-to-neo4j.sh"
./import-to-neo4j.sh
echo "./start-neo4j.sh"
./start-neo4j.sh
echo "./create-indices.sh"
./create-indices.sh
