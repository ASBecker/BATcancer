source('Analysis/prep.R')
install_load('plyr', 'ggplot2'); detach(package:plyr)

d.activebat <- d.brownfat2 %>% group_by(Pat.ID) %>% slice(which.max(BAT)) %>% filter(BAT>0) %>% ungroup()
d.inactive <- d.brownfat2 %>% filter(!Pat.ID %in% d.activebat$Pat.ID) %>% group_by(Pat.ID) %>% slice(which.min(Day)) %>% ungroup()

t.test(d.activebat$Age, d.inactive$Age)
t.test(d.activebat$BMI, d.inactive$BMI)
t.test(d.activebat$mean7dtemp, d.inactive$mean7dtemp)

chisq.test(matrix(c(nrow(d.activebat[which(d.activebat$Sex=='F'),]), nrow(d.activebat[which(d.activebat$Sex=='M'),]), 	
                    nrow(d.inactive[which(d.inactive$Sex=='F'),]), nrow(d.inactive[which(d.inactive$Sex=='M'),])),	
                  nrow = 2,	
                  dimnames = list(BMI = c('F', 'M'),	
                                  Cohort = c('BAT+', 'BAT-'))))

d.inactive$Cachexy <- as.factor((d.inactive$BMI>18.5)*1)	
d.inactive$Cachexy <- plyr::revalue(d.inactive$Cachexy, c('0'='<18.5', '1'='>18.5'))	
ggplot(d.inactive, aes(BMI, fill=Cachexy)) + 	
  geom_histogram(color="black", binwidth=1/3) +	
  theme(legend.title=element_blank())

d.activebat$Cachexy <- as.factor((d.activebat$BMI>18.5)*1)	
d.activebat$Cachexy <- plyr::revalue(d.activebat$Cachexy, c('0'='<18.5', '1'='>18.5'))	
ggplot(d.activebat, aes(BMI, fill=Cachexy)) + 	
  geom_histogram(color="black", binwidth=1/3) +	
  theme(legend.title=element_blank())	

CACH <- matrix(c(nrow(d.activebat[which(d.activebat$BMI<18.5),]), nrow(d.activebat[which(d.activebat$BMI>18.5),]), 	
                 nrow(d.inactive[which(d.inactive$BMI<18.5),]), nrow(d.inactive[which(d.inactive$BMI>18.5),])),	
               nrow = 2,	
               dimnames = list(BMI = c('<18.5', '>18.5'),	
                               Cohort = c('BAT+', 'BAT-')))	


chisq.test(CACH)
