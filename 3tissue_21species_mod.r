df <- read.table("all.motif.prob",header=F,sep="\t",col.names = c("variable","seurat_clusters","value"))
table(df$seurat_clusters)
table(df$variable)
df$seurat_clusters=as.factor(df$seurat_clusters)
seurat_clusters<- df$seurat_clusters
seurat_clusters <- factor(seurat_clusters, levels = c("8","11","9","10","21","5","6","15","7","20","18","19","12","3","2","17","16","1","4","14","13"))
data <- data.frame(seurat_clusters, df)
library(ggplot2)
p <- ggplot(data,aes(x=seurat_clusters,y=value,fill=variable))+
    geom_violin(aes(linetype=NA),scale = "width",colour="white",width=1) +
    coord_flip() + #guides(fill=FALSE)
    facet_wrap(variable~.,nrow = 1, strip.position = "bottom",scales ="free_x") + 
    geom_boxplot(width = 0.07,colour="#696969") +
    theme_bw() +
    theme(
        panel.grid = element_blank(), 
        axis.text.x = element_text(size=10),  
        axis.text.y = element_text(size=15), 
        axis.title.y = element_text(size=15),  
        legend.position = "none", 
        panel.spacing=unit(0,"cm"), 
        strip.placement = "outside", 
        strip.text.x = element_text(angle=90,vjust=1,hjust = 1,size=15), 
        strip.background = element_blank()
    )+ scale_fill_manual(values=c("#C56C66", "#D6B36C", "#82B6CE"))

ggsave(p, file='3tissue_21species_motif_prob1.pdf', width=6, height=12)
