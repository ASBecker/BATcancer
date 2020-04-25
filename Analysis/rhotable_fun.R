
f.rhotable <- function(pat_table) {
  rhotable <- rbind(c('Parameters    ', 'Spearman-Rho    ', 'p-value'),	
                    c('BAT-Cancer', cor.test(x=pat_table[, "BAT_diff"], y=pat_table[, "Cancer_diff"], method='spearman', exact=FALSE)$estimate, cor.test(x=pat_table[, "BAT_diff"], y=pat_table[, "Cancer_diff"], method='spearman', exact=FALSE)$p.value),	
                    c('Cancer-BMI', cor.test(x=pat_table[, "BMI_diff"], y=pat_table[, "Cancer_diff"], method='spearman', exact=FALSE)$estimate, cor.test(x=pat_table[, "BMI_diff"], y=pat_table[, "Cancer_diff"], method='spearman', exact=FALSE)$p.value),	
                    c('BAT-BMI',  cor.test(x=pat_table[, "BAT_diff"], y=pat_table[, "BMI_diff"], method='spearman', exact=FALSE)$estimate, cor.test(x=pat_table[, "BMI_diff"], y=pat_table[, "Cancer_diff"], method='spearman', exact=FALSE)$p.value),
                    c('BAT-Temp',  cor.test(x=pat_table[, "BAT_diff"], y=pat_table[, "temp_diff"], method='spearman', exact=FALSE)$estimate, cor.test(x=pat_table[, "BAT_diff"], y=pat_table[, "temp_diff"], method='spearman', exact=FALSE)$p.value))	
}
