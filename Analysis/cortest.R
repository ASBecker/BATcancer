source('Analysis/prep.R')
source('Analysis/rhotable_fun.R')


# PET-Grading / Histology -------------------------------------------------

d.histo.svm %<>% mutate(path.stadium=factor(`Final Stadium`, ordered=TRUE))
cor.test(as.numeric(d.histo.svm$path.stadium), d.histo.svm$auto_cancerstage, method='spearman')
cor.test(as.numeric(d.histo.svm$path.stadium), d.histo.svm$cancerstage, method='spearman')


# Longitudinal Analysis ---------------------------------------------------

my_data_sel %<>% arrange(Pat.ID, Day)

ix <- my_data_sel %>% ungroup() %>% mutate(rownr=row_number()) %>% group_by(Pat.ID) %>% 
  slice(which.min(abs(Day.diff-best_median))) %>% .$rownr

patient_table <- my_data_sel[c(ix, (ix-1)),] %>% 
  group_by(Pat.ID) %>% arrange(Pat.ID, Day) %>% 
  mutate(BMI_diff=BMI-lag(BMI),
         BAT_diff=BAT-lag(BAT),
         Cancer_diff=Cancer-lag(Cancer),
         temp_diff=mean7dtemp-lag(mean7dtemp)) 
patient_table %<>% .[seq(2,nrow(patient_table), by=2),] %>%
  as.data.frame() 

rhotable <- f.rhotable(patient_table)

# Subgroup Analysis aka Fishing Expedition --------------------------------

select_cancers <- list('C43','C34',c('C16','C15','C25'),c('C01','C04','C09','C10'))	

f.caloop <- function(x, cachexia=FALSE) {	
  cat('Cancer: ', x %>% unlist())	
  subgroup <- d.brownfat2 %>% filter(ICD.10 %in% x) %>% .$Pat.ID	
  if (cachexia==TRUE) {
    f.rhotable(patient_table %>% filter(Pat.ID %in% subgroup & BMI<18.5))
  } else {  
    f.rhotable(patient_table %>% filter(Pat.ID %in% subgroup))	
  }
}	

rhotable_all_select <- f.caloop(select_cancers)	

lapply(select_cancers, f.caloop)	

rhotable_loss <- f.rhotable(patient_table %>% filter(BMI_diff<0))
