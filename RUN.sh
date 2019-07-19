#!/bin/bash

CONTAINER="library://rpolicastro/default/sequence_colormaps:1.0.0"

###############################
## Generate Sequence Colormaps
###############################

## Prepare Container
## ----------

CONTAINER_NAME=$(basename $CONTAINER | tr ":" "_")".sif"

if [ ! -f "singularity/${CONTAINER_NAME}" ]; then
	singularity pull $CONTAINER
	mv $CONTAINER_NAME singularity
fi

## Run Script
## ----------

## Get directory that has the fasta file.

FASTA=$(sed -n 's/^fasta\.file.*\"\(.*\)\"$/\1/p' settings.conf)
FASTA_DIR=$(dirname FASTA)

## Run script using software in container.

singularity exec \
-e -C -B ${PWD},${FASTA_DIR} -H $PWD \
"singularity/${CONTAINER_NAME}" \
Rscript main.R
