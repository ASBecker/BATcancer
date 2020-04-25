source('Analysis/cortest.R')

install_load('ggplot2')

ggplot(aes(y=Cancer_diff, x=BAT_diff), data = patient_table) +	
  geom_count() +	
  ggtitle("Cancer evolution vs. change in BAT [median Follow-up]") +	
  labs(x=expression(bold(Delta ~ "BAT")), y=expression(bold(Delta ~ "Cancer")))	

ggplot(aes(y=Cancer_diff, x=BAT_diff), data = patient_table %>% subset(BMI_diff<0)) +	
  geom_count() +	
  ggtitle("Cancer evolution vs. change in BAT [only Patients who lost weight]") +	
  labs(x=expression(bold(Delta ~ "BAT")), y=expression(bold(Delta ~ "Cancer")))

ggplot(aes(y=temp_diff, x=BAT_diff, color=as.factor(Cancer_diff)), data = patient_table) +	
  geom_beeswarm() +	
  ggtitle("Cancer evolution vs. change in BAT [median Follow-up]") +	
  labs(x=expression(bold(Delta ~ "BAT")), y=expression(bold(Delta ~ "Temp.")))	

ggplot(aes(y=as.factor(Cancer_diff), x=as.factor(BAT_diff), color=temp_diff), data = patient_table) +	
  geom_jitter(width=.3, height=.3) + 
  scale_color_gradient2(low="blue", high="red", mid="light grey",
                        name=expression(bold(Delta ~ "7 day temp. [°C]"))) +
  ggtitle("Cancer evolution vs. change in BAT + temperature change [median follow-up]") +	
  labs(x=expression(bold(Delta ~ "BAT")), y=expression(bold(Delta ~ "Cancer")))	

ggplot(aes(y=as.factor(Cancer_diff), x=as.factor(BAT_diff), color=BMI_diff), data = patient_table) +	
  geom_jitter(width=.3, height=.3) + 
  scale_color_gradient(low="blue", high="yellow", name=expression(bold(Delta ~ "BMI"))) +
  ggtitle("Cancer evolution vs. change in BAT + BMI change [median follow-up]") +	
  labs(x=expression(bold(Delta ~ "BAT")), y=expression(bold(Delta ~ "Cancer")))	
