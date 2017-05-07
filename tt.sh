echo "./$config"

for i in "$@"
do
case $i in
	--gpu=*)
	gpu=${i#*=}
	shift
	;;
	--config=*)
	config="${i#*=}"
	shift
	;;
	*)
	;;
esac
done

echo "./$config"

. ./${config:-config.sh}

model_dir=models/frame_level_grid_lstm_model_mean_rgb
if [[ "${model_dir:-$train_dir}" != "${train_dir}" ]]; then
	file=`echo "${model_dir#*level}" | sed -r 's/(^|_)([a-z])/\U\2/g'`
	model="${file%Model*}Model"
	file="${file#${model}}"
	feature_names=`echo "${file%_*}" | sed -e 's/\([A-Z]\)/, \L\1/g' -e 's/^, //'`
	if [[ "${feature_names}" == "rgb, audio" ]]; then
		feature_sizes="1024, 128"
	elif [[ "${feature_names}" == "rgb" ]]; then
		feature_sizes="1024"
	elif [[ "${feature_names}" == "audio" ]]; then
		feature_sizes="128"
	else
		echo "Are you really using frame level features?"
		exit
	fi
	echo $model
	echo $feature_names
	echo $feature_sizes
	exit
fi
echo $train_dir
