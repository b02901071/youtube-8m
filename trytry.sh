for filename in models/*; do
	echo "${filename}"
	file=`echo "${filename#*/}" | sed -r 's/(^|_)([a-z])/\U\2/g'`
	echo "file = ${file}"
	echo "level = ${file%Level*}_level"
	file="${file#*Level}"
	model="${file%Model*}Model"
	file="${file#${model}}"
	echo "model = ${model}"
	feature=`echo "${file%_*}" | sed -e 's/\([A-Z]\)/, \L\1/g' -e 's/^, //'`
	echo "${feature}"
	echo "${file}"
	echo `expr "$file" : '.*\(_[0-9]\)'`
	#echo "layers = ${file#*_}"
	echo
done
