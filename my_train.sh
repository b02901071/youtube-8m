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
hr -H python train.py \
--train_data_pattern='../youtube-8m/frame_features/train*.tfrecord' \
--model=${model} \
--train_dir=${train_dir} \
--frame_features=${frame_features} \
--feature_names="${feature_names}" \
--feature_sizes="${feature_sizes}" \
--base_learning_rate=${base_learning_rate} \
--batch_size=${train_batch_size} \
--lstm_layers=${lstm_layers} \
--max_steps=${max_steps} \
--iterations=50 \
--tied=${tied} 
