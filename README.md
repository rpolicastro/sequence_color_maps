# Sequence Color Maps

This repository houses the software needed to make sequence color maps.

![screenshot](https://raw.githubusercontent.com/rpolicastro/sequence_color_maps/master/docs/sequence-colormap.png)

## Getting Started

### Preparing Input

This workflow takes a fasta file as input. 
The sequence colormap order will follow the order of sequences in the fasta file. 
The sequences in the fasta file should all be of equal length.

### Cloning Repository

To get started, you must first clone the Sequence Color Map repository. 
Navigate to a directory you would like to clone the repo to and enter
```
git clone https://github.com/rpolicastro/sequence_color_maps.git
```

### Installing Singularity

Singularity containers are self contained 'boxes' that house the software and other files necessary for the workflow. 
The container itself will automatically be downloaded, but you must have the Singularity software installed to both download and use the container. 
Please refer to the [documentation](https://www.sylabs.io/docs/) on their website.

### Specifying Run Settings

The last step is to set a few settings in the 'settings.conf' file in the main repository directory.

| Setting | Description |
| ------- | ----------- |
| fasta.file | The path and name of the fasta file |

### Running the Workflow

After getting Singularity installed, the sample sheet prepared, and the settings specified, you are now ready to run the workflow.
Navigate to the main directory and enter 'bash RUN.sh'.

## Built With

This workflow would not be possible without the great software listed below.

- [Singularity](https://sylabs.io/) - Software containers.
- [Tidyverse](https://www.tidyverse.org/) - Data processing and plotting.
- [Bioconductor](https://www.bioconductor.org/) - R libraries for working with biological data.
