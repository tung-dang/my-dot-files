#!/usr/bin/env sh

set -e

geAbsPath() {
    echo "$(cd "$(dirname "$1")"; pwd)/$(basename "$1")";
}

## Create symbolic links between 2 files
main() {
    from=$(geAbsPath "$1")
    to=$(geAbsPath "$2")

    if [[ -z "${from}" ]]; then
        echo "Missing 'from' parameter"
        exit 1;
    fi

    if [[ -z "${to}" ]]; then
        echo "Missing 'to' parameter"
        exit 1;
    fi

    echo "Linking from $from to $to"

    rm -f "$to"
    ln -s "$from" "$to"

    echo "- linked $1 to $2"
}

main "$@"