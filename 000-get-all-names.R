##############################################

## extract names from all dataframes in the list
b.lst.dat.names <- lapply(a.lst.dat, names)
b.lst.dat.ra.names <- lapply(a.lst.dat.ra, names)
b.lst.lookup.names <- lapply(a.lst.lookup, names)
b.lst.df.names <- lapply(a.lst.df, names)
b.lst.df.ra.names <- lapply(a.lst.df.ra, names)
b.lst.df.sa.names <- lapply(a.lst.df.sa, names)
b.lst.filt.names <- lapply(a.lst.filt, names)

##############################################

b.lst.names <- list(b.lst.dat.names, b.lst.dat.ra.names, b.lst.lookup.names, 
                    b.lst.df.names, b.lst.df.ra.names, b.lst.df.sa.names, b.lst.filt.names)

setwd(dest)
#lapply(b.lst.names, function(x) sink(capture.output(x), 'test.txt' , append=TRUE)) ## not working
