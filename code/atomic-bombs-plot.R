# create atomic bombs plot

library(ggplot2)
library(dplyr)

# Create the "plots" directory if it doesn't exist
if (!dir.exists("plots")) {
  dir.create("plots")
}

# Create a new column for labels: use 'count' if available, otherwise use 'host_count'
df <- df %>%
  mutate(label = ifelse(!is.na(atomic.bombs) & atomic.bombs > 0, atomic.bombs, host_count))

# Create the bar plot showing total count of atomic bombs colored by UN membership status
p <- ggplot(df, aes(x = reorder(nation, atomic.bombs), y = count, fill = factor(un))) +  # Reorder by count
  geom_bar(stat = "identity") +  # Use stat = "identity" to use the actual counts
  geom_text(aes(label = label), vjust = -0.5) +  # Add labels above bars
  labs(title = "Total Atomic Bombs by Country",
       x = "Country",
       y = "Number of Atomic Bombs",
       fill = "UN Membership Status") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x-axis labels for better readability
        legend.position = "top") +
  scale_fill_manual(values = c("0" = "orange", "1" = "red", "2" = "darkred"))  # Customize colors for UN membership

# Save the plot to the "plots" directory
ggsave(filename = "plots/total_atomic_bombs_by_country.png", plot = p, width = 10, height = 6)

# Optional: Print a confirmation message
cat("Plot saved to 'plots/total_atomic_bombs_by_country.png'\n")
