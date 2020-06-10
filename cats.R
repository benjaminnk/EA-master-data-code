#Linear regression of weather on cats
df<-lm(weather~cats, data=data)
summary(df)