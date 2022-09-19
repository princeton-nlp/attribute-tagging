#!/bin/bash -l

# Set Job Name
#SBATCH --job-name=attrs-gen

# Define, how many nodes you need. Here, we ask for 1 node.
#SBATCH -N 1 #nodes
#SBATCH -n 1 #tasks
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --time=1-0:00:00    # Run for 7 days
#SBATCH --gres=gpu:4

# Remember to set your email address here instead of nobody
#SBATCH --mail-user=jy1682@princeton.edu

# Set conda environment
set -- source "/n/fs/nlp-jy1682/miniconda3/bin/activate";
conda activate attrs;

# Submit Jobs
# 't5-small' (8,8,1); 't5-base' (2,2,4)
# Try: all t5 models (3b, 11b only 2/500), [200, 500, 1000, 8000 (upper bound)]
# - 3b 4 gpus
for model in 't5-large'; do
    echo "Beginning ${model} model runs";

    # Create logging outputs
    mkdir -p ./logs/${model}/stdout/;
    mkdir -p ./logs/${model}/predictions/;

    # Remove previous run
    rm -rf ./logs/${model}/stdout/*;
    rm -rf ./logs/${model}/predictions/*;

    for size in '_50' '_200' '_500' '_2000' '_5000' '_full'; do
        echo "Beginning work on dataset w/ size ${size}";

        # Create log file name
        touch ./logs/${model}/predictions/log${size}.txt;

        # Run job
        srun --exclude=node[009-016],node[030],node[200-201] python run_summarization.py \
            --model_name_or_path ${model} \
            --do_train \
            --do_eval \
            --train_file ../data/attr-gen-data/attr_gen_dataset_train${size}.csv \
            --validation_file ../data/attr-gen-data/attr_gen_dataset_valid.csv \
            --source_prefix "" \
            --output_dir /n/fs/nlp-jy1682/tmp/tst-summarization \
            --overwrite_output_dir \
            --predict_with_generate \
            --per_device_eval_batch_size 1 \
            --per_device_train_batch_size 1 \
            --gradient_accumulation_steps 32 \
            --n_gpu 2 \
            > logs/${model}/stdout/log${size}.txt
    done;
done;

# Add --test_file arg to above if need to test

# Finish the script
exit 0