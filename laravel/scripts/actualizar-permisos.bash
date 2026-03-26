#!/bin/bash
# vi: ts=8 sw=4 sts=4 et filetype=sh
#
# SPDX-License-Identifier: GPL-3.0-or-later


DIRECTORY=${1:-.}

sudo chown -R $USER:www-data ${DIRECTORY}

find ${DIRECTORY} -type f -exec chmod 660 {} \;
find ${DIRECTORY} -type d -exec chmod 750 {} \;

find ${DIRECTORY}/storage/   -type d -exec chmod 770 {} \;
find ${DIRECTORY}/database/  -type d -exec chmod 770 {} \;
find ${DIRECTORY}/bootstrap/ -type d -exec chmod 770 {} \;

chmod 770 ${DIRECTORY}/artisan ${DIRECTORY}/scripts ${DIRECTORY}/scripts/* 
