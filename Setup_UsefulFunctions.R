# Install Packages Required

install.packages("phyloseq")
install.packages("kable")
install.packages("BiocManager")
install.packages("ggplot")
install.packages("knitr")

# load packages

library(microbiome)

# Define file paths

rich_dense_biom  = system.file("extdata", "rich_dense_otu_table.biom",  package="phyloseq")
rich_sparse_biom = system.file("extdata", "rich_sparse_otu_table.biom", package="phyloseq")
min_dense_biom   = system.file("extdata", "min_dense_otu_table.biom",   package="phyloseq")
min_sparse_biom  = system.file("extdata", "min_sparse_otu_table.biom",  package="phyloseq")
treefilename = system.file("extdata", "biom-tree.phy",  package="phyloseq")
refseqfilename = system.file("extdata", "biom-refseq.fasta",  package="phyloseq")

# Store the result of your imported data

myStoredData = import_biom(rich_dense_biom, treefilename, refseqfilename, parseFunction=parse_taxonomy_greengenes)

# Check what is stored

myStoredData			# Print all the data 
view(myStoredData)		# Access file and open up to see different variables

# Create Phylogenetic tree

plot_tree(myStoredData, color="Genus", shape="BODY_SITE", size="abundance")
plot_tree(myStoredData, color="Bar", shape="BODY_SITE", size="abundance")
plot_tree(myStoredData, color="Species", shape="BarcodeSequence", size="abundance")

