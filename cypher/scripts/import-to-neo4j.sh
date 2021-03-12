#!/bin/bash

set -e
set -o pipefail

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ..

# start with a fresh data dir (required by the CSV importer)
mkdir -p ${NEO4J_DATA_DIR}
rm -rf ${NEO4J_DATA_DIR}/*

singularity exec --writable $NEO4J_HOME neo4j-admin import \
    --id-type=INTEGER \
    --nodes=Place="/place${NEO4J_CSV_POSTFIX}" \
    --nodes=Organisation="/organisation${NEO4J_CSV_POSTFIX}" \
    --nodes=TagClass="/tagclass${NEO4J_CSV_POSTFIX}" \
    --nodes=Tag="/tag${NEO4J_CSV_POSTFIX}" \
    --nodes=Forum="/forum${NEO4J_CSV_POSTFIX}" \
    --nodes=Person="/person${NEO4J_CSV_POSTFIX}" \
    --nodes=Message:Comment="/comment${NEO4J_CSV_POSTFIX}" \
    --nodes=Message:Post="/post${NEO4J_CSV_POSTFIX}" \
    --relationships=IS_PART_OF="/place_isPartOf_place${NEO4J_CSV_POSTFIX}" \
    --relationships=IS_SUBCLASS_OF="/tagclass_isSubclassOf_tagclass${NEO4J_CSV_POSTFIX}" \
    --relationships=IS_LOCATED_IN="/organisation_isLocatedIn_place${NEO4J_CSV_POSTFIX}" \
    --relationships=HAS_TYPE="/tag_hasType_tagclass${NEO4J_CSV_POSTFIX}" \
    --relationships=HAS_CREATOR="/comment_hasCreator_person${NEO4J_CSV_POSTFIX}" \
    --relationships=IS_LOCATED_IN="/comment_isLocatedIn_place${NEO4J_CSV_POSTFIX}" \
    --relationships=REPLY_OF="/comment_replyOf_comment${NEO4J_CSV_POSTFIX}" \
    --relationships=REPLY_OF="/comment_replyOf_post${NEO4J_CSV_POSTFIX}" \
    --relationships=CONTAINER_OF="/forum_containerOf_post${NEO4J_CSV_POSTFIX}" \
    --relationships=HAS_MEMBER="/forum_hasMember_person${NEO4J_CSV_POSTFIX}" \
    --relationships=HAS_MODERATOR="/forum_hasModerator_person${NEO4J_CSV_POSTFIX}" \
    --relationships=HAS_TAG="/forum_hasTag_tag${NEO4J_CSV_POSTFIX}" \
    --relationships=HAS_INTEREST="/person_hasInterest_tag${NEO4J_CSV_POSTFIX}" \
    --relationships=IS_LOCATED_IN="/person_isLocatedIn_place${NEO4J_CSV_POSTFIX}" \
    --relationships=KNOWS="/person_knows_person${NEO4J_CSV_POSTFIX}" \
    --relationships=LIKES="/person_likes_comment${NEO4J_CSV_POSTFIX}" \
    --relationships=LIKES="/person_likes_post${NEO4J_CSV_POSTFIX}" \
    --relationships=HAS_CREATOR="/post_hasCreator_person${NEO4J_CSV_POSTFIX}" \
    --relationships=HAS_TAG="/comment_hasTag_tag${NEO4J_CSV_POSTFIX}" \
    --relationships=HAS_TAG="/post_hasTag_tag${NEO4J_CSV_POSTFIX}" \
    --relationships=IS_LOCATED_IN="/post_isLocatedIn_place${NEO4J_CSV_POSTFIX}" \
    --relationships=STUDY_AT="/person_studyAt_organisation${NEO4J_CSV_POSTFIX}" \
    --relationships=WORK_AT="/person_workAt_organisation${NEO4J_CSV_POSTFIX}" \
    --delimiter '|'
