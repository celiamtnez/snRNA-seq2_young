# snRNA-seq2_young
Analysis of snRNA-seq2 data coming from 3 months old mouse liver, dissecting the influence ploidy has on gene expression.

### Background
Single-cell RNA-seq is revealing the role of pathogenic cell populations in the development and progression of chronic diseases. In order to expand our knowledge on cellular heterogeneity we have developed a single-nucleus RNA-seq-2 method that allows deep characterization of nuclei isolated from frozen archived tissues. We have used this approach to characterize the transcriptional profile of individual hepatocytes with different levels of ploidy, and discovered that gene expression in tetraploid mononucleated hepatocytes is conditioned by their position within the hepatic lobe. Our work has revealed a remarkable crosstalk between gene dosage and spatial distribution of hepatocytes. 

### Data accessibility
The raw data can be found at: https://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-9333/

### Preprocessing
Raw reads were aligned to mm10 and ERCC92 reference using STARa2.7.1a. PCR duplicates were removed using picard tools v2.20.2 before building the count matrix using htseq-count v0.11.3

### Analysis pipeline
#### 1. Filtering:
- Nuclei are kept if they have 5-90% ERCC reads and at least 1000 genes expressed.
- We keep genes that are present in at least 1% of the population with at least 250 reads across nuclei
- Nuclei with more than 7,000 are removed as well as nuclei with library sizes outside the range of 10,000-300,000

#### 2. Normalisation
- ERCC size factor is calculated as the sum of ERCC reads per nucleus divided by the mean ERCC reads across all nuclei
- Per gene, the reads are divided by the length of the gene in kb
- The library size normalisation factor is defined as the sum of gene length-normalised counts divided by 10,000 times the ERCC size factor
- Per nucleus, the reads are divided by the library size normalisation factor

Additional filtering: removing nuclei with more than 50,000 gene length-normalised counts and removing technical replicates
Matrix is log-transformed and batch-correction is done using combat


#### 3. Downstream analysis
- Visualisation, clustering and differential expression analysis using scanpy functions
- Cluster annotation based on differential expression and marker genes
- Gene set enrichment analysis using gprofiler
- Transcriptional variability is defined as the coefficient of variation calculated on log-transformed data
- Co-expression of stem cell markers is addressed by calculating Jaccard distances between genes
- Diffusion pseudotime is calculated on markers of zonation to establish an in-silico order of nuclei along the liver lobule based on their expression profiles




