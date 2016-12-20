###########################################
#   First simulations of the fossil record
# using David Bapst's function.
##########################################

simFossilRecord # for simulation
### Input
# p, q, r = 0, anag.rate = 0
# prop.bifurc = 0, prop.cryptic = 0
# modern.samp.prob = 1
# startTaxa = 1
# nruns = 1
# maxAttempts = Inf
# totalTime = nTotalTaxa = nExtant = nSamp = c(0, 1000)
# tolerance = 10^-4
# maxStepTime = 0.01
# shiftRoot4TimeSlice = "withExtantOnly"
# count.cryptic = FALSE
# negRatesAsZero = TRUE
# print.runs = FALSE
# sortNames = FALSE
# plot = FALSE
### Output
# taxon.id: The ID number of this particular taxon-unit.
# ancestor.id: The ID number of the ancestral taxon-unit. The initial taxa in a simulation will be listed with NA as their ancestor.
# orig.time: True time of origination for a taxon-unit in absolute time.
# ext.time: True time of extinction for a taxon-unit in absolute time. Extant taxa will be listed with an ext.time of the run-end time of the simulation run, which for simulations with extant taxa is 0 by default (but this may be modified using argument shiftRoot4TimeSlice).
# still.alive: Indicates whether a taxon-unit is 'still alive' or not: '1' indicates the taxon-unit is extant, '0' indicates the taxon-unit is extinct
# looks.like: The ID number of the first morphotaxon in a dataset that 'looks like' this taxon-unit; i.e. belongs to the same multi-lineage cryptic complex. Taxa that are morphologically distinct from any previous lineage will have their taxon.id match their looks.like. Thus, this column is rather uninformative unless cryptic cladogenesis occurred in a simulation.

fossilRecord2fossilTaxa # to convert the output to a more interpretable table




library(paleotree)
source("auxiliary_functions.R")
# Using parameters from my thesis
# Carnivora p=0.19, q=0.13, freqRatio = 0.57
# fossil occurrences = 7578-1710
# number of genera = 456-565
set.seed(666)
sim1 = simFossilRecord(p = 0.19, q = 0.13, r = 0.57,
                       maxAttempts = 100,
                       totalTime = c(0, 1000), nTotalTaxa = c(400, 600), 
                       nExtant = c(0, Inf), nSamp = c(0, Inf),
                       print.runs = TRUE)
fossil1 = fossilRecord2fossilTaxa(sim1)
head(fossil1)

fossil2plot(fossil1)

fr = list2fr(sim1, 50)
fr
y = apply(fr, 2, function(x) sum(x>0))
x = as.numeric(names(y))
lines(x , y, type="l", col = "red")
#fossil1 = lapply(sim1, fossilRecord2fossilTaxa)
#multiDiv(fossil1, plotMultCurves=TRUE)


















