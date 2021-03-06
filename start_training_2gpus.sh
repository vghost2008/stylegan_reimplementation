# Need to have environmental variables LOG_DIR and DATA_DIR set
# DATA_DIR should have tfrecord files as generated by https://github.com/NVlabs/stylegan/blob/master/dataset_tool.py
# This is an example for generating rectagular images with aspect ratio 8:4 h:w.  Unless your images are that 
# aspect ratio, you'll need to change start_res_h to 4 and res_w to 512 (if you want the final resolution to be 512x512)
horovodrun -np 2 -H localhost:2 python run.py \
    --train \
    --ngpus 2 \
    --res_w  256 \
    --res_h 512 \
    --start_res_w 4  \
    --start_res_h 8 \
    --batch_size  "{4: 256, 8: 192, 16: 192, 32: 64, 64: 32, 128: 8, 256:8}" \
    --epochs_per_res  30  \
    --loss  non_saturating \
    --gp  r1 \
    --lambda_drift 0.0 \
    --lambda_gp  10  \
    --ncritic  1  \
    --model_dir $LOG_DIR \
    --input_file_regex  "$DATA_DIR/*.tfrecords" \
    --learning_rate  .001 \
    --optimizer  adam \
    --steps_per_save 10000
