#m6A number in a single transcript
library(ggplot2)

data <- read.table("1transcript_num_m6a", header = FALSE)

colnames(data) <- c("Species", "Tissue", "Number")

species_names <- c("Monkey", "Mouse", "Rat", "Tree shrew", "Cattle", "Sheep", "Llama", "Dog", "Cat", "Horse", 
                   "Ferret", "Four-toed hedgehog", "Sugar glider", "Hyrax", "Pig", "Rabbit", "Guinea pig", 
                   "Horseshoe bat", "Myotis bat", "Hipposideros bat", "Donkey")
tissue_names <- c("liver", "kidney", "brain")


data$Species <- factor(data$Species, levels = 1:21, labels = species_names)
data$Tissue <- factor(data$Tissue, levels = 1:3, labels = tissue_names)


p <- ggplot(data, aes(x = Tissue, y = Number, fill = Tissue)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ Species, scales = "free_y") +  
  theme_minimal() +
  labs(x = "Tissue", y = "Number", title = "Number by Species and Tissue") +
  theme(
    legend.position = "none", 
    axis.text.x = element_text(angle = 45, hjust = 1),
    strip.text = element_text(size = 10, face = "bold"),  
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),  
    panel.border = element_rect(colour = "black", fill = NA, size = 1)  
  ) +
  scale_fill_manual(values = c("#C56C66","#D6B36C", "#82B6CE"))  
ggsave(p, file='1transcript_num_m6a.pdf', width=8,height=8)

#violin plot
# Load required libraries
library(ggplot2)

# Read data
data <- read.table("/media/tower/zhangxx/m6a/0data/eventalign/1transcript_num_m6a", header = FALSE)

# Rename columns
colnames(data) <- c("Group", "Subgroup", "Value")

# Convert Subgroup to factor and replace with corresponding tissue names
data$Subgroup <- factor(data$Subgroup, levels = c(1, 2, 3), labels = c("liver", "kidney", "brain"))

# Calculate the mean for each Subgroup
means <- aggregate(Value ~ Subgroup, data, mean)

# Set colors: liver = #82B6CE, kidney = #D6B36C, brain = #C56C66
colors <- c("liver" = "#C56C66", "kidney" = "#D6B36C", "brain" = "#82B6CE")

# Create violin plot with scatter points and mean lines
p <- ggplot(data, aes(x = Subgroup, y = Value)) +
  geom_violin(trim = FALSE, aes(color = Subgroup), fill = NA, size = 1) +  # Violin plot outline
  geom_jitter(aes(color = Subgroup), shape = 16, position = position_jitter(0.2)) +  # Scatter plot
  geom_segment(data = means, aes(x = as.numeric(Subgroup) - 0.2, xend = as.numeric(Subgroup) + 0.2, 
                                 y = Value, yend = Value), color = "black", size = 1) +  # Mean horizontal line
  geom_text(data = means, aes(x = Subgroup, y = Value, label = round(Value, 2)), 
            vjust = -1.5, color = "black") +  # Mean annotation
  scale_color_manual(values = colors) +  # Custom outline and scatter point colors
  theme_minimal() +
  labs(title = "Violin plot with means and jittered points", 
       x = "Tissue", 
       y = "Value") +
  theme(legend.position = "none",  # Hide legend
        axis.line = element_line(color = "black"),  # Add axis lines
        axis.ticks = element_line(color = "black"),  # Add tick marks
        axis.title.x = element_text(size = 12),  # Set x-axis title size
        axis.title.y = element_text(size = 12))  # Set y-axis title size

ggsave(p, file='1transcript_num_m6a.Violin.pdf', width=4, height=4)    
