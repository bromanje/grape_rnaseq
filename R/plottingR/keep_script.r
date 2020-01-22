ct2 <- read.table("gene_count_matrix_final.txt", header=TRUE)
rownames(ct2) <- ct2$gene_id
ct2$gene_id <- NULL
ct2 <- ct2[,c(11,13:19,1:10,12)]

library(DESeq2)

pheno <- read.table("exptl_conds", header=TRUE)
rownames(pheno) <- pheno$sample_id
pheno$sample_id <- NULL


grape <- DESeqDataSetFromMatrix(countData=ct2,colData=pheno,design = ~ variety + condition + variety:condition)
keep <- rowSums(counts(grape)) >= 10
grape<- grape[keep,]
grape_dsq <-DESeq(grape)
resultsNames(grape_dsq)
grape_res <- results(grape_dsq)
grape_cond_resTF <- lfcShrink(grape_dsq, coef="condition_salt_vs_control", type="apeglm")
grape_variety_resTF <-lfcShrink(grape_dsq, coef="variety_ruggeri_vs_marquis", type="apeglm")
grape_var_cond_resTF <- lfcShrink(grape_dsq, coef="varietyruggeri.conditionsalt", type="apeglm")



pheno_cond1 <- pheno
pheno_cond1 <- pheno_cond1[-c(10:19),]

pheno_cond2 <- pheno
pheno_cond2 <- pheno_cond2[-c(1:9),]

pheno_cond3 <- pheno
pheno_cond3 <- pheno_cond3[-c(5:9,15:19),]

pheno_cond4 <- pheno
pheno_cond4 <- pheno_cond4[-c(1:4,10:14),]

ct_cond1 <- ct2
ct_cond1 <- ct_cond1[,-c(10:19)]

ct_cond2 <- ct2
ct_cond2 <- ct_cond2[,-c(1:9)]

ct_cond3 <- ct2
ct_cond3 <- ct_cond3[,-c(5:9,15:19)]

ct_cond4 <- ct2
ct_cond4 <- ct_cond4[,-c(1:4,10:14)]


cond1 <-DESeqDataSetFromMatrix(countData=ct_cond1, colData=pheno_cond1, design = ~ condition)
keep <- rowSums(counts(cond1)) >= 10
cond1 <- cond1[keep,]
cond1_dsq <-DESeq(cond1)
cond1_res <- results(cond1_dsq)
resultsNames(cond1_dsq)
cond1_resTF <- lfcShrink(cond1_dsq, coef="condition_salt_vs_control", type="apeglm")
cond1_sub_res <- subset(cond1_res,padj <= 0.05)



cond2 <- DESeqDataSetFromMatrix(countData=ct_cond2, colData=pheno_cond2, design = ~ condition)
keep <- rowSums(counts(cond2)) >= 10
cond2 <- cond2[keep,]
cond2_dsq <- DESeq(cond2)
cond2_res <- results(cond2_dsq)
resultsNames(cond2_dsq)
cond2_resTF <- lfcShrink(cond2_dsq, coef="condition_salt_vs_control", type="apeglm")
cond2_sub_res <- subset(cond2_res,padj <= 0.05)



cond3 <- DESeqDataSetFromMatrix(countData=ct_cond3, colData=pheno_cond3, design = ~ variety)
keep <- rowSums(counts(cond3)) >= 10
cond3 <- cond3[keep,]
cond3_dsq <- DESeq(cond3)
cond3_res <- results(cond3_dsq)
resultsNames(cond3_dsq)
cond3_resTF <- lfcShrink(cond3_dsq, coef="variety_ruggeri_vs_marquis", type="apeglm")
cond3_sub_res <- subset(cond3_res,padj <= 0.05)


cond4 <- DESeqDataSetFromMatrix(countData=ct_cond4, colData=pheno_cond4, design = ~ variety)
keep <- rowSums(counts(cond4)) >= 10
cond4 <- cond4[keep,]
cond4_dsq <- DESeq(cond4)
cond4_res <- results(cond4_dsq)
resultsNames(cond4_dsq)
cond4_resTF <- lfcShrink(cond4_dsq, coef="variety_ruggeri_vs_marquis", type="apeglm")
cond4_sub_res <- subset(cond4_res,padj <= 0.05)




write.table(cond1_res,"cond1_res", quote=F, sep="\t", row.names=T, col.names=T)
write.table(cond1_resTF,"cond1_resTF", quote=F, sep="\t", row.names=T, col.names=T)


write.table(cond2_res,"cond2_res", quote=F, sep="\t", row.names=T, col.names=T)
write.table(cond2_resTF,"cond2_resTF", quote=F, sep="\t", row.names=T, col.names=T)


write.table(cond3_res,"cond3_res", quote=F, sep="\t", row.names=T, col.names=T)
write.table(cond3_resTF,"cond3_resTF", quote=F, sep="\t", row.names=T, col.names=T)


write.table(cond4_res,"cond4_res", quote=F, sep="\t", row.names=T, col.names=T)
write.table(cond4_resTF,"cond4_resTF", quote=F, sep="\t", row.names=T, col.names=T)


write.table(grape_res,"grape_res", quote=F, sep="\t", row.names=T, col.names=T)
write.table(grape_resTF,"grape_resTF", quote=F, sep="\t", row.names=T, col.names=T)

write.table(grape_cond_res,"grape_cond_res", quote=F, sep="\t", row.names=T, col.names=T)
write.table(grape_variety_res,"grape_variety_res", quote=F, sep="\t", row.names=T, col.names=T)
write.table(grape_var_cond_resTF,"grape_var_cond_resTF", quote=F, sep="\t", row.names=T, col.names=T)




write.table(cond1_sub_res,"cond1_sub_DESeq.table", quote=F, sep="\t", row.names=T, col.names=T)
write.table(cond2_sub_res,"cond2_sub_DESeq.table", quote=F, sep="\t", row.names=T, col.names=T)
write.table(cond3_sub_res,"cond3_sub_DESeq.table", quote=F, sep="\t", row.names=T, col.names=T)
write.table(cond4_sub_res,"cond4_sub_DESeq.table", quote=F, sep="\t", row.names=T, col.names=T)


