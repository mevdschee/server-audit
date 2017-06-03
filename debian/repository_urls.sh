#!/bin/bash
apt-cache policy | grep -io "http[^ ]* [^ /]*" | sort | uniq
