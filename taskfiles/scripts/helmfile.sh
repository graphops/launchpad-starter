#!/bin/bash

COMMAND=$1; shift
NAMESPACE=$1; shift
RELEASE=$1; shift

set -e

NS_DIR="$(pwd)/helmfiles/namespace-releases"
NAMESPACE_FILE_PATH="${NS_DIR}/${NAMESPACE}.yaml"

usage(){
    echo "Invalid usage."
    echo
    echo "Arguments:"
    echo "<command> The Helmfile command to use. $([ -z "$COMMAND" ] && echo ❌ Not specified || echo ✅ Current value is $COMMAND)."
    echo "<namespace> Must be a valid namespace releases file. $([ -z "$NAMESPACE" ] && echo ❌ Not specified || echo Current value is $NAMESPACE. $([ ! -f "$NAMESPACE_FILE_PATH" ] && echo ❌ Expected file $NAMESPACE_FILE_PATH does not exist || echo Expected file ✅ $NAMESPACE_FILE_PATH exists))."
    echo "[release-name] Optionally select a single release"
    exit 1
}

if [ -z "$NAMESPACE" ] || [ ! -f "$NAMESPACE_FILE_PATH" ]; then
    usage
fi

SELECTOR=""
if [ ! -z "$RELEASE" ]; then
    SELECTOR="--selector=name=$RELEASE"
fi

DEBUG_LOGS=""
if [ "$LAUNCHPAD_VERBOSE_LOGS" = "true" ]; then
    DEBUG_LOGS="--debug"
fi

if [ "$NAMESPACE" = "sealed-secrets" ] && [ "$COMMAND" != "status" ]; then
    TEXT="You are about to modify the $NAMESPACE namespace.

Deleting the sealed-secrets controller will render all existing SealedSecrets invalid.

Make sure you have backup copies of all your secrets. Are you sure you want to continue?"
    gum confirm	--prompt.foreground "#ff0000" "$TEXT"
fi

set -x
helmfile $DEBUG_LOGS --interactive -f "$NAMESPACE_FILE_PATH" $SELECTOR $COMMAND "$@"
