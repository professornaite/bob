# generating data frame on atomic bombs and host countries

# libraries
library(tidyverse)
library(dplyr)

# data
nation <- c("Russia", "US", "China", "France", "UK", 
            "Pakistan", "India", "Israel", "North Korea", 
            "Germany", "Turkey", "Italy", "Netherlands", 
            "Belgium", "South Africa", "Japan", "Brazil", 
            "Canada")  # Added Canada
count <- c(4489, 3708, 410, 290, 225, 
           170, 164, 90, 30, 
           0, 0, 0, 0, 
           0, 0, 0, 0, 
           0) # Number of atomic bombs
host <- c(0, 0, 0, 0, 0, 
          0, 0, 0, 0,
          1, 1, 1, 1,
          1, 0, 0, 0,
          1) # Host status (1 = hosts nuclear weapons)
un_perm <- c(2, 2, 2, 2, 2,   # Russia, US, China, France, UK are P5
             0,              # Pakistan
             0,              # India
             0,              # Israel
             0,              # North Korea
             1,              # Germany (non-permanent member)
             1,              # Turkey (non-permanent member)
             1,              # Italy (non-permanent member)
             1,              # Netherlands (non-permanent member)
             1,              # Belgium (non-permanent member)
             0,              # South Africa
             1,              # Japan (non-permanent member)
             0,              # Brazil
             1)              # Canada (non-permanent member)

# Create the host_count column based on the count of atomic bombs for host nations
host_count <- c(NA,
                NA,
                NA,
                NA,
                NA,
                NA,
                NA,
                NA,
                NA,
                20,   # Germany hosts ~20 US bombs
                50,   # Turkey hosts ~50 US bombs
                35,   # Italy hosts ~35 US bombs
                15,   # Netherlands hosts ~15 US bombs
                15,   # Belgium hosts ~15 US bombs
                NA,
                NA,
                NA,
                20)   # Canada hosts ~20 US bombs

# combine into a data frame
df <- data.frame(nation = nation,
                 un = un_perm,
                 atomic.bombs = count,
                 host = host,
                 host_count = host_count)

# display structure of the data frame
str(df)
df %>% as_tibble()

# sort the data frame by atomic.bombs and then by host_count
df <- df %>%
  arrange(desc(atomic.bombs), desc(host_count))

df

# define path
# Make sure the "data" folder exists in your working directory or provide the full path
output <- "data/atomic-bombs.csv"

# save the data
write.csv(df, file = output, row.names = FALSE)

# confirm save
cat("Data frame saved to:", output)
