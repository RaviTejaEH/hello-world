#!/bin/sh

DC_VERSION="latest"
DC_DIRECTORY=$HOME/owasp-Dependency-Check
DC_PROJECT="dependency-check scan: $(pwd)"
DATA_DIRECTORY="$DC_DIRECTORY/data"
CACHE_DIRECTORY="$DC_DIRECTORY/data/cache"

if [ ! -d "$DATA_DIRECTORY" ]; then
    echo "Initially creating persistent directory: $DATA_DIRECTORY"
    mkdir -p "$DATA_DIRECTORY"
fi
if [ ! -d "$CACHE_DIRECTORY" ]; then
    echo "Initially creating persistent directory: $CACHE_DIRECTORY"
    mkdir -p "$CACHE_DIRECTORY"
fi

# Make sure we are using the latest version
docker pull owasp/dependency-check

docker run -d --name dependency-check -e user=$USER -u $(id -u ${USER}):$(id -g ${USER}) --volume $(pwd):/src:z --volume "$DATA_DIRECTORY":/usr/share/dependency-check/data:z --volume $(pwd)/odc-reports:/report:z owasp/dependency-check --scan /src --format "ALL" --project "$DC_PROJECT"  --out /report
    # -e user=$USER \
    # -u $(id -u ${USER}):$(id -g ${USER}) \
    # --volume $(pwd):/src:z \
    # --volume "$DATA_DIRECTORY":/usr/share/dependency-check/data:z \
    # --volume $(pwd)/odc-reports:/report:z \
    # owasp/dependency-check \
    # --scan /src \
    # --format "ALL" \
    # --project "$DC_PROJECT" \
    # --out /report
    # Use suppression like this: (where /src == $pwd)
    # --suppression "/src/security/dependency-check-suppression.xml"
