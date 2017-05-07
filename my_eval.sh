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
	--dir=*)
	model_dir="${i#*=}"
	shift
	;;
	*)
	;;
esac
done

. ./${config:-config.sh}

if [[ "${model_dir:-$train_dir}" != "${train_dir}" ]]; then
	train_dir="${model_dir}"
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
fi

CUDA_VISIBLE_DEVICES=${gpu:-0} \
python eval.py \
--eval_data_pattern='/share/corpus/yt8m/frame_level/validate/validate*.tfrecord' \
--model=${model} \
--train_dir=${train_dir} \
--frame_features=${frame_features} \
--feature_names="${feature_names}" \
--feature_sizes="${feature_sizes}" \
--run_once=${run_once}
