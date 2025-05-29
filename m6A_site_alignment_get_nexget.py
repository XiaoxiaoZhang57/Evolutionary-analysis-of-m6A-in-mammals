import os

def replace_sequence(seq, pos):
    # Replace the specified position in the sequence with 'A'
    seq_list = list(seq)
    seq_list[pos] = 'A'
    return ''.join(seq_list)

# Define file paths
aligned_file = '~/m6a/18onent/fasta/fasta/output/OG0002884_aligned.fa.nex'
txt_file = '~/m6a/18onent/fasta/output_files/OG0002884.txt'
output_file = '~/m6a/18onent/fasta/fasta/output/OG0002884_aligned_modified.fa1'

aligned_dict = {}
original_sequences = {}

# Read and process the aligned file
print("Reading and processing aligned file...")
with open(aligned_file, 'r') as f:
    for line in f:
        parts = line.strip().split('\t')
        if len(parts) == 2:
            gene_name = parts[0]
            sequence = parts[1].replace('A', '-').replace('G', '-').replace('C', '-').replace('T', '-') \
                                .replace('N', '-').replace('a', '-').replace('g', '-').replace('t', '-') \
                                .replace('c', '-').replace('n', '-')
            aligned_dict[gene_name] = sequence
            original_sequences[gene_name] = parts[1]  # Save the original sequence

# Check if aligned_dict is populated correctly
print(f"Aligned file contains {len(aligned_dict)} sequences.")

# Read the txt file
print("Reading txt file...")
with open(txt_file, 'r') as f:
    og_data = [line.strip().split('\t') for line in f]

output_lines = []

for og_row in og_data:
    gene_id = og_row[0]
    species_index = int(og_row[1])  # Get the species index
    site_file_path = f'/media/tower/zhangxx/m6a/0data/eventalign/{species_index}-1/allsite/site.uniq'

    if not os.path.exists(site_file_path):
        print(f"Site file {site_file_path} does not exist. Skipping...")
        continue

    # Read the site.uniq file
    with open(site_file_path) as f:
        site_data = [line.strip().split('\t') for line in f]

    # Filter matching rows
    matched_sites = [int(row[1]) for row in site_data if row[0] == gene_id]

    if not matched_sites:
        print(f"No matching sites found for gene {gene_id} in site file {site_file_path}.")
        continue

    # Get the original sequence
    original_seq = original_sequences.get(gene_id)
    if original_seq is None:
        print(f"No matching sequence found for gene {gene_id} in aligned file.")
        continue

    # Replace '-' at specified positions
    modified_seq = list(aligned_dict[gene_id])
    non_dash_positions = [i for i, char in enumerate(original_seq) if char != '-']

    for site in matched_sites:
        if site-1 < len(non_dash_positions):
            pos = non_dash_positions[site-1]
            modified_seq[pos] = 'A'

    output_lines.append(f"{gene_id}\t{species_index}\t{''.join(modified_seq)}")

# Check if output was generated
print(f"Generated {len(output_lines)} output lines.")

# Save results to OG0002884_aligned_modified.fa1 file
print(f"Saving results to {output_file}...")
with open(output_file, 'w') as f:
    for line in output_lines:
        f.write(line + '\n')

print("Processing complete. Output saved to OG0002884_aligned_modified.fa1")    
