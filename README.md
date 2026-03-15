Here are the steps to process GFF/GTF genomic files for model organisms.

## Gene intersection Venn diagram scripts

This repository now includes example scripts to draw a 2-group Venn diagram from gene lists:

- Python: `scripts/venn_genes.py`
- R: `scripts/venn_genes.R`

### Input format

Provide one gene ID per line in each input file (plain text), for example:

- `scripts/venn_example_group1.txt`
- `scripts/venn_example_group2.txt`

### Python usage

Install dependencies:

```bash
pip install matplotlib matplotlib-venn
```

Run:

```bash
python scripts/venn_genes.py \
  scripts/venn_example_group1.txt \
  scripts/venn_example_group2.txt \
  --label1 "Treatment A" \
  --label2 "Treatment B" \
  --output venn_python.png
```

### R usage

Install dependency:

```r
install.packages("VennDiagram")
```

Run:

```bash
Rscript scripts/venn_genes.R \
  scripts/venn_example_group1.txt \
  scripts/venn_example_group2.txt \
  "Treatment A" "Treatment B" venn_r.png
```
