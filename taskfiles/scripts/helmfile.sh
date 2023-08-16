#!/bin/bash

COMMAND=$1; shift

SELECTOR=""

if [[ -n "$1" ]] && [[ ! "$1" =~ '=' ]]; then
    SELECTOR+="--selector=namespace=$1"; shift
fi

if [[ -n "$1" ]] && [[ ! "$1" =~ '=' ]]; then
    SELECTOR+=",name=$1"; shift
fi

if [[ -z "$SELECTOR" ]] && [[ "$#" -gt 0 ]]; then
    SELECTOR+="--selector="
fi

IFS="," SELECTOR+=$(echo "$*")

set -e

usage(){
    echo "Invalid usage."
    echo
    echo "Arguments:"
    echo "<command> The Helmfile command to use. $([ -z "$COMMAND" ] && echo ❌ Not specified || echo ✅ Current value is $COMMAND)."
    echo "<namespace> Must be a valid namespace. $([ -z "$NAMESPACE" ] && echo ❌ Not specified || echo Current value is $NAMESPACE. $([ ! -f "$NAMESPACE_FILE_PATH" ] && echo ❌ Expected file $NAMESPACE_FILE_PATH does not exist || echo Expected file ✅ $NAMESPACE_FILE_PATH exists))."
    echo "[release-name] Optionally select a single release"
    exit 1
}

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
helmfile $DEBUG_LOGS --interactive -f "$NAMESPACE_FILE_PATH" --skip-diff-on-install $SELECTOR $COMMAND "$@"
