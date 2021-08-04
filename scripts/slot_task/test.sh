python3 run_slot_bert.py \
  --task_name=Snips \
  --do_predict=True \
  --data_dir=data/input/snips_Intent_Detection_and_Slot_Filling \
  --init_checkpoint=data/output/snips/slot_task/ \
  --output_dir=data/res/snips/slot_task/
