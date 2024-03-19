#!/bin/bash
PY_VER=$(python --version | grep -Po "3.\\d+")
cat $HOME/lseg/zscaler-cert.pem >> $VIRTUAL_ENV/lib/python$PY_VER/site-packages/pip/_vendor/certifi/cacert.pem
