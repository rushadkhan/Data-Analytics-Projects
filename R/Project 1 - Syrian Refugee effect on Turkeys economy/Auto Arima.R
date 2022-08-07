library(tidyverse)
library(tseries)
library(forecast)

#start fresh
rm(list=ls())

#setting working directory
setwd("D:/")

#import the dataset
data <- read.csv(file.choose())

#check class of dataset
class(data)

#Converting dataframe to a time series object
CPI_apparel <- ts(data[,'CPI_apparel'], start=c(2005))
CPI_national <- ts(data[,'CPI_national'], start=c(2005))
Refugee <- ts(data[,'Refugee'], start=c(2005))

#plotting the graph
autoplot(CPI_apparel) + ggtitle("Clothing & footwear CPI of Turkey") + ylab("CPI annual % change")
autoplot(CPI_national) + ggtitle("National CPI of Turkey") + ylab("CPI annual % change")
autoplot(Refugee) + ggtitle("Syrian Refugee in turkey") + ylab("Syrian Refugees")

#Building the ARIMA model
fit_ARIMA <- auto.arima(CPI_apparel, seasonal = TRUE)
fit_ARIMA1 <- auto.arima(CPI_national, seasonal = TRUE)
fit_ARIMA2 <- auto.arima(Refugee, seasonal = TRUE)

#printing the summary of the ARIMA models
print(summary(fit_ARIMA)) #Output: ARIMA(0,1,0)
print(summary(fit_ARIMA1)) #Output: ARIMA(0,0,0)
print(summary(fit_ARIMA2)) #Output: ARIMA(1,1,0)

#checking residulas
checkresiduals(fit_ARIMA)
checkresiduals(fit_ARIMA1)
checkresiduals(fit_ARIMA2)

#Forecast
fcast <- forecast(fit_ARIMA, h = 2)
autoplot
plot(fcast)
print(summary(fcast))

fcast1 <- forecast(fit_ARIMA1, h = 2)
autoplot
plot(fcast1)
print(summary(fcast1))

fcast2 <- forecast(fit_ARIMA2, h = 2)
autoplot
plot(fcast2)
print(summary(fcast2))
