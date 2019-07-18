#!/usr/bin/env

library("Biostrings")
library("tidyverse")

################################
## Plotting Sequence Color Maps
################################

## Prepare Data
## ----------

## Read in Fasta file.

FASTA <- readDNAStringSet("example/motif_matches.fasta", format="fasta")

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
	gather(key="position", value="base", -sequence) %>%
	mutate(position=factor(position, levels=1:seq.length))

## Plotting Data
## ----------

p <- ggplot(cleaned.data, aes(x=position, y=sequence)) +
	geom_tile(aes(fill=base)) +
	scale_fill_viridis_d() +
	theme_minimal() +
	theme(
		axis.title.y=element_blank(),
		axis.text=element_blank(),
		legend.title=element_blank(),
		text=element_text(size=16),
		panel.grid=element_blank()
	)

pdf("sequence-colormap.pdf")
print(p)
dev.off()
