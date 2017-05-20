model=GridLstmModel
frame_features=True
feature_names="rgb, audio"
feature_sizes="1024, 128"
lstm_layers=2
tied=True
models_dir=models

base_learning_rate=0.0002
train_batch_size=256
test_batch_size=2048
max_steps=$((150000*256/${train_batch_size}))
run_once=True

model_underscore=`echo ${model} | sed -e 's/\([A-Z]\)/_\L\1/g' -e 's/^_//'`
feature_names_underscore=`echo ${feature_names} | sed -e 's/, /_/'`

if [[ "$tied" == True ]]; then
	train_dir=frame_level_tied
else
	train_dir=frame_level
fi
train_dir=${train_dir}_${model_underscore}_${feature_names_underscore}
if [[ ${lstm_layers} -ne 2 ]]; then
	train_dir=${train_dir}_${lstm_layers}_layers
fi
if [[ "${all_models}" != "" ]]; then
	mkdir ${all_models}/${train_dir}
	ln -s ${all_models}/${train_dir} ${models_dir}/${train_dir}
fi
train_dir=${models_dir}/${train_dir}
