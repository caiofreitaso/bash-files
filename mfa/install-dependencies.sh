#!/bin/bash

APTITUDE_LOCATION=$( [ -f /usr/bin/aptitude ] && echo /usr/bin/aptitude )
DPKG_WRAPPER=${APTITUDE_LOCATION:-apt-get}

echo "Found ${DPKG_WRAPPER}"

$DPKG_WRAPPER install oathtool gnupg2 xclip
