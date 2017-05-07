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

. ./${config:-config.sh}

CUDA_VISIBLE_DEVICES=${gpu:-0} \
python inference.py \
--input_data_pattern='/share/corpus/yt8m/frame_level/test/test*.tfrecord' \
--model=${model} \
--train_dir=${train_dir} \
--frame_features=${frame_features} \
--feature_names=${feature_names} \
--feature_sizes=${feature_sizes} \
--output_file=${test_output_file} \
--batch_size=${test_batch_size}
