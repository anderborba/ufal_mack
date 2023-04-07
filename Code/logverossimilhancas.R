library(univariateML)
library(ggplot2)
library(ggthemes)

set.seed(1234, kind="Mersenne-Twister")

z <- rgamma(10000, shape=2, rate=1/5)

v.loglik <- 1000

for(r in 1:1000){
  estimate <- mlgamma(z)
  v.loglik[r] <- attributes(estimate)$logLik
}

v.loglik <- data.frame(loglikelihood = v.loglik)

ggplot(v.loglik, aes(x=loglikelihood)) +
  geom_histogram(bins=nclass.FD(v.loglik$loglikelihood)) +
  theme_tufte()
