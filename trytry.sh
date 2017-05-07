for filename in models/*; do
	echo "${filename}"
	file=`echo "${filename#*level}" | sed -r 's/(^|_)([a-z])/\U\2/g'`
	echo "file = ${file}"
	model="${file%Model*}Model"
	echo "model = ${model}"
	file="${file#${model}}"
	feature=`echo "${file%_*}" | sed -e 's/\([A-Z]\)/, \L\1/g' -e 's/^, //'`
	echo "${feature}"
	if [[ "${feature}" == "rgb, audio" ]]; then
		echo "1024, 128"
	else
		echo "1024"
	fi
	#echo "${file}"
	#echo `expr "$file" : '.*\(_[0-9]\)'`
	#echo "layers = ${file#*_}"
	echo
done
