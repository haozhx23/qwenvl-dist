#!/bin/bash

set -ex

# You can use 2B instead of 7B
# MODEL_NAME="Qwen/Qwen2-VL-7B-Instruct"
# MODEL_NAME="Qwen/Qwen2-VL-2B-Instruct"
MODEL_NAME="Qwen/Qwen2.5-VL-3B-Instruct"
# MODEL_NAME="Qwen/Qwen2.5-VL-7B-Instruct"

export PYTHONPATH=src:$PYTHONPATH
# export PYTHONPATH=$PYTHONPATH:/docker_workdir/Qwen2-VL-Finetune

GLOBAL_BATCH_SIZE=1
BATCH_PER_DEVICE=1
NUM_DEVICES=1
GRAD_ACCUM_STEPS=$((GLOBAL_BATCH_SIZE / (BATCH_PER_DEVICE * NUM_DEVICES)))


# deepspeed src/training/train.py \
#   --master_port=$MASTER_PORT \
torchrun \
  --nproc_per_node=$NPROC_PER_NODE \
  --nnodes=$NNODES \
  --rdzv_backend=$RDZV_BACKEND \
  --rdzv_endpoint=$RDZV_ENDPOINT \
  --rdzv_id=$RDZV_ID \
  elastic-ddp.py
# src/training/train.py \
#     --use_liger True \
#     --deepspeed scripts/zero3_offload.json \
#     --model_id $MODEL_NAME \
#     --data_path /mnt/fsx/qwenvl-data/data.json \
#     --image_folder /mnt/fsx/qwenvl-data/imgs \
#     --remove_unused_columns False \
#     --freeze_vision_tower False \
#     --freeze_llm False \
#     --tune_merger True \
#     --bf16 True \
#     --fp16 False \
#     --disable_flash_attn2 False \
#     --output_dir /mnt/fsx/modeloutputs \
#     --num_train_epochs 1 \
#     --per_device_train_batch_size $BATCH_PER_DEVICE \
#     --gradient_accumulation_steps $GRAD_ACCUM_STEPS \
#     --image_min_pixels $((720 * 28 * 28)) \
#     --image_max_pixels $((1280 * 28 * 28)) \
#     --learning_rate 1e-5 \
#     --merger_lr 1e-5 \
#     --vision_lr 2e-6 \
#     --weight_decay 0.1 \
#     --warmup_ratio 0.03 \
#     --lr_scheduler_type "cosine" \
#     --logging_steps 1 \
#     --tf32 True \
#     --gradient_checkpointing True \
#     --report_to tensorboard \
#     --lazy_preprocess True \
#     --save_strategy "steps" \
#     --save_steps 200 \
#     --save_total_limit 10 \
#     --dataloader_num_workers 1