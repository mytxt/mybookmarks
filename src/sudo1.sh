#!/bin/bash
case $EUID in
   0) : cool we are already root - fall through ;;
   *) # not root, become root for the rest of this session
      # (and ask for the sudo password only once)
      sudo $0 "$@" ;;
esac
# now the present process is effective-UID  (root)
# so there's no need to put sudo in front of commands
