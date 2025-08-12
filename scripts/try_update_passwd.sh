#!/bin/bash

log() {
    echo "$@"
    logger -t try_update_passwd "$@"
}

passwd_file="/home/ubuntu/k0rdent-passwd"
if [ ! -f $passwd_file ]; then
    log "Password file is missing."
    exit 0
fi

required_passwd=$(cat "$passwd_file")
current_passwd=$(kubectl get deployment -n kcm-system kcm-k0rdent-ui -o json | jq -r '.spec.template.spec.containers[0].env[3].value')
if [[ "$required_passwd" == "$current_passwd" ]]; then
    log "Required password equal to the current one. No update needed."
    exit 0
fi

helm upgrade -i kcm oci://registry.mirantis.com/k0rdent-enterprise/charts/k0rdent-enterprise --version 1.1.0-rc9 -n kcm-system --set "k0rdent-ui.auth.basic.password='$required_passwd'"
log "Password updated"
