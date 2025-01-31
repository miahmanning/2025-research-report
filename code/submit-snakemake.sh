#!/bin/bash
#SBATCH --partition=compute
#SBATCH --time=12:00:00
#SBATCH --mem=3G
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --job-name=snakmake

source /vortexfs1/home/miah.manning/.conda/envs/mamba_env/etc/profile.d/conda.sh
conda activate snakemake-class

snakemake --cleanup-metadata "outputs/salmon_index_914"
snakemake --cleanup-metadata "outputs/salmon_index_874" 

snakemake --jobs 8 --use-conda \
        --cluster-config cluster.yaml --cluster "sbatch --parsable --qos=medmem --partition={cluster.queue} \
        --job-name=mmanning.{rule}.{wildcards} --mem={cluster.mem}gb --time={cluster.time} --ntasks={cluster.threads} \
        --nodes={cluster.nodes}"


