#!/usr/bin/env bash
# this removes all pyc file under this location - recursively

export SKYWALKER_HOME=/opt/dev/skywalker # For dalloway, arturo

find ${SKYWALKER_HOME} -name "*.pyc" -exec rm '{}' ';'
