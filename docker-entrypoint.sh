#!/bin/bash

if [ -z "${CLUSTER_NAME}" ]; then
    echo >&2 'Error:  You need to specify CLUSTER_NAME'
    exit 1
fi

if [ -z "${CLUSTER_JOIN}" ]; then
    echo >&2 'Error:  You need to specify CLUSTER_ADDRESS'
    exit 1
fi

if [ -z "${NODE_NAME}" ]; then
    NODE_NAME=`hostname`
fi

if [ -z "${LOG_FILE}" ]; then
    LOG_FILE="/dev/stdout"
fi

exec /usr/bin/garbd --name ${NODE_NAME} --group ${CLUSTER_NAME} --address gcomm://${CLUSTER_JOIN}
