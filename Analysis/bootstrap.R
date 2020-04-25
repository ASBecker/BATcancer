source('Analysis/cortest.R')
install_load('rsample', 'purrr')

set.seed(42)

best_samples <- bootstraps(patient_table, times=1e4)

corr_BAT_Cancer <- function(splits) {
  x <- analysis(splits)
  cor.test(x$BAT_diff, x$Cancer_diff, method='spearman')
}

corr_BAT_BMI <- function(splits) {
  x <- analysis(splits)
  cor.test(x$BAT_diff, x$BMI_diff, method='spearman')
}

corr_Cancer_BMI <- function(splits) {
  x <- analysis(splits)
  cor.test(x$Cancer_diff, x$BMI_diff, method='spearman')
}

best_samples$bat_can <- map(best_samples$splits, corr_BAT_Cancer)
best_samples$bat_can_rho <- map_dbl(best_samples$bat_can, function(x) x$estimate)
best_samples$bat_can_p <- map_dbl(best_samples$bat_can, function(x) x$p.value)

best_samples$bat_bmi <- map(best_samples$splits, corr_BAT_BMI)
best_samples$bat_bmi_rho <- map_dbl(best_samples$bat_bmi, function(x) x$estimate)
best_samples$bat_bmi_p <- map_dbl(best_samples$bat_bmi, function(x) x$p.value)

best_samples$can_bmi <- map(best_samples$splits, corr_Cancer_BMI)
best_samples$can_bmi_rho <- map_dbl(best_samples$can_bmi, function(x) x$estimate)
best_samples$can_bmi_p <- map_dbl(best_samples$can_bmi, function(x) x$p.value)

quantile(best_samples$bat_can_rho, 
         probs = c(0.025, 0.500, 0.975))

quantile(best_samples$bat_bmi_rho, 
         probs = c(0.025, 0.500, 0.975))

quantile(best_samples$can_bmi_rho, 
         probs = c(0.025, 0.500, 0.975))