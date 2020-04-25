source('Analysis/xsect.R')
source('Analysis/icd10_functions.R')

d.acticd <- left_join(d.activebat, icd_table, by='Pat.ID')
d.inacticd <- left_join(d.inactive, icd_table, by='Pat.ID')
d.allicd <- rbind(d.acticd, d.inacticd)

f.stackICDbar_large(d.acticd,25,title='ICD10 BAT+')	

f.stackICDbar_large(d.inacticd,25,title='ICD10 Top23, BAT-')

# Table with all ICD-10
f.icdtable() #%>% knitr::kable()

#options(max.print= 4000)
glm(BAT~ICD_10*Sex+Age+BMI+mean7dtemp, data=d.allicd) %>% summary() %>% print()

