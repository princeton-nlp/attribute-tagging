# Attribution Generation

Code base for attribute generation project

### Usage
**Setup** Instructions
1. `pip install -r requirements.txt
2. Download the following datasets from this google drive [link](https://drive.google.com/drive/u/2/folders/1iIqUIfSOl1UW0M9PeDaQlRW6zn_Jx194)
    * `items_shuffle.json`
    * `reviews.json`
    * `items_ins_v2.json`
3. Create a `data` folder at the root of the repository, then place the above files into the directory

To generate the synthetic dataset, run `python syn-data-gen/gen-data.py`. This generates an `attr_gen_dataset.json` file in the `data` folder.