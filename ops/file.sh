version() { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }

CURRENT_TAG="1.3.0"
TO_TAG="1.0.0"

# git tag -l | awk -v FROM_TAG=$FROM_TAG -v TO_TAG=$TO_TAG 'version $0 > version $FROM_TAG && version $0 < version $TO_TAG {print$1}'

PREVIOUS_TAG=`git tag -l | awk -v CURRENT_TAG=$CURRENT_TAG 'version $0 < version CURRENT_TAG {print$1}' | awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }' | awk 'NR==1 {print; exit}'`

echo "$PREVIOUS_TAG"