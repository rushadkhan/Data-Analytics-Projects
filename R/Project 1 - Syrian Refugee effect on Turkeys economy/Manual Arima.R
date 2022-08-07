library(httr)
library(jsonlite)
library(tidyverse)
library(lubridate)
library(imputeTS)
library(ggplot2)
library(dplyr)
library(viridis)
library(scales)
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

#Plotting the graph
plot(data$date, data$CPI_apparel, main="Clothing & footwear CPI of Turkey", xlab = "date", ylab ="CPI", type="o",col="navy blue")
plot(data$date, data$CPI_national, main="National CPI of Turkey", xlab = "date", ylab ="CPI", type="o",col="navy blue")
plot(data$date, data$Refugee, main="Syrian Refugee movement in Turkey", xlab = "date", ylab ="Syrian Refugees", type="o",col="navy blue")

#box test
Box.test(data$CPI_apparel)
Box.test(data$CPI_national)
Box.test(data$Refugee)

#Diffrencing
CPI_apparel_diff <- diff(data$CPI_apparel, differences = 1)
plot(CPI_apparel_diff, type="o", col="red")
diff(data$CPI_apparel, differences = 1)

CPI_national_diff <- diff(data$CPI_national, differences = 1)
plot(CPI_national_diff, type="o", col="red")

Refugee_diff <- diff(data$Refugee, differences = 1)
plot(Refugee_diff, type="o", col="red")

#ACF
acf <- acf(CPI_apparel_diff)
acf1 <- acf(CPI_national_diff)
acf2 <- acf(Refugee_diff)

#PACF
pacf <- pacf(CPI_apparel_diff)
pacf1 <- pacf(CPI_national_diff)
pacf2 <- pacf(Refugee_diff)

#Auto Arima to confirm observations
auto.arima(data$CPI_apparel, trace=T)
auto.arima(data$CPI_national, trace=T)
auto.arima(data$Refugee, trace=T)

#forecast
datafit <- arima(data$CPI_apparel, order=c(0,1,0))
AIC(datafit)
BIC(datafit)
datafit

datafit1 <- arima(data$CPI_national, order=c(0,0,0))
AIC(datafit1)
BIC(datafit1)
datafit1

datafit2 <- arima(data$Refugee, order=c(1,1,0))
AIC(datafit2)
BIC(datafit2)
datafit2

#forecast
forecast <- forecast(datafit, h=1)
plot(forecast, type= "l", col="blue")
print(summary(forecast))

forecast1 <- forecast(datafit1, h=1)
plot(forecast1, type= "l", col="blue")
print(summary(forecast1))

forecast2 <- forecast(datafit2, h=2)
plot(forecast2, type= "l", col="blue")
print(summary(forecast2))

par(mar = c(1,1,1,1)) #Added this in because of Error Figure margins were too large
forecast$fitted
forecast$residuals
tsdiag(datafit)

forecast1$fitted
forecast1$residuals
tsdiag(datafit1)

forecast2$fitted
forecast2$residuals
tsdiag(datafit2)

#relative errors
plot(forecast$residuals)
plot(forecast1$residuals)
plot(forecast2$residuals)

#forecast values
forecast$fitted
forecast1$fitted
forecast2$fitted

#errors
residuals <- c(forecast$residuals)
error <-  residuals/data$CPI_apparel
error
error <- round(error, 3)
error

residuals1 <- c(forecast1$residuals)
error1 <-  residuals1/data$CPI_national
error1
error1 <- round(error1, 3)
error1

residuals2 <- c(forecast2$residuals)
error2 <-  residuals2/data$Refugee
error2
error2 <- round(error2, 3)
error2

#figure
plot(data$date, data$CPI_apparel, type="o", col="dark blue", ylab= "CPI", main="ARIMA for forecasting Apparel CPI% change")
lines(data$date, forecast$fitted, type="o", col="dark red")
par(new=T)
plot(data$date, forecast$residuals, axes=F, type="o", col="dark green", ylab= "")
axis(4,col="green",col.axis="dark green")
legend("topleft", legend=c("source", "forcast", "residuals"), col=c(1,2,3), lty=1, cex=0.6)

#Figure 1
plot(data$date, data$CPI_national, type="o", col="blue", ylab= "CPI", main="ARIMA for forecasting National CPI% change")
lines(data$date, forecast1$fitted, type="o", col="red")
par(new=T)
plot(data$date, forecast1$residuals, axes=F, type="o", col="green", ylab= "")
axis(4,col="green",col.axis="green")
legend("topleft", legend=c("source", "forcast", "residuals"), col=c(1,2,3), lty=1, cex=0.6)

#Figure 2
plot(data$date, data$Refugee, type="o", col="blue", ylab= "Syrian Refugees", main="ARIMA for forecasting Syrian Refugee movement")
lines(data$date, forecast2$fitted, type="o", col="red")
par(new=T)
plot(data$date, forecast2$residuals, axes=F, type="o", col="dark green", ylab= "")
axis(4,col="green",col.axis="green")
legend("topleft", legend=c("source", "forcast", "residuals"), col=c(1,2,3), lty=1, cex=0.6)



















