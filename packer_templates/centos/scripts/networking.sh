#!/bin/sh -eux

case "$PACKER_BUILDER_TYPE" in

virtualbox-iso|virtualbox-ovf)
    # Fix slow DNS:
    # Add 'single-request-reopen' so it is included when /etc/resolv.conf is
    # generated
    # https://access.redhat.com/site/solutions/58625 (subscription required)

    echo 'RES_OPTIONS="single-request-reopen"' >>/etc/sysconfig/network;

    if [ "$major_version" -ge 8 ]; then
        nmcli networking off
        sleep 5
        nmcli networking on
    else
        service network restart;
    fi

    echo 'Slow DNS fix applied (single-request-reopen)';
    ;;

esac
