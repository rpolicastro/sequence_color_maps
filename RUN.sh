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

singularity exec -eC \
"singularity/${CONTAINER_NAME}" \
main.R
