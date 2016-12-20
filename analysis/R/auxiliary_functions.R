




fossil2plot = function(fr, plot = TRUE){
  #   Converts the output from 'fossilRecord2fossilTaxa' into a matrix with the
  # diversity (y) through time (x)
  x = c(fr[, "orig.time"], fr[, "ext.time"])
  control = c(rep(1, nrow(fr)), rep(-1, nrow(fr)))
  control[x == 0] = 0
  control = control[order(x, decreasing = TRUE)]
  x = sort(x, decreasing = TRUE)
  y = cumsum(control)
  if(plot == TRUE){
    plot(x, y, xlim=rev(range(x)), xlab = "Time (Ma)", ylab = "Diversity", type = "l")
  }
  return(data.frame(x = x, y = y))
}



list2fr = function(sim, timeScale = "geological"){
  #   Gets the output from 1 simulation of 'simFossilRecord' and converts to a 
  # data.frame with the number of occurrences for each lineage per interval.
  # - 'sim' is the list, output from 'simFossilRecord'
  # - 'timeScale' controls how to many times one wants to divide the time; if a numerical value is specified, the number will be interpreted as the number of divisions; if "geological" is specified (DEFAULT), the geological time scale will be used instead
  init = ceiling(sim[[1]][[1]]["orig.time"])
  boolean = sapply(sim, FUN = function(x){ifelse(length(x[[2]])>0, TRUE, FALSE)})
  sim = sim[boolean]
  if(class(timeScale) == "numeric"){
    times = round(seq(from = init, to = 0, length.out = timeScale), 3)
  } else if(timeScale == "geological"){
    load(file = "stages.RData")
    times = rev(tab$late_age[1:match(FALSE,tab$late_age<init)])
    timeScale = length(times)
  } else stop("timeScale is wrong!")
  res = data.frame(matrix(0, nrow = length(sim), ncol = timeScale), 
                   row.names = names(sim))
  colnames(res) = times
  for(i in 1:length(sim)){
    foo = sapply(sim[[i]][[2]], function(x) x<=times)
    ind = apply(foo, MARGIN = 2, FUN = function(x) match(FALSE, x))-1
    ind[is.na(ind)] = timeScale
    for(k in 1:length(ind)) res[i, ind[k]] = res[i, ind[k]]+1
  }
  return(res)
}


