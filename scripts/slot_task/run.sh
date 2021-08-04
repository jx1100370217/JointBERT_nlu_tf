#!/bin/bash

NUM_GPUS=$1
NUM_EPOCHS=10
TASK_NAME=snips
DATA_DIR="data/input/snips_Intent_Detection_and_Slot_Filling"
OUTPUT_DIR="data/output/snips/slot_task/"

horovodrun -np ${NUM_GPUS} -H localhost:${NUM_GPUS} python3 run_slot_bert.py --task_name=${TASK_NAME} --num_train_epochs ${NUM_EPOCHS} --do_train=True --do_eval=True --data_dir=${DATA_DIR} --output_dir=${OUTPUT_DIR} |& grep -v "Read -1"

