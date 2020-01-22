
ct2 <- read.table("gene_count_matrix.txt", header=T)
rownames(ct2) <- ct2$gene_id
ct2$gene_id <- NULL
df <- ct2[c(11,13:19,1:10,12)]

group <- factor(c(1,1,1,1,2,2,2,2,2,3,3,3,3,3,4,4,4,4,4))

library(egdeR)

y <- DGEList(counts=df, group=group)

y_cnf <- calcNormFactors(y)

design <- model.matrix(~group)
y <- estimateDisp(y_cnf, design)


levels(y$samples$group)



cond1 <- exactTest(y, pair=c(1,2))
topTags(cond1)
FDR <- p.adjust(cond1$table$PValue, method="BH")
write.table(topTags(cond1, n=Inf), "cond1_edgr.table", row.names=T, col.names=T, quote=F, sep='\t')
cond1 <-read.table("cond1_edgr.table", header=T)
cond1_sub_res <- subset(cond1,FDR <= 0.05)



cond2 <- exactTest(y, pair=c(3,4))
topTags(cond2)
FDR <- p.adjust(cond2$table$PValue, method="BH")
write.table(topTags(cond2, n=Inf), "cond2_edgr.table", row.names=T, col.names=T, quote=F, sep='\t')
cond2 <-read.table("cond2_edgr.table", header=T)
cond2_sub_res <- subset(cond2,FDR <= 0.05)



cond3 <- exactTest(y, pair=c(1,3))
topTags(cond3)
FDR <- p.adjust(cond3$table$PValue, method="BH")
write.table(topTags(cond3, n=Inf), "cond3_edgr.table", row.names=T, col.names=T, quote=F, sep='\t')
cond3 <-read.table("cond3_edgr.table", header=T)
cond3_sub_res <- subset(cond3,FDR <= 0.05)



cond4 <- exactTest(y, pair=c(2,4))
topTags(cond4)
FDR <- p.adjust(cond4$table$PValue, method="BH")
write.table(topTags(cond4, n=Inf), "cond4_edgr.table", row.names=T, col.names=T, quote=F, sep='\t')
cond4 <-read.table("cond4_edgr.table", header=T)
cond4_sub_res <- subset(cond4,FDR <= 0.05)



write.table(cond1_sub_res,"cond1_sub_edgr.table", quote=F, sep="\t", row.names=T, col.names=T)
write.table(cond2_sub_res,"cond2_sub_edgr.table", quote=F, sep="\t", row.names=T, col.names=T)
write.table(cond3_sub_res,"cond3_sub_edgr.table", quote=F, sep="\t", row.names=T, col.names=T)
write.table(cond4_sub_res,"cond4_sub_edgr.table", quote=F, sep="\t", row.names=T, col.names=T)


