##Graphing Ruggeri Control vs Salt
stats2final <- read.delim("~/Projects/Vitis/final_genes/stats2final.txt", header=FALSE)
stats2<-stats2final[order (-stats2final$V2),]
plot2<-barplot (stats2$V2, ylab = "Log Two-Fold Change", 
         col= ifelse(stats2$V2 > 0, "darkblue", "red"),
         ylim = c(-10,10))
axis (1, las=3, cex.axis=0.75, at=plot2, labels=stats2$V1)


##making graph for Control: Marquis vs Ruggeri
stats3final <- read.delim("~/Projects/Vitis/final_genes/stats3final.txt", header=FALSE)
stats3<-stats3final[order (-stats3final$V2),]

plot3<-barplot (stats3$V2, 
                ylab = "Log Two-Fold Change",
                col = ifelse (stats3$V2 >0, "darkblue","red"),
                ylim = c(-10,10))
axis (1, las=3, cex.axis=0.69 , at=plot3, labels=stats3$V1)

##making graph for Salt Marquis vs Ruggeri
stats4out <- read.table("~/Projects/Vitis/final_genes/stats4.out", header=FALSE)
stats5<- stats4out[order (-stats4out$V3),]

plot5 <- barplot (stats5$V3, ylab = "Log Two-Fold Change",
                  col = ifelse (stats5$V3 >0, "darkblue","red"),
                  ylim = c(-10,10))
axis (1, las=3, cex.axis=0.69, at=plot5, labels=stats5$V1)


##Graphing Common genes between all cultivars and conditions
all <- read.table ("~/Projects/Vitis/final_genes/com_geneall.txt", header=TRUE)
all
all2 <- as.matrix (all[,2:4])

plot6 <-barplot (all2, beside=TRUE, 
                 col= c("slategray2","midnightblue"),
                 ylab="Log Two-Fold Change", xlab="Condition",
                 ylim= c(-10,10),
                 legend= (all$Id))
