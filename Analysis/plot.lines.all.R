source('Analysis/cortest.R')

install_load('ggplot2')

ggplot(data=my_data_sel) +
  geom_line(aes(x=Day, y=BAT, col='BAT')) +
  geom_line(aes(x=Day, y=(BMI/15)^1.5, col='BMI')) +
  geom_line(aes(x=Day, y=Cancer, col='Cancer')) +
  geom_line(aes(x=Day, y=mean7dtemp/9+1.305, col='Temp')) +

  geom_point(aes(x=Day, y=BAT, col='BAT')) +
  geom_point(aes(x=Day, y=(BMI/15)^1.5, col='BMI')) +
  geom_point(aes(x=Day, y=Cancer, col='Cancer')) +
  geom_point(aes(x=Day, y=mean7dtemp/9+1.305, col='Temp')) +

  facet_wrap(~Pat.ID, labeller = labeller(Pat.ID = my_labels),
             scales='free_x') +
  theme(legend.title=element_blank()) + ylab('')

ggsave('Presentation/all_patients_incl_temp.pdf', device='pdf', width = 40, height=30)
