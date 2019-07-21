#!/usr/bin/env

library("Biostrings")
library("tidyverse")
library("ggseqlogo")

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

if (length(seq.length) > 1) {stop("Not all sequences are the same length")}

## Plot Heatmap
## ----------

## Prepare data.

cleaned.data <- FASTA %>%
	as.character %>%
	str_split(pattern="", simplify=TRUE) %>%
	as_tibble %>%
	setNames(1:seq.length) %>%
	rowid_to_column(var="sequence") %>%
	mutate(sequence=rev(sequence)) %>%
	gather(key="Position", value="base", -sequence) %>%
	mutate(Position=as.integer(Position))

## Plot data.

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

## Make Sequence Logo
## ----------

## Prepare position frequency matrix.

PFM <- consensusMatrix(FASTA, as.prob=TRUE) %>%
	.[rownames(.) %in% c("A", "C", "G", "T"),]

## Set viridis base color for plotting.

viridis.bases <- make_col_scheme(
	chars=c("A", "C", "G", "T"),
	groups=c("A", "C", "G", "T"),
	cols=c("#431352", "#34698c", "#44b57b", "#fde540")
)

## Plot sequence logo.

p <- ggplot() +
	geom_logo(PFM, col_scheme=viridis.bases) +
	theme_logo()

ggsave("sequence-logo.pdf", plot=p, device="png", width=5, height=1.5)


