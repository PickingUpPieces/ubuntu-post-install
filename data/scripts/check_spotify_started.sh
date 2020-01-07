#!/bin/bash

COUNT=$(ps aux | grep spotify | wc -l)
if [ $COUNT -lt 4 ]; then
  exec /snap/bin/spotify &
fi
