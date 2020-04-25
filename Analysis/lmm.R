source('Analysis/prep.R')

install_load('lme4', 'sjPlot')

lme.bat <- lmer(BAT~Cancer+BMI+Sex+Age+mean7dtemp+(1|Pat.ID), data=d.brownfat2)
sjt.lmer(lme.bat, p.kr=FALSE)

lme.batbmi <- lmer(BAT*BMI~Cancer+Sex+Age+mean7dtemp+(1|Pat.ID), data=d.brownfat2)
sjt.lmer(lme.batbmi, p.kr=FALSE)

lme.bat.svm <- lmer(BAT~auto_cancerstage+BMI+Sex+Age+mean7dtemp+(1|Pat.ID), data=d.brownfat2)
sjt.lmer(lme.bat.svm, p.kr=FALSE)

lme.batbmi.svm <- lmer(BAT*BMI~auto_cancerstage+Sex+Age+mean7dtemp+(1|Pat.ID), data=d.brownfat2)
sjt.lmer(lme.batbmi.svm, p.kr=FALSE)
