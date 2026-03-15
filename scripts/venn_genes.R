#!/usr/bin/env Rscript
# Create a two-set Venn diagram for intersecting gene groups.
# Input files should contain one gene ID per line.

suppressPackageStartupMessages({
  library(VennDiagram)
  library(grid)
})

args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 2) {
  stop(
    "Usage: Rscript scripts/venn_genes.R <group1_file> <group2_file> [label1] [label2] [output_png]",
    call. = FALSE
  )
}

group1_file <- args[1]
group2_file <- args[2]
label1 <- ifelse(length(args) >= 3, args[3], "Group 1")
label2 <- ifelse(length(args) >= 4, args[4], "Group 2")
output_png <- ifelse(length(args) >= 5, args[5], "gene_venn_r.png")

read_gene_set <- function(path) {
  genes <- trimws(readLines(path, warn = FALSE))
  unique(genes[genes != ""])
}

genes1 <- read_gene_set(group1_file)
genes2 <- read_gene_set(group2_file)
overlap <- intersect(genes1, genes2)

png(filename = output_png, width = 1800, height = 1800, res = 300)
grid.newpage()
venn.plot <- draw.pairwise.venn(
  area1 = length(genes1),
  area2 = length(genes2),
  cross.area = length(overlap),
  category = c(label1, label2),
  fill = c("#66c2a5", "#fc8d62"),
  alpha = c(0.6, 0.6),
  cex = 2,
  cat.cex = 1.8,
  cat.pos = c(-20, 20),
  scaled = FALSE
)
grid.draw(venn.plot)
dev.off()

cat(sprintf("%s genes: %d\n", label1, length(genes1)))
cat(sprintf("%s genes: %d\n", label2, length(genes2)))
cat(sprintf("Intersecting genes: %d\n", length(overlap)))
