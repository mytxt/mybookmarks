#!/bin/bash

d=$(dirname "$0")
pushd $d

# cat index.h > index.txt

echo ".. TXT documentation

TXT Tutorials
==========================

Contents:

.. toctree::
   :maxdepth: 2
   " > index.md

for i in *.md; do
    f=$(basename -s .md "$i")
    if [ "$f" == "index" ]; then continue; fi
    r=${i//\·/\\·}
    printf "   %s\n" "$r" >> index.md
done

#scp -r -q /home/max/Documents/txt k52f.local:/home/max/Documents
#exo-open 'http://site.k52f.local'

popd
