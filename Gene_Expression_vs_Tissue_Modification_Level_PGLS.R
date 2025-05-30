packages <- c("ape", "nlme", "ggplot2", "ggimage", "rsvg")
installed <- installed.packages()
for (pkg in packages) {
  if (!pkg %in% rownames(installed)) {
    install.packages(pkg)
  }
}

# Load required libraries
library(ape)       # For phylogenetic tree handling
library(nlme)      # For gls() and correlation structures
library(ggplot2)   # For plotting
library(ggimage)   # For adding images to ggplot
library(rsvg)      # For converting SVG to PNG

# ------------------------------
# 1. Read Input Files
# ------------------------------

# Read the phylogenetic tree file
tree <- read.tree("21mammals1_pgls.nwk")


names_df <- read.table("name", header = FALSE, sep = "\t", stringsAsFactors = FALSE)
colnames(names_df) <- c("species", "species_id")


data <- read.table("ALKBH1.eraser-1.uniq", header = FALSE, sep = "\t", stringsAsFactors = FALSE)
colnames(data) <- c("species_id", "source", "gene", "mod_level", "gene_expr")

# ------------------------------
# 2. Merge Data with Species Mapping
# ------------------------------

# Convert species_id columns to character for proper matching
data$species_id <- as.character(data$species_id)
names_df$species_id <- as.character(names_df$species_id)

# Merge gene data with species mapping to add species names
data <- merge(data, names_df, by = "species_id", all.x = TRUE)

# Optional: Check species names in the data and tree tip labels
cat("Species in data:\n")
print(unique(data$species))
cat("Tree tip labels:\n")
print(tree$tip.label)

# ------------------------------
# 3. Prune the Tree and Prepare the Data
# ------------------------------

# Identify species present in the data
species_in_data <- unique(data$species)

# Prune the tree to include only species present in the data
pruned_tree <- drop.tip(tree, setdiff(tree$tip.label, species_in_data))

# Set row names of the data to species names (assuming one observation per species)
rownames(data) <- data$species

# ------------------------------
# 4. Fit the OU Model Using gls() with corMartins
# ------------------------------

# Define the OU correlation structure with the species covariate specified to avoid warnings
ou_corr <- corMartins(value = 1, phy = pruned_tree, fixed = FALSE, form = ~ species)

# Fit the OU model: gene expression as a function of tissue modification level
ou_model <- gls(gene_expr ~ mod_level, data = data, correlation = ou_corr, method = "ML")

# Extract model summary, coefficients, and p-value
summary_ou <- summary(ou_model)
slope <- summary_ou$tTable["mod_level", "Value"]
intercept <- summary_ou$tTable["(Intercept)", "Value"]
p_value <- summary_ou$tTable["mod_level", "p-value"]

# Calculate a pseudo R-squared (since gls doesn't provide one directly)
rss <- sum(resid(ou_model)^2)
tss <- sum((data$gene_expr - mean(data$gene_expr))^2)
pseudo_R2 <- 1 - rss/tss

cat("OU Model Results:\n")
cat("Slope:", slope, "\n")
cat("Intercept:", intercept, "\n")
cat("Pseudo R-squared:", pseudo_R2, "\n")
cat("P-value for mod_level:", p_value, "\n")

# ------------------------------
# 5. Convert SVG Icons to PNG for Plotting Using rsvg
# ------------------------------

# Construct full file paths for the SVG icons.
# Adjust the directory path as needed.
data$image_svg <- file.path("~/m6a/pgls", paste0(data$species, ".svg"))

# Diagnostic: Check if files exist
file_existence <- sapply(data$image_svg, file.exists)
cat("File existence for each SVG:\n")
print(file_existence)

# Convert each SVG image to a temporary PNG file using rsvg::rsvg_png
data$image_png <- sapply(data$image_svg, function(svg_path) {
  if (!file.exists(svg_path)) {
    warning(paste("SVG file not found:", svg_path))
    return(NA)
  }
  tmp_png <- tempfile(fileext = ".png")
  # Convert the SVG to PNG and write to a temporary file
  rsvg::rsvg_png(svg_path, tmp_png)
  return(tmp_png)
})

# ------------------------------
# 6. Plot the Relationship with Species Icons
# ------------------------------

# Create the plot using ggplot2 with geom_image() from ggimage to show the PNG icons.


p <- ggplot(data, aes(x = gene_expr, y = mod_level)) +
  geom_image(aes(image = image_png), size = 0.03) +  # 调整图片大小
  #geom_abline(intercept = intercept, slope = slope, color = "blue", linewidth = 1) +
  geom_smooth(method = "lm", color = "black", fill = "lightblue", alpha = 0.3) +  # 添加阴影线
  labs(x = "Gene Expression Level",
       y = "Tissue Modification Level",
       title = "OU Model: Gene Expression vs. Tissue Modification Level") +
  theme_minimal()

print(p)

library(ggplot2)
library(ggimage)  # 用于显示物种图片

# 提取 OU 模型结果
slope <- summary_ou$tTable["mod_level", "Value"]
intercept <- summary_ou$tTable["(Intercept)", "Value"]
p_value <- summary_ou$tTable["mod_level", "p-value"]

# 计算 pseudo R²（伪 R²）
rss <- sum(resid(ou_model)^2)
tss <- sum((data$gene_expr - mean(data$gene_expr))^2)
pseudo_R2 <- 1 - rss/tss

# 设置 P 值格式化
p_text <- ifelse(p_value < 0.001, "P < 0.001", paste0("P = ", round(p_value, 3)))

# 绘图
p <- ggplot(data, aes(x = gene_expr, y = mod_level)) +
    geom_image(aes(image = image_png), 
               size = 0.1, 
               color = "#DECF97",  # 设置轮廓为浅灰色
               alpha = 0.5       # 调整透明度
    ) +
    geom_smooth(method = "lm", color = "black", fill = "lightblue", alpha = 0.3) +
    labs(
        x = "Gene Expression Level",
        y = "Tissue Modification Level",
        title = "ALKBH1.eraser-1",
        subtitle = "Using Ornstein-Uhlenbeck (OU) evolutionary model"
    ) +
    theme_minimal() +
    theme(
        panel.grid = element_blank(),
        axis.line = element_line(color = "black", linewidth = 1)
    ) +
    annotate("text", 
             x = max(data$gene_expr) * 0.7, 
             y = max(data$mod_level) * 0.9, 
             label = paste0("Pseudo R² = ", round(pseudo_R2, 3), "\n", p_text), 
             size = 3, color = "red", hjust = 0)

# 输出图形
print(p)
# 保存图像到 PDF 文件
ggsave("ALKBH1.eraser-1.pdf", plot = p, width = 4, height = 4, dpi = 300)
