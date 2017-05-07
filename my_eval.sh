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
python eval.py \
--eval_data_pattern='/share/corpus/yt8m/frame_level/validate/validate*.tfrecord' \
--model=${model} \
--train_dir=${train_dir} \
--frame_features=${frame_features} \
--feature_names=${feature_names} \
--feature_sizes=${feature_sizes} \
--run_once=${run_once}
#--lstm_layers=${lstm_layers}
