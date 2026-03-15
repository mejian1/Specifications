#!/usr/bin/env python3
"""Create a two-set Venn diagram for intersecting gene groups.

Input files should contain one gene ID per line.
"""

import argparse
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib_venn import venn2


def read_gene_set(path: Path) -> set[str]:
    """Read non-empty gene IDs from a text file."""
    with path.open("r", encoding="utf-8") as handle:
        return {line.strip() for line in handle if line.strip()}


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Plot a two-group gene intersection Venn diagram"
    )
    parser.add_argument("group1_file", type=Path, help="Text file of group 1 gene IDs")
    parser.add_argument("group2_file", type=Path, help="Text file of group 2 gene IDs")
    parser.add_argument("--label1", default="Group 1", help="Label for group 1")
    parser.add_argument("--label2", default="Group 2", help="Label for group 2")
    parser.add_argument(
        "--output",
        type=Path,
        default=Path("gene_venn_python.png"),
        help="Output image path",
    )

    args = parser.parse_args()

    genes1 = read_gene_set(args.group1_file)
    genes2 = read_gene_set(args.group2_file)

    plt.figure(figsize=(6, 6))
    venn2([genes1, genes2], set_labels=(args.label1, args.label2))
    plt.title("Gene Intersection Between Two Groups")
    plt.tight_layout()
    plt.savefig(args.output, dpi=300)
    plt.close()

    overlap = genes1.intersection(genes2)
    print(f"{args.label1} genes: {len(genes1)}")
    print(f"{args.label2} genes: {len(genes2)}")
    print(f"Intersecting genes: {len(overlap)}")


if __name__ == "__main__":
    main()
