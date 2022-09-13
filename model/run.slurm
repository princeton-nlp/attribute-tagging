#!/bin/bash -l

# Set Job Name
#SBATCH --job-name=attrs-gen

# Define, how many nodes you need. Here, we ask for 1 node.
#SBATCH -N 1 #nodes
#SBATCH -n 1 #tasks
#SBATCH --cpus-per-task=2
#SBATCH --mem=20G
#SBATCH --time=1-0:00:00    # Run for 7 days
#SBATCH --gres=gpu:1

# Set conda environment
set -- source "/n/fs/nlp-jy1682/miniconda3/bin/activate";
conda activate attrs;

# Submit Jobs
srun python run_summarization.py \
    --model_name_or_path t5-small \
    --do_train \
    --do_eval \
    --train_file ../data/attr_gen_dataset_train.csv \
    --validation_file ../data/attr_gen_dataset_valid.csv \
    --source_prefix "" \
    --output_dir /n/fs/nlp-jy1682/tmp/tst-summarization \
    --per_device_train_batch_size=4 \
    --per_device_eval_batch_size=4 \
    --overwrite_output_dir \
    --predict_with_generate \
    > logs/log.txt

# Finish the script
exit 0