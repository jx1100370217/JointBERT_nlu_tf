python3 run_intent_bert.py \
  --task_name=Snips \
  --do_predict=True \
  --data_dir=data/input/snips_Intent_Detection_and_Slot_Filling \
  --init_checkpoint=data/output/snips/intent_task/ \
  --output_dir=data/res/snips/intent_task/
