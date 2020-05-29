library(ComplexHeatmap)

var <- read.table("/home/maria/data/polyploid_hepatocytes/metadata/cnvs/cell_type_markers_new/var.csv", header=T, sep=",")
var$X <- as.character(var$X)
var$transcript_id <- var$X 
var$X <- NULL

mat <- read.table("/home/maria/data/polyploid_hepatocytes/cell_type_markers_mat_new.txt", header=F, sep="")
obs <- read.table("/home/maria/data/polyploid_hepatocytes/metadata/cnvs/cell_type_markers_new/obs.csv", header=T, sep=",")

rownames(mat) <- obs$Sample
colnames(mat) <- var$gene_name

mat <- as.matrix(mat)

# Define colors as before

col = list(cell_type = c("02 Hepatobiliary cells" = "#251024", "03 Endothelial cells" = "#bcc2f6", "01 Hepatocytes" = "#9b0f2b",
                         "04 Kupffer cells and dendritic cells" = "#0b8686", "05 Lymphocytes" = "#ab0dd0"),
           ploidy = c("2n" = "#1f77b4", "4n" = "#ff7f0e"))

ha = rowAnnotation(cell_type=obs$cell_type2, ploidy=obs$Ploidy, col=col)


Heatmap(mat, name = "mat", left_annotation = ha, split=obs$cell_type2, width=50,
        cluster_columns=F,
        cluster_rows=F,
        col = circlize::colorRamp2(c(0, 0.25, 2, 6), c("#c0c5ce", "blue", "purple", "red")))
   
