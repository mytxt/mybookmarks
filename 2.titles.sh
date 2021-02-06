#!/bin/bash
# будет расположен в source директории
# вставляет заголовок в txt файл
# и дату 
#

a=$(basename $(pwd))
if [ "$a" == "txt" ]; then echo "!!! txt !!! directory, exit"; exit -1; fi
					# проверка, не в txt ли мы
					# а то уже было

d=$(dirname "$0")
pushd $d

for i in *.md; do
	if [ "$i" = "index.md" ]; then continue; fi

	t=$(basename -s ".md" $i)
	t2=$(ls -l "$i" | awk '{ print $6" "$7" "$8  }')
#	t=$t" $t2"
	N=$(echo -n "$t" |wc -m)
	h=""
	for (( j=0; j<N; j++ )); do
		h=$h"="
	done
	# insert N"="
	sed -i "1i$h\n" "$i"
	# filename w/o extension
	r=${t//\ /\\ }
	sed -i "1i$r" "$i"

	# будет :
	# filename
	# ========

done

popd

