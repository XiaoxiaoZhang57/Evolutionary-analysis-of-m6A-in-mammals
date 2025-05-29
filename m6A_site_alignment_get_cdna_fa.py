import os
from Bio import SeqIO

# Define directories and files
input_dir = '~/m6a/18onent/fasta/output_files'
cdna_dir = '~/m6a/18onent'
output_dir = '~/m6a/18onent/fasta/fasta'
list_file = 'list1'

# Create the output directory if it doesn't exist
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Read file names from the list file
with open(list_file, 'r') as lf:
    txt_files = [line.strip() for line in lf]

# Process each file in the list
for txt_file in txt_files:
    txt_path = os.path.join(input_dir, txt_file)
    output_fasta = os.path.join(output_dir, txt_file.replace('.txt', '.fa'))

    # Create a dictionary to store sequence IDs and corresponding output files
    seq_dict = {}
    with open(txt_path, 'r') as f:
        for line in f:
            parts = line.strip().split()
            if len(parts) == 2:
                seq_id = parts[0]
                file_num = parts[1]
                cdna_file = os.path.join(cdna_dir, f"{file_num}.cdna.fa")
                if cdna_file not in seq_dict:
                    seq_dict[cdna_file] = []
                seq_dict[cdna_file].append(seq_id)

    # Extract sequences and save to a new .fa file
    with open(output_fasta, 'w') as out_f:
        for cdna_file, seq_ids in seq_dict.items():
            if os.path.exists(cdna_file):
                for record in SeqIO.parse(cdna_file, 'fasta'):
                    if record.id in seq_ids:
                        record.id = seq_ids[seq_ids.index(record.id)]  # Update fasta record ID
                        record.description = ''  # Remove description part
                        SeqIO.write(record, out_f, 'fasta')
            else:
                print(f"Warning: {cdna_file} does not exist.")

print("All sequences have been extracted.")    
