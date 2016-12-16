

anolis = read.csv("analysis/data/anolis.convergence.csv")
head(anolis)


library(ggplot2)
library(ggforce)
gg0 = ggplot(anolis, aes(SVLength, FemurLength, colour = Island)) +
  geom_point() +
  facet_zoom(xy = Ecomorph == "Crown-Giant")
gg0

ggsave("analysis/output/anolis_zoom.pdf", plot = gg0)


library(dplyr)
ann = anolis %>% 
  group_by(Ecomorph, Island) %>% 
  summarise("mean" = mean(SVLength),
            "sd" = sd(SVLength))
ann

gg1 = ggplot(ann, aes(Ecomorph, mean, colour = Island)) + 
  geom_point(stat = "identity") +
  geom_pointrange(aes(ymax = mean + sd, ymin = mean - sd))
gg1


ggsave("analysis/output/anolis_mean.pdf", plot = gg1)
