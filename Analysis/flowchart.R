source('Analysis/prep.R')

install_load('DiagrammeR')

mermaid(paste0('
graph TD
  A2("Pilot <br/>1060 examinations (e\') <br/>1031 patients (n\')")
  A1("Full Cohort <br/>', nrow(d.brownfat),' examinations (e) 
<br/>', nrow(d.singles),' patients (n)")-->
  B1("BMI available: e = ', d.brownfat %>% filter(!is.na(BMI)) %>% nrow(),' (98.5%) 
<br />ICD-10 available: e = ', d.brownfat %>% filter(!is.na(ICD.10)) %>% nrow(),' (98.0%)
<br />Cancer patients: n = ', d.brownfat2 %>% distinct(Pat.ID) %>% nrow(),'")
  B1-->C1("Longitudinal data for n = ', d.multi %>% distinct(Pat.ID) %>% nrow(),'")
  C1-->E1("Active brown fat
<br />e = ', my_data_sel %>% nrow(),' 
<br />n = ', my_data_sel %>% 
                  distinct(Pat.ID, .keep_all=TRUE)  %>% nrow,'")
  A2-->B2("BMI available e\' = 1059 
<br />ICD-10 available: n\' = 1031
<br />Cancer patients: n\' = 977")
  B2-->C2("Longitudinal data for n\' = 53")
  C2-->E2("Active brown fat
<br />e\' = 82
<br />n\' = 33")
  C1-->F1("Histopathological staging <br />from cancer registry <br />n = ', d.histo.svm$Pat.ID %>% unique() %>% length(),'")
'))
