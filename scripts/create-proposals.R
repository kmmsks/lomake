library(here)

dir.create(here('data','proposals'), recursive = TRUE, showWarnings = FALSE)

prop1 <- data.frame(author='prof. J', synopsis='important topic relatet to the ncp', opinion='foo', prop_type='s')
prop2 <- data.frame(author='T. Tötterström', synopsis='new results', opinion='bar', prop_type='s')
prop3 <- data.frame(author='MD M.D', synopsis='meaning of life', opinion='quu', prop_type='s')
prop4 <- data.frame(author='Matti Matto', synopsis='very important things', opinion='foobar', prop_type='rt')
prop5 <- data.frame(author='Matt Mat', synopsis='very important vision', opinion='none', prop_type='rt')
ls_prop <- list(prop1, prop2, prop3, prop4, prop5)

lapply(1:length(ls_prop), function (x) write.csv(ls_prop[[x]], file=here('data', 'proposals', paste0(x,'.csv'))))