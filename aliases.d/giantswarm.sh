#!/usr/bin/env bash


alias pluigi='pbpaste | command luigi --no-color | vi -'

onduty() {
    local token="$GOPATH/src/keybase.io/kopiczko/dotfiles/token/slack"
    if [[ ! -f $token ]]; then
        echo "ERROR file \"$token\" does not exist" >&2
        return 1
    fi

    docker run --rm -ti -e SLACK_TOKEN=$(cat $GOPATH/src/keybase.io/kopiczko/dotfiles/token/slack) giantswarm/slackutil join --include "support.*"
    #docker run --rm -ti -e SLACK_TOKEN=$(cat $GOPATH/src/keybase.io/kopiczko/dotfiles/token/slack) giantswarm/slackutil join --include "project.*"
    docker run --rm -ti -e SLACK_TOKEN=$(cat $GOPATH/src/keybase.io/kopiczko/dotfiles/token/slack) giantswarm/slackutil unmute --include "support.*"
    #docker run --rm -ti -e SLACK_TOKEN=$(cat $GOPATH/src/keybase.io/kopiczko/dotfiles/token/slack) giantswarm/slackutil unmute --include "project.*"
    #docker run --rm -ti -e SLACK_TOKEN=$(cat $GOPATH/src/keybase.io/kopiczko/dotfiles/token/slack) giantswarm/slackutil star --include "support.*"
}

dutyend() {
    local token="$GOPATH/src/keybase.io/kopiczko/dotfiles/token/slack"
    if [[ ! -f $token ]]; then
        echo "ERROR file \"$token\" does not exist" >&2
        return 1
    fi

    docker run --rm -ti -e SLACK_TOKEN=$(cat $GOPATH/src/keybase.io/kopiczko/dotfiles/token/slack) giantswarm/slackutil unstar --include "support.*"
    docker run --rm -ti -e SLACK_TOKEN=$(cat $GOPATH/src/keybase.io/kopiczko/dotfiles/token/slack) giantswarm/slackutil leave --include "support-.*"
    docker run --rm -ti -e SLACK_TOKEN=$(cat $GOPATH/src/keybase.io/kopiczko/dotfiles/token/slack) giantswarm/slackutil leave --include "project.*"
}

vault-decrypt() {
        echo ===================================================================;echo
        echo $1 | xxd -r -p | keybase pgp decrypt
        echo;echo
        echo ===================================================================
}

vault-decrypt2() {
        echo ====================================================================;echo
        echo $1 | base64 -d | keybase pgp decrypt
        echo;echo
        echo ====================================================================
}
