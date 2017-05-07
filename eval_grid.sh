CUDA_VISIBLE_DEVICES=1 \
python eval.py \
--eval_data_pattern='/share/corpus/yt8m/frame_level/validate/validate*.tfrecord' \
--model=GridLstmModel \
--train_dir=models/frame_level_grid_lstm_model_rgb_audio \
--frame_features=True \
--feature_names="rgb, audio" \
--feature_sizes="1024, 128" \
--run_once=True
#--base_learning_rate=0.0002 \
#--batch_size=256 #\
#--lstm_layers=5
