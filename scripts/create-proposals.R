library(here)

dir.create(here('data','proposals'), recursive = TRUE, showWarnings = FALSE)

prop1 <- data.frame(author='prof. J', synopsis='important topic relatet to the ncp')
prop2 <- data.frame(author='T. Tötterström', synopsis='new results')
ls_prop <- list(prop1, prop2)

lapply(1:length(ls_prop), function (x) write.csv(ls_prop[[x]], file=here('data', 'proposals', paste0(x,'.csv'))))
       