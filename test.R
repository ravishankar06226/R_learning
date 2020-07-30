library(pheatmap)
library(readxl)
#change here the excel sheet number
Up <- read_excel("DeSeq_Comparison1.xlsx",sheet='Upregulated_genes',col_names = TRUE)
Up1<-Up[order(-Up$log2FoldChange),]
Up1=head(Up1,n=20)
Up1$Regulation='Upregulated'
#change here the excel sheet number
Down <- read_excel("DeSeq_Comparison1.xlsx",sheet='Downregulated_genes',col_names = TRUE)
Down1<-Down[order(Down$log2FoldChange),]
Down1=head(Down1,n=20)
Down1$Regulation='Downregulated'
heatmap <- rbind(Up1,Down1)
rownames(heatmap) <- heatmap$`Gene symbol`
#change here the second element of the vector 14 is fixed, second number will be
#14+n(control)+n(test)-1
heatmap1 <- heatmap[,c(14:21)]
heatmap2<-log(heatmap1,2)
heatmap2[heatmap2 == -Inf] <- 0
rownames(heatmap2) <- heatmap$`Gene symbol`
#change here the column number which is the above second number +1
cluster_data <- data.frame(heatmap[,22])
row.names(cluster_data) <- row.names(heatmap)
colnames(cluster_data) <- c("Regulation")
#change here the number of control and test samples
annot_col <- data.frame(c(rep(c('Control', 'Test'), c(4,4))))
row.names(annot_col) <- colnames(heatmap1)
colnames(annot_col) <- c('condition')
pheatmap::pheatmap(heatmap2,cellwidth=30, cellheight=10,cluster_cols = TRUE,cluster_rows = TRUE,annotation_row = cluster_data,annotation_col=annot_col,cexRow=0.5)

