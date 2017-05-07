CUDA_VISIBLE_DEVICES=0 \
python inference.py \
--input_data_pattern='/share/corpus/yt8m/frame_level/test/test*.tfrecord' \
--output_file=models/frame_level_grid_lstm_model_rgb_audio/predictions.csv \
--train_dir=models/frame_level_grid_lstm_model_rgb_audio \
--model=GridLstmModel \
--frame_features=True \
--feature_names="rgb, audio" \
--feature_sizes="1024, 128" \
--batch_size=2048
#--run_once=True
#--base_learning_rate=0.0002 \
#--lstm_layers=5
