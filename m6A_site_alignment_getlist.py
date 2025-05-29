import csv
import os

# Define input file and output directory
input_file = '/media/tower/zhangxx/m6a/18onent/one2one_ortho_than10.tsv'
output_dir = 'output_files'

# Create the output directory if it doesn't exist
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Define the mapping table
mapping = {
    'Btau': 5, 'Clup': 8, 'Cpor': 17, 'Ctre': 4, 'Easi': 21,
    'Ecab': 10, 'Eeur': 12, 'Fcat': 9, 'Hlar': 20, 'Lgla': 7,
    'Mchi': 19, 'Mfas': 1, 'Mfur': 11, 'Mmus': 2, 'Oari': 6,
    'Ocun': 16, 'Pcap': 14, 'Rnor': 3, 'Rpus': 18, 'Sscr': 15,
    'Pbre': 13
}

# Read the input file
with open(input_file, 'r') as infile:
    reader = csv.reader(infile, delimiter='\t')
    header = next(reader)  # Read and skip the header line

    for row in reader:
        file_name = os.path.join(output_dir, f"{row[0]}.txt")
        with open(file_name, 'w') as outfile:
            # Remove the first two columns and 'NULL' columns
            filtered_data = [field for field in row[2:] if field != 'NULL']
            # Write the data vertically into the file
            for item in filtered_data:
                # Replace the last underscore with a tab and replace values according to the mapping table
                parts = item.rsplit('_', 1)
                if len(parts) == 2:
                    species_code = parts[1]
                    species = species_code.split('_')[0]
                    number = mapping.get(species, species_code)
                    new_line = f"{parts[0]}\t{number}\n"
                    outfile.write(new_line)
                else:
                    outfile.write(f"{item}\n")

print("Files have been generated and updated.")    
