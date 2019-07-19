#!/usr/bin/env

library("Biostrings")
library("tidyverse")

################################
## Plotting Sequence Color Maps
################################

## Prepare Data
## ----------

## Load settings.

source("settings.conf")

## Read in Fasta file.

FASTA <- readDNAStringSet(fasta.file, format="fasta")

## Get sequence length.

seq.length <- FASTA %>%
	as.character %>%
	map_dbl(~nchar(.)) %>%
	unique

## Prepare data for plotting.

cleaned.data <- FASTA %>%
	as.character %>%
	str_split(pattern="", simplify=TRUE) %>%
	as_tibble %>%
	setNames(rev(1:seq.length)) %>%
	rowid_to_column(var="sequence") %>%
	gather(key="Position", value="base", -sequence) %>%
	mutate(Position=as.integer(Position))

## Plotting Data
## ----------

p <- ggplot(cleaned.data, aes(x=Position, y=sequence)) +
	geom_tile(aes(fill=base)) +
	scale_fill_viridis_d() +
	theme_minimal() +
	theme(
		axis.title.y=element_blank(),
		axis.text.y=element_blank(),
		legend.title=element_blank(),
		axis.title.x=element_text(size=16, margin=margin(t=15)),
		panel.grid=element_blank()
	)

ggsave("sequence-colormap.pdf", plot=p, device="pdf", width=5, height=5)
