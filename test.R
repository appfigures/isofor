
library(isofor)
library(microbenchmark)

data(titanic, package="binnr")

titanic$Age[is.na(titanic$Age)] <- 0

mod <- iForest(titanic, 500, 32)
p1 <- predict(mod, titanic, n.cores=1L)
p2 <- predict(mod, titanic, n.cores=4L)


microbenchmark(
  old = predict(mod, titanic, n.cores=1),
  new = predict(mod, titanic, n.cores=4), times=5L)

x <- titanic

for (i in 1:10) x <- rbind(x, x)

mod <- iForest(x, 500, 64, multicore = TRUE)
p1 <- predict(mod, x, n.cores = 4)


x <- mtcars

for (i in 1:3) x <- rbind(x, x)

microbenchmark(
  new=predict(mod, titanic, iterative = TRUE),
  old=predict(mod, titanic, iterative = FALSE), times = 5L)

