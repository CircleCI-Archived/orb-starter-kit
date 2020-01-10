#!/bin/bash
_cleanup() {
    echo "     ...cleaning up"
    rm -rf orb.yml
    rm -rf _init
    rm /tmp/cci_config_opts
    rm config.yml.bak
    rm config.yml
    echo "     ...init script removed"
}