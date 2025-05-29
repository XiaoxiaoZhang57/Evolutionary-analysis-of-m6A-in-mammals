import os
from Bio import SeqIO
from Bio.Align.Applications import ClustalOmegaCommandline

# Define input and output directories
input_dir = "/media/tower/zhangxx/m6a/18onent/fasta/fasta/"
output_dir = "/media/tower/zhangxx/m6a/18onent/fasta/fasta/output/"

# Ensure the output directory exists
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Get all files starting with "OG" and ending with ".fa"
fasta_files = [f for f in os.listdir(input_dir) if f.startswith("OG") and f.endswith(".fa")]

# Perform alignment for each file
for fasta_file in fasta_files:
    input_file = os.path.join(input_dir, fasta_file)
    output_file = os.path.join(output_dir, fasta_file.replace(".fa", "_aligned.fa"))

    # Run Clustal Omega for alignment
    clustalomega_cline = ClustalOmegaCommandline(infile=input_file, outfile=output_file, verbose=True, auto=True)
    stdout, stderr = clustalomega_cline()

    # Print output information
    print(f"Processed {fasta_file} -> {output_file}")

print("All files have been processed.")    
