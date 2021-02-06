#!/bin/bash

trap "e=$?; echo $e; echo 'Interrupted.'; exit $e" INT
trap "echo Exit" EXIT

asksure() {
echo
echo -n "Are you sure (Y/N)? "
while read -r -n 1 -s answer; do
  if [[ $answer = [YyNn] ]]; then
    [[ $answer = [Yy] ]] && retval=0
    [[ $answer = [Nn] ]] && retval=1
    break
#  else
#    echo $?
  fi
done

echo # just a final linefeed, optics...

return $retval
}

### using it
if asksure; then
  echo "Okay, performing rm -rf / then, master...."
else
  echo "Pfff..."
fi
