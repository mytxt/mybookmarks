#!/bin/bash

udisksctl info -b /dev/sda4 | grep -i mountpoints | awk -F: '{print $2}' | awk '{ if ($1=="") {system("udisksctl mount -b /dev/sda4")} else {system("udisksctl unmount -b /dev/sda4")} }'
