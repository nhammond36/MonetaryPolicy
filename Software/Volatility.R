# Loading
#library("dplyr")
library(tidyverse)
library(dslabs)
library(lubridate)
library(rugarch)

# --------------- READ DATA ------------------
headers=  read.csv('C:/Users/Zenobia/Documents/Research/MonetaryPolicy/MonetaryPolicy/Data/dailyovernightratesbriefv2.csv',header=F, nrows=1,as.is=T)
spread <- read.csv('C:/Users/Zenobia/Documents/Research/MonetaryPolicy/MonetaryPolicy/Data/dailyovernightratesbriefv2.csv',header=TRUE, sep=",",dec=".",stringsAsFactors=FALSE,skip=4)
colnames(spread)=headers

class(spread)
spread %>% replace(is.na(.),0)
str(spread)
#spread[1] "data.frame"
#rm(spread)
 #,rowIndex = 4:1715, colIndex = 1:52)
#skip=4
#R Data Import/Export manual.
# Check that the data were read correctly, and inspect the table:
nrow(spread) # [1] 1710
ncol(spread) # [1] 37
head(spread)
tail(spread)
summary(spread)
length(spred) #   1244          47
class(spread$Time)
spread$Time <-mdy(spread$Time)
spread$date <= as.Date(spread$Time)
sdate <- as.Date(date, format, tryFormats = c("%m-%d-%Y", "%m/%d/%Y"), optional = FALSE)

# FIND THIS FILE
#mshocks=read.csv('C:/Users/Owner/Documents/Research/MonetaryPolicy/Data/onrates_table_weekdayv8.csv',header=TRUE, sep=",",dec=".",stringsAsFactors=FALSE,skip=4));
#class(spread)
#mshocks %>% replace(is.na(.),0)
#str(mshocks)

# -------------- WRANGLE DATA
rrbp<-  select(spread,EFFR,OBFR,TGCR,BGCR,SOFR)
rrbp<-rrbp*100;
vold<-select(spread, volumeEFFR,volumeOBFR,volumeTGCR,volumeBGCR,volumeSOFR);
ior<-mutate(spread,IORR*100);
#sofr<-spread[1:1711,43]*100;
rrpreward<-mutate(spread,RRPONTSYAWARD*100);
target<- select(spread,TargetD,TargetU);
target(isnan(target))=0; # ind <- is.na(z)
targetbp<-target*100;
vdsum=sum(vold(1:1711,1:5),2); #wrates1(:,2:2:10),2);                %
begintarget = 789-447+1;
quantileeffr=select(spread,Percentile1,Percentile25,Percentile75,Percentile99)
#5:8)*100; 
quantileobfr=spread(1:1711,13:16); # NaN until 4/19/2019
quantiletgcr=spread(1:1711,21:24);
quantilebgcr=spread(1:1711,28:32);
quantilesofr=spread(1:1711,37:40)
#
#
#-------------------- Dates
# ## S3 method for class 'character'
# as.Date(x, format, tryFormats = c("%Y-%m-%d", "%Y/%m/%d"),
#        optional = FALSE, ...)
## S3 method for class 'numeric'
# as.Date(x, origin, ...)
class(spread$Time)
#[1] "character"  3/4/2016 0:00
#print(spread$Time)
#[1] "3/7/2016 0:00"   "3/8/2016 0:00"   "3/9/2016 0:00" 
#mydate<-as.POSIXct(spread$Time,format = "%m/%d/%Y %H:%M")
#sdate<-as.Date(mydate)
sdate<-as.Date(spread$Time,"%m/%d/%Y") 

# plot daily sample rates
#nf =  1  Select sample
#1 03/04/2016 - 12/29/2022 NYFed rates series start date  4
# p<-ggplot(data=rrbp)
# p +  Layer2 + layer 2
spread %>% ggplot() + geom_point(aes(x=sdate, y=rrbp, size=2))+ geom_text(aes(x=Time, y=rrbp,label=abb))
#rlang::last_trace()
print(p)
# ggsave("stations.png",p,dpi = 200)
# ggsave("stations.pdf",p)

#
# plot daily sample volumes
#
# plot daily epoch rates
#begn = [4 860 924  1033 1517 4];
#endn = [859 923 1032 1516 1714 1714];
#1. normalcy   3/4/2016		7/31/2019      4  859
#2. mid cycle adjustment 8/1/2019 - 10/31/2019 737660 
#860 - 923
#3. covid 11/1/2019	    3/16/2020   924  1032
#4. zlb         3/17/2020- 3/16/2022     1032-1516
#4. Taming inflation 03/17/2022 - 12/29/2022 1517-1714
#NO! inflation   5/5/2022		12/29/2022 1517  1714
# Redo -3 for each position for nrow=1710
normalcy <-rrbp %>% slice(4:859)
adjust <-rrbp %>% slice(860:923)
covid <-rrbp %>% slice(924:1032)
zlb <-rrbp %>% slice(1032:1516)
inflation <-rrbp %>% slice(1517:1714)


# ----------------------- Different realized volatility measures

  # Use 252 day trailing window of std calculate three ways
  # Volatility is calculated using publicly released weekly snapshots for 
  # 52-week trailing windows, as the standard deviation of the first difference
  # M = movstd(A,k) returns an array of local k-point standard deviation value
  # a. log(r_t)-log(r_{t+1})
  # b. std deviation (log(r_t)-log(r_{t+1}))
  # c. movstd(vol_b,244) with kernel K=244 or 252
  # Both models are estimated via OLS on daily data, using a 260-day rolling window 
  # to allow their parameters to adapt to a changing environment.
  # 
  # Hamilton Figure 1 displays the sample histogram for fid, drawn for comparison with the Normal distribution. Forty-six percent of the observations are exactly zero, 
  # while 25 observations exceed 5 standard deviations. If fid were an i.i.d. Gaussian time series, one would not expect to see even one 5 standard deviation outlier. Often these outliers occur on days that Gurkaynak, Sack, and
  # 
  # 
  # While GARCH, FIGARCH and stochastic volatility models propose statistical
  # constructions which mimick volatility clustering in financial time series, they
  # do not provide any economic explanation for it.
  # 
  # Duffie Among our other explanatory variables are measures of the volatility of the federal funds rate and of the 
  # strength of the relationship between pairs of counterparties. In
  # to capture the volatility of the federal funds rate, we start with 
  # a dollar-weighted average during a given minute t of the interest rates of all loans made in that minute. 
  # We then measure the time-series sample standard deviation of these minute-by-minute average rates 
  # over the previous 30 minutes, denoted or(t). 
  # The median federal funds rate volatility is about 3 basis points, but ranges from under 1 basis point to 87 basis points, with a sample standard deviation of 4 basis points. Our measure of sender-receiver relationship strength for a particular pair (i,j) of counterparties, denoted Sij, is the dollar volume of transactions sent by i to j over the previous month divided by the dollar volume of all trans- actions sent by i to the top 100 institutions. The receiver-sender relationship strength Rij is the dollar volume of transactions received by i from j over the previous month divided by the dollar volume of all transactions received by i from
  # 
  # The formal definition of the primary metric I study, market volatility, is the standard deviation of 1
  # minute returns: s
  # ⌃Ni
  # =sqrt(sum 1 through n(ri -rbar)^2/(n-1))
  


measure1 = zeros(endn(k),5);
measure2 = zeros(endn(k),5);
measure3 = zeros(endn(k),5);
measure4 = zeros(endn(k),5);

# my_vector <- rep(0, 5)

# Define the dimensions of the matrices
# k <- 10  # Replace with the desired value for 'k'
# n <- 5   # Replace with the desired value for 'n'
# 
# # Create the matrices filled with zeros
# measure1 <- matrix(0, nrow = k, ncol = n)
# measure2 <- matrix(0, nrow = k, ncol = n)
# measure3 <- matrix(0, nrow = k, ncol = n)
# measure4 <- matrix(0, nrow = k, ncol = n)


# x <- 10
# if (x > 15) {
#   print("x is greater than 15")
# } else if (x > 5) {
#   print("x is greater than 5 but not greater than 15")
# } else {
#   print("x is not greater than 5")
# }


if(rates == 1)
{ #measure1(begn(k)+1:endn(k),:) = abs(rrbp(begn(k)+1:endn(k),:)-rrbp(begn(k):endn(k)-1,:));
#measure2(begn(k)+1:endn(k),:) = abs(rrbp(begn(k)+1:endn(k),:)-rrbp(begn(k)+1:endn(k)-1,3));
measure1 <- log(rrbp(begn(k)+1:endn(k),))-log(rrbp(begn(k):endn(k)-1,));
measure2 <-  std(measure1)  #(:,1:5))
measure3  <-  movstd(measure1,244)}
elseif (rates ==0) {
measure1(begn(k)+1:endn(k),)  <-  abs(vold(begn(k)+1:endn(k),)-rrbp(begn(k):endn(k)-1,));
measure2(begn(k)+1:endn(k),)  <-  abs(vold(begn(k)+1:endn(k),)-rrbp(begn(k)+1:endn(k)-1,3));
measure3(begn(k)+1:endn(k),)  <-  log(vodl(begn(k)+1:endn(k),))-log(rrbp(begn(k):endn(k)-1,))}


# What is this?
volrates1(begn(k)+1:endn(k),)  <-  measure3(begn(k)+1:endn(k),); # log pct change
volrates2(begn(k)+1:endn(k),2)  <-  movstd(measure(,2),252);
volrates3(begn(k)+1:endn(k),)  movstd(measure3(begn(k)+1:endn(k),),252);

# ---------------------- EGARCH model
garchMod <- ugarchspec(variance.model = list(model = "eGARCH", garchOrder = c(1, 1)),
                       mean.model = list(armaOrder = c(0, 0)),
                       distribution.model = "norm")


fit<-ugarchfit(spec=garchMod,data=ret,solver="hybrid")
forecast<-ugarchforecast(fit,data=ret,n.ahead=22)
egarch30d<-mean(forecast@forecast$sigmaFor)*sqrt(252)
# see stockoverflow


# -------------------- SIMPLE MODELS
xx1=[rrbp(begn(k)+1:endn(k),:)];
xx2=[rrbp(begn(k)+1:endn(k),:) SOFR_IOR(begn(k)+1:endn(k)) EFFR_IOR(begn(k)+1:begn(k)) ONRRP_IOR(begn(k)+1:begn(k))]
xx3=[rrbp(begn(k)+1:endn(k),:) IOR(begn(k)+1:endn(k)) ONRRP(begn(k)-1:endn(k))]
%be=rrbp(begn(k):endn(k)-1,1)/rrbp(begn(k)+1:endn(k),1)
%
% Rates
[theta1,sec1,R2,R2adj,vcv,F1] = olsgmm(rrbp(begn(k):endn(k)-1,:),xx1,nlag,nw);  % constant
%param1 = [theta1 sec1,R2,R2adj,F1]
vcv1

[theta2,sec2,R2,R2adj,vcv,F2] = olsgmm(rrbp(begn(k):endn(k)-1,:),xx2,nlag,nw);  % constant
%param2 = [theta2 sec2,R2,R2adj,F2]
vcv

[theta3,sec3,R2,R2adj,vcv,F3] = olsgmm(rrbp(begn(k):endn(k)-1,:), xx2,nlag,nw)
%param3 = [theta3 sec3 R2,R2adj,vcv,F3]

# ------------ Bertolini EFARCH
The resulting variance for the FFR is

r <-rrbp
mu <-mean(r)
rstar <- targetbp
aigma2 <- square(r-mu)
$$log(\sigma^2_t -\omega h_t -\psi \nu_t -(1+\gamma N_t)=\sigma^2_{t=1}  -\omega h_{t-1} -\psi \nu_{t-1}  -(1+\gamma N_{t-1} )+\alpha \abs(\nu_{t-1} ) + \Theta \nu_{t-1} 
      
      
# --------------- Notes ---------------------
# is the matrix of element by element products and
#> A %*% B is the matrix product. 
#> If x is a vector, then
#> x %*% A %*% x is a quadratic form.16
# 
# > if (expr_1) expr_2 else expr_3
# > for (name in expr_1) expr_2
#
# > xc <- split(x, ind)
#> yc <- split(y, ind)
#> for (i in 1:length(yc)) {
#  plot(xc[[i]], yc[[i]])
#  abline(lsfit(xc[[i]], yc[[i]]))
#}


