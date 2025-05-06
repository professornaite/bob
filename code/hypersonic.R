# Extended hypersonic_data dataset with nuclear variables

hypersonic <- data.frame(
  nation = c("China", "Russia", "United States", "France", "India", "North Korea", "Iran", "United Kingdom", "Japan", "South Korea", "Brazil"),
  hypersonic_weapons = c(5, 4, 1, 1, 1, 1, 1, 0, 0, 0, 0),
  un_status = c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE),
  pop25 = c(1426000000, 144400000, 339000000, 65300000, 1439000000, 25900000, 89200000, 67700000, 123300000, 51700000, 217000000),
  last_war = c(
    "Sino-Vietnamese War, 1979",
    "Invasion of Ukraine, 2022–present",
    "War in Afghanistan, 2001–2021",
    "Intervention in Mali, 2013–present",
    "Kargil War (with Pakistan), 1999",
    "Korean War, 1950–1953",
    "Iran-Iraq War, 1980–1988",
    "War in Afghanistan (with US/NATO), 2001–2014",
    "World War II, 1941–1945",
    "Korean War, 1950–1953",
    "Participation in MINUSTAH (Haiti), 2004–2017"
  ),
  last_war_n = c(
    "China vs Vietnam",
    "Russia vs Ukraine",
    "United States & NATO vs Taliban/Al-Qaeda",
    "France & Allies vs Islamist groups",
    "India vs Pakistan",
    "North Korea & China vs South Korea, US & Allies",
    "Iran vs Iraq",
    "United Kingdom & NATO vs Taliban",
    "Japan vs Allied Powers",
    "South Korea & UN vs North Korea, China",
    "Brazil & UN vs Haitian insurgents"
  ),
  last_war_d = c(
    "1979",
    "2022–present",
    "2001–2021",
    "2013–present",
    "1999",
    "1950–1953",
    "1980–1988",
    "2001–2014",
    "1941–1945",
    "1950–1953",
    "2004–2017"
  ),
  count = c(500, 5580, 5044, 290, 172, 50, 0, 225, 0, 0, 0), # Nuclear warhead counts[1][4][5][6][8]
  host = c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), # None of these host foreign nuclear weapons
  un = c(2, 2, 2, 2, 1, 1, 1, 2, 1, 1, 1), # P5 = 2; other UN members = 1
  host_count = c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), # No foreign nukes hosted
  stringsAsFactors = FALSE
)

print(hypersonic)

df <- hypersonic

# Display structure of the data frame
str(df)
library(tidyverse)
df %>% as_tibble()

# Sort the data frame by hypersonic_weapons and then by host_count
df <- df %>%
  arrange(desc(hypersonic_weapons), desc(host_count))

df

# Define path
# Make sure the "data" folder exists in your working directory or provide the full path
output <- "data/hypersonic-weapons.csv"

# Save the data
write.csv(hypersonic, file = output, row.names = FALSE)

# Confirm save
cat("Data frame saved to:", output)


# plot
# Load necessary libraries
library(ggplot2)
library(dplyr)

# Sort data for better visualization
hypersonic_sorted <- hypersonic %>%
  arrange(desc(hypersonic_weapons))


# Create bar plot and assign to hypersonic_bar
hypersonic_bar <- ggplot(hypersonic_sorted, aes(x = reorder(nation, hypersonic_weapons), y = hypersonic_weapons, fill = as.factor(un))) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  labs(
    title = "Operational Hypersonic Weapons by Country (2025)",
    x = "Country",
    y = "Number of Hypersonic Weapons"
  ) +
  theme_minimal() +
  scale_fill_brewer(palette = "Set1")

# Save the plot to the 'plots' folder
ggsave(filename = "plots/hypersonic_bar.png", plot = hypersonic_bar, width = 8, height = 6, dpi = 300)

# Confirmation message
cat("Plot saved to: plots/hypersonic_bar.png\n")
