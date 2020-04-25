library(dplyr)

# ICD-Barplots ------------------------------------------------------------

f.stackICDbar_large <- function(data,n,title){	
  data <- data %>% subset(!is.na(ICD_10))	
  ICDCountingTopN = sort(table(data$ICD_10),decreasing=T)[1:n]	
  ICDCounts = matrix(0,nrow=n,ncol=2)	
  colnames(ICDCounts) = c('\u2642','\u2640')	
  rownames(ICDCounts) = names(ICDCountingTopN)	
  for(i in 1:length(ICDCountingTopN)){	
    tmp = subset(data, data$ICD_10==names(ICDCountingTopN)[i])	
    ICDCounts[i,1] = length(which(tmp$Sex!='F'))	
    ICDCounts[i,2] = length(which(tmp$Sex=='F'))	
  }	
  barplot(t(ICDCounts),las=2,main=title,legend=T)	
}	


# ICD-Table ---------------------------------------------------------------

f.icdtable <- function(df_inact=d.inacticd, df_act=d.acticd) {
  compute_percentage <- function(x, n) return((x/n*100) %>% round(1) %>% paste0(' %'))
  n1 <- nrow(df_inact)
  n2 <- nrow(df_act)
  col1 <- df_inact %>% .$ICD_10 %>% table() %>% as.data.frame()
  col2 <- df_act %>% .$ICD_10 %>% table() %>% as.data.frame()
  col1 %<>% mutate(Perc_ina=compute_percentage(Freq, `n1`))
  col2 %<>% mutate(Perc_act=compute_percentage(Freq, `n2`))
  icdtable <- left_join(col1, col2, by='.') %>% arrange(desc(Freq.y))
  colnames(icdtable) <- c('ICD-10', 'BAT-Inact. (n)', 'BAT-Inact. (%)', 'BAT-Act. (n)', 'BAT-Act. (%)')
  return(icdtable)
}
