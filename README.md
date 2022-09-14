# Attribution Generation

Code base for attribute generation project

### Usage
**Setup** Instructions
1. `pip install -r requirements.txt`
2. `pip install git+https://github.com/huggingface/transformers` (Model requires latest version, docs [here](https://huggingface.co/docs/transformers/installation#installing-from-source))
3. Download the following datasets from this google drive [link](https://drive.google.com/drive/u/2/folders/1iIqUIfSOl1UW0M9PeDaQlRW6zn_Jx194)
    * `items_shuffle.json`
    * `reviews.json`
    * `items_ins_v2.json`
4. Create a `data` folder at the root of the repository, then place the above files into the directory

To generate the synthetic dataset, run `python syn-data-gen/gen-data.py`. This generates the following files in the `data/attr-gen-data/` folder.
* `attr_gen_dataset.json`: Entire 10000 dataset of [product info -> attributes]
* `attr_gen_dataset_train_{size}.csv`: Training data splits of size [50, 200, 500, 2000, 5000]
* `attr_gen_dataset_valid.json`: Validation data (1000 rows)
* `attr_gen_dataset.test.json`: Test data (1000 rows)

To run the summarization model, submit the slurm job to the compute cluster via `sb run.slurm`. Model based on Hf summarization module, found [here](https://github.com/huggingface/transformers/tree/main/examples/pytorch/summarization).
