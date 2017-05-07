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
test_output_file=${train_dir}/predictions.csv

CUDA_VISIBLE_DEVICES=${gpu:-0} \
python inference.py \
--input_data_pattern='/share/corpus/yt8m/frame_level/test/test*.tfrecord' \
--model=${model} \
--train_dir=${train_dir} \
--frame_features=${frame_features} \
--feature_names="${feature_names}" \
--feature_sizes="${feature_sizes}" \
--output_file=${test_output_file} \
--batch_size=${test_batch_size}
