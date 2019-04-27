# Beta Diversity Calculations

# Load data and packages

library(microbiome)
library(dplyr)
data(peerj32)
pseq <- peerj32$phyloseq


# Calculate group difference

b.pla <- divergence(subset_samples(pseq, group == "Placebo"))
b.lgg <- divergence(subset_samples(pseq, group == "LGG"))

# View differences using boxplot

boxplot(list(LGG = b.lgg, Placebo = b.pla))

# Example of Beta diversity change over time

data(atlas1006)
pseq <- atlas1006

# Identify subject with the longest time series (most time points)
s <- names(which.max(sapply(split(meta(pseq)$time, meta(pseq)$subject), function (x) {length(unique(x))})))

# Pick the metadata for this subject and sort the samples by time

library(dplyr)
df <- meta(pseq) %>% filter(subject == s) %>% arrange(time)

# Calculate the beta diversity between each time point and the baseline (first) time point
beta <- c(0, 0) # Baseline similarity
s0 <- subset(df, time == 0)$sample
for (tp in df$time[-1]) {
  # Pick the samples for this subject
  #If the same time point has more than one sample, pick one at random
  st <- sample(subset(df, time == tp)$sample, 1)
  a <- abundances(pseq)
  b <- 1 - cor(a[, s0], a[, st], method = "spearman")
  beta <- rbind(beta, c(tp, b))
}
colnames(beta) <- c("time", "beta")
beta <- as.data.frame(beta)

library(ggplot2)
p <- ggplot(beta, aes(x = time, y = beta)) +
  geom_point() + geom_line()
print(p)  
