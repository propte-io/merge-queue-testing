#!/bin/bash

#! REQUIRED: CURRENT_TAG, STAGE, ROLLBACK_DIRECTION

#! CONSTANTS
MIGRATION_SCRIPTS_PATH="./migrations"

# step 1: checkout the current tag
echo "CURRENT_TAG=$CURRENT_TAG"
git fetch origin $CURRENT_TAG
git checkout -b $CURRENT_TAG origin/$CURRENT_TAG

# step 2: get the previous tag
PREVIOUS_TAG=`git describe --abbrev=0 --tags --exclude="$(git describe --abbrev=0 --tags)"`
echo "PREVIOUS_TAG: $PREVIOUS_TAG"

# step 3: checkout the previous tag
git fetch origin $PREVIOUS_TAG
git checkout -b $PREVIOUS_TAG origin/$PREVIOUS_TAG

echo "CHECKOUT COMPLETED"

# # step 4: get the latest migration file
# LATEST_MIGRATION_FILE=`ls -ltr $MIGRATION_SCRIPTS_PATH | awk 'NR==2{print $9}'`
# echo "LATEST_MIGRATION_FILE: $LATEST_MIGRATION_FILE"

# step 5: checkout the current tag
git checkout $CURRENT_TAG
echo "CHECKOUT COMPLETED"


# step 6: get migration scripts
# MIGRATION_SCRIPTS=`ls -ltr $MIGRATION_SCRIPTS_PATH | awk '$9 > "2023-08-21-User.fullName.ts" {print $9}'`

# if [[ "$ROLLBACK_DIRECTION" == "down" ]]; then
#   MIGRATION_SCRIPTS=`echo "$MIGRATION_SCRIPTS" | awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'`
# fi

# step 7: run migration script
# yarn install
# yarn nx build platform --stage $STAGE

echo "MIGRATION SCRIPTS ARE BEING RUN"
echo "$MIGRATION_SCRIPTS"

# for MIGRATION_FILE_PATH in $MIGRATION_SCRIPTS
# do
#   AWS_PROFILE=$STAGE yarn nx dataloader:migrate:$ROLLBACK_DIRECTION platform --stage $STAGE --file $MIGRATION_FILE_PATH
# done
