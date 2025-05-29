#conda create -y --name ont-fast5-api python=3.6
conda activate ont-fast5-api

#get single F5
multi_to_single_fast5 -i ~/data/ONT/F5_data/mouse/fast5_pass -s ~/data/ONT/F5_data/mouse/fast5_pass/single/ -t 60

#Correction by NGS
gunzip -c ~/data/BGI/mouse/mouse_?.fq.gz | awk "NR % 4 == 2" | sort -T ./temp | tr NT TN | ropebwt2 -LR | tr NT TN | fmlrc2-convert ~/data/BGI/mouse/mouse_comp_msbwt.npy
zless -S pass.fq| paste - - - -|cut -f 1-2|tr '\t' '\n'|tr '@' '>' |less -S >pass.fa 
fasta_nucleotide_changer -i pass.fa -d -o pass.UT.fa 
fmlrc2 -t 60 ~/data/BGI/mouse/mouse_comp_msbwt.npy \
~/data/ONT/FQ_data/mouse/pass.UT.fa \
~/Correction/mouse/mouse_pass.UT.corrected.fa

cd ~/Correction/mouse/
minimap2 -ax map-ont -uf -k14 -t 30 --secondary=no \
~/refData/mouse/Mus_musculus.GRCm39.dna.toplevel.fa \
~/Correction/mouse/mouse_pass.UT.corrected.fa> mouse.corrected.sam
samtools view -bS mouse.corrected.sam > mouse.corrected.bam
samtools sort mouse.corrected.bam -o mouse.corrected.sort.bam
samtools flagstat mouse.corrected.sort.bam
samtools index mouse.corrected.sort.bam mouse.corrected.sort.bam.bai
