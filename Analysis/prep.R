if (!require('install.load')) install.packages('install.load')

install.load::install_load('dplyr', 'purrr','zoo', 
             'magrittr', 'readr', 'stringr')

d.brownfat <- read_csv('Data/anon_brownfat.csv')
d.histo.svm <- read_csv('Data/anon_svm_histo.csv')

canc_pid <- d.brownfat %>% filter(str_detect(ICD.10, '^C')) %>% distinct(Pat.ID) %>% .$Pat.ID
d.brownfat2 <- d.brownfat %>% filter(Pat.ID %in% canc_pid)

d.singles <- d.brownfat %>% group_by(Pat.ID) %>% 
                            slice(which.min(Day))

d.multi <- d.brownfat2 %>% group_by(Pat.ID) %>% 
                          filter(n()>1)
  
d.multi %>% group_by(Pat.ID) %>% summarise(count=n()) %>% .$count %>% quantile(c(.025,.25,.5,.75,.975))

my_labels <- d.multi %>% distinct(Pat.ID, .keep_all=TRUE) %>% .$ICD.10
names(my_labels) <- d.multi %>% distinct(Pat.ID) %>% .$Pat.ID

longit_bat_pid <- d.multi %>% group_by(Pat.ID) %>% slice(which.max(BAT)) %>% distinct(Pat.ID) %>% .$Pat.ID
best_median <- d.multi %>% filter(Pat.ID %in% longit_bat_pid) %>% .$Day.diff %>% median(na.rm = TRUE)

my_data_sel <- d.multi %>% filter(!is.na(Cancer))	%>% 
  filter(!is.na(BMI)) %>%
  group_by(Pat.ID) %>% 
  filter(sum(BAT)>0) %>%
  filter(n()>1) %>% 
  mutate(Day.diff=Day-lag(Day),
         diffTemp=mean7dtemp-lag(mean7dtemp),
         diffBMI=BMI-lag(BMI)) %>% 
  ungroup()

icd_table <- d.brownfat2 %>% group_by(Pat.ID) %>%
                             slice(which.max(Day)) %>% 
                             .[,c('Pat.ID', 'ICD.10')]
colnames(icd_table)[2] <- 'ICD_10'
