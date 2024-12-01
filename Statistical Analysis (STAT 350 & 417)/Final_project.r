library(ggplot2)
videos <- read.table("videos", header = TRUE, sep = "\t")
videos_cleaned <- videos[complete.cases(videos),]
write.table(videos_cleaned,file="videos_cleaned",
row.names=FALSE, sep="\t")
videos_cleaned <- subset(videos_cleaned,
select = c("duration", "recommendations",
"day_views", "quality", "views", "region"))
# Bunching together all the various sub-regions into their main region
videos_cleaned$reg_main <- as.character(videos_cleaned$region)
videos_cleaned$reg_main[videos_cleaned$reg_main =="North Africa"] <-"Africa"
videos_cleaned$reg_main[videos_cleaned$reg_main =="Eastern Africa"] <-"Africa"
videos_cleaned$reg_main[videos_cleaned$reg_main =="Central Africa"] <-"Africa"
videos_cleaned$reg_main[videos_cleaned$reg_main =="Western Africa"] <-"Africa"
videos_cleaned$reg_main[videos_cleaned$reg_main =="South Africa"] <-"Africa"
videos_cleaned$reg_main[videos_cleaned$reg_main =="North America"] <-"America"
videos_cleaned$reg_main[videos_cleaned$reg_main =="Central America"] <-"America"
videos_cleaned$reg_main[videos_cleaned$reg_main =="South America"] <-"America"
videos_cleaned$reg_main[videos_cleaned$reg_main =="Caribbean"] <-"America"
videos_cleaned$reg_main[videos_cleaned$reg_main =="Eastern Asia"] <-"Asia"
videos_cleaned$reg_main[videos_cleaned$reg_main =="Southeast Asia"] <-"Asia"
videos_cleaned$reg_main[videos_cleaned$reg_main =="Central Asia"] <-"Asia"
videos_cleaned$reg_main[videos_cleaned$reg_main =="South Asia"] <-"Asia"
videos_cleaned$reg_main[videos_cleaned$reg_main =="Middle East"] <-"Asia"
videos_cleaned$reg_main[videos_cleaned$reg_main =="Eastern Europe"] <-"Europe"
videos_cleaned$reg_main[videos_cleaned$reg_main =="Central Europe"] <-"Europe"
videos_cleaned$reg_main[videos_cleaned$reg_main =="Western Europe"] <-"Europe"
videos_cleaned$reg_main[videos_cleaned$reg_main =="South Europe"] <-"Europe"
videos_cleaned$reg_main[videos_cleaned$reg_main =="Scandinavia"] <-"Europe"

#clean overall dataset
covid_cleaned <- covidF21[complete.cases(covidF21),]
#import new GDP Data
newGDPData <- updatedGDPDataBEA
#remove row 9, D.C. from GDP Data
newGDPData <- newGDPData[-c(9),]
#Remove non-states and territories as they do not have the same situation as the rest
of the US
covid_cleaned <- covid_cleaned[-c(48,37,42,12,9), ]
#replace faulty 2017 GDP data set with typo-free data from U.S. BEA
covid_cleaned$state.gdp.2017 <- newGDPData$X1
#setup data subset
covidGDPDeaths.sub <- subset(covid_cleaned, select =
c("state.gdp.2017","state.death.7.10", "state.pop.2010", "name"))
#in order to remove potentially spurious variable of population divide by population
to give
#deaths per capita and gdp per capita
covidGDPDeaths.sub$deathsPerCapita = covidGDPDeaths.sub$state.death.7.10 /
covidGDPDeaths.sub$state.pop.2010
covidGDPDeaths.sub$gdpPerCapita = covidGDPDeaths.sub$state.gdp.2017 /
covidGDPDeaths.sub$state.pop.2010

library(ggplot2)
videos_cleaned$duration_log <- log(videos_cleaned$duration) #this is used to
normalize the histogram
xbar <- mean(videos_cleaned$duration_log) #this code is used to make the
histogram
s <- sd(videos_cleaned$duration_log)
ggplot(videos_cleaned, aes(duration_log))+
geom_histogram(aes(y=..density..), bins=18, fill="grey",col="black")+
geom_density(col="red",lwd=1)+
stat_function(fun=dnorm,args=list(mean=xbar, sd=s),col="blue",lwd=1)+
ggtitle("Histogram of Duration Post Log Transformation")
ggplot(videos_cleaned, aes(x ="", y =duration_log))+ #this is to make the
boxplot
stat_boxplot(geom="errorbar")+
geom_boxplot()+
ggtitle("Boxplot of Duration Post Log Transformation")+
stat_summary(fun.y=mean, color="black", geom="point", size =3)
ggplot(videos_cleaned, aes(sample = duration_log)) + #this is to make the
QQPlot
stat_qq() +
geom_abline(slope = s, intercept = xbar) +
ggtitle("QQ Plot of Duration Post Log Transformation")
xbar
s
nrow(videos_cleaned)
s/sqrt(nrow(videos_cleaned)) #SE
qt(0.01, 1894, lower.tail=FALSE)
t.test(videos_cleaned$duration_log, conf.level = .99, mu = log(702),
alternative = 'two.sided') #this was used for the one-sample t-test
df <- length(videos_cleaned$duration_log)-1
qt(0.01/2, df, lower.tail = FALSE) #code to find the critical value
The code below is used to make the plots BEFORE the transformation:
xbar <- mean(videos$duration) #this code is used to make the actual histogram
s <- sd(videos$duration)
ggplot(videos, aes(duration))+
geom_histogram(aes(y=..density..), bins=18, fill="grey",col="black")+
geom_density(col="red",lwd=1)+
stat_function(fun=dnorm,args=list(mean=xbar, sd=s),col="blue",lwd=1)+
ggtitle("Histogram of Duration before transformation")
xbar <- mean(videos$duration) #this code is used to make the histogram
s <- sd(videos$duration)
ggplot(videos_cleaned, aes(duration))+
geom_histogram(aes(y=..density..), bins=18, fill="grey",col="black")+
geom_density(col="red",lwd=1)+
stat_function(fun=dnorm,args=list(mean=xbar, sd=s),col="blue",lwd=1)+
ggtitle("Histogram of Duration before transformation")
ggplot(videos_cleaned, aes(x ="", y =duration))+ #this is to make the boxplot
stat_boxplot(geom="errorbar")+
geom_boxplot()+
ggtitle("Boxplot of Duration before transformation")+stat_summary(fun.y=mean, color="black", geom="point", size =3)
ggplot(videos_cleaned, aes(sample = duration)) + #this is to make the QQPlot
stat_qq() +
geom_abline(slope = s, intercept = xbar) +
ggtitle("QQ Plot of Duration before transformation")

videos.sub <- subset(videos_cleaned, quality == "1080p",
select = c("recommendations", "day_views"))
recommendations <- videos.sub$recommendations
day_views <- videos.sub$day_views
ggplot(videos.sub, aes(recommendations)) +
geom_histogram(aes(y =..density..),
bins=sqrt(nrow(videos.sub))+2, fill="grey", col="black") +
geom_density(col="red", lwd=1) +
stat_function(fun=dnorm, args = list(mean = mean(videos.sub$recommendations),
sd = sd(videos.sub$recommendations)), col = "blue", lwd = 1) +
ggtitle("Recommendations Histogram")
ggplot(videos.sub, aes(day_views)) +
geom_histogram(aes(y =..density..),
bins=sqrt(nrow(videos.sub))+2, fill="grey", col="black") +
geom_density(col="red", lwd=1) +
stat_function(fun=dnorm, args = list(mean = mean(videos.sub$day_views),
sd = sd(videos.sub$day_views)), col =
"blue", lwd = 1) +
ggtitle("Day_views Histogram")
#
# a) Scatterplot of the data
#
ggplot(videos.sub, aes(x=recommendations, y=day_views))+
geom_point() +
geom_smooth(method = lm, se = FALSE) +
ggtitle("Relationship between recommendations and day_views") +
xlab("Recommendations") +
ylab("day_views")
#
# b) Residual Plots
#
videos.sub.lm <- lm(day_views ~ recommendations, data = videos.sub)
summary(videos.sub.lm)
# Residuals Histogram
videos.sub$resids = videos.sub.lm$residuals
ggplot(videos.sub, aes(resids)) +
geom_histogram(aes(y =..density..),
bins=sqrt(nrow(videos.sub)) + 2,
fill="darkolivegreen1", col="darkolivegreen4") +
geom_density(col="red", lwd=1) +
stat_function(fun=dnorm, args = list(mean = mean(videos.sub$resids),
sd = sd(videos.sub$resids)), col = "blue", lwd = 1) +
ggtitle("Residuals Histogram")
# Residuals QQ Plot
ggplot(data = videos.sub, aes(sample= videos.sub$resids)) +
stat_qq() +
geom_abline(data= videos.sub, slope = sd(videos.sub$resids), intercept =
mean(videos.sub$resids)) +
ggtitle("QQ-Plot of Residuals")
# Residuals Plot
ggplot(data = videos.sub, aes(x=recommendations, y=resids)) +
geom_point() +
geom_smooth(method = lm, se = FALSE) +
ggtitle("Residual Plot") +
xlab("Recommendations") +
ylab("Residuals")
# Correlation
cor(videos.sub$recommendations, videos.sub$day_views)
#
# c) Generate the 2-sided Confidence Interval (CI) for the parameters
#
confint(videos.sub.lm, level = 0.99)
#
# d) Population mean confidence at several points based off recommendation
count.
#
newdata <- data.frame(recommendations = 1250)
predict(videos.sub.lm, newdata, interval = "confidence", level = 0.99)
newdata <- data.frame(recommendations = 1750)
predict(videos.sub.lm, newdata, interval = "confidence", level = 0.99)
newdata <- data.frame(recommendations = 2250)
predict(videos.sub.lm, newdata, interval = "confidence", level = 0.99)

library(ggplot2)
videos <- videos_cleaned
xbar <- tapply(videos$duration, videos$reg_main, mean)
s <- tapply(videos$duration, videos$reg_main, sd)
videos.sub <- subset(videos, reg_main != "Oceania",
select = c("reg_main", "duration"))
videos.sub$reg_main <- factor(videos.sub$reg_main)
videos.sub$normal.density <- apply(videos.sub, 1, function(x){
dnorm(as.numeric(x["duration"]),
xbar[x["reg_main"]], s[x["reg_main"]])})
binlen <- as.numeric(max(tapply(videos.sub$duration,
videos.sub$reg_main,length)))
ggplot(videos.sub, aes(x = duration)) +
geom_histogram(aes(y = ..density..), bins = sqrt(binlen) + 2,
fill = "grey", col = "black") +
facet_grid(reg_main ~ .) +
geom_density(col = "red", lwd = 1) +
geom_line(aes(y = normal.density), col = "blue", lwd = 1) +
ggtitle("Histograms of duration by main region")
Logx <- log(videos$duration)
ggplot(videos, aes(Logx)) +
geom_histogram(aes(y = ..density..),
bins = sqrt(nrow(videos))+2,
fill = "grey", col = "black") +
geom_density(col = "red", lwd = 1) +
stat_function(fun = dnorm, args = list(mean = mean(Logx), sd = sd(Logx)),
col="blue", lwd = 1) +
ggtitle("The log-transformed data.") +
xlab("Logx") +
ylab("Proportion")
videos.sub$intercept <- apply(videos.sub, 1, function(x){xbar[x["reg_main"]]})
videos.sub$slope <- apply(videos.sub, 1, function(x){s[x["reg_main"]]})
ggplot(videos.sub, aes(sample = duration)) +
stat_qq() +
facet_grid(reg_main ~ .) +
geom_abline(data = videos.sub, aes(intercept = intercept, slope = slope)) +
ggtitle("QQ Plots of duration by main region")
fit <- aov(duration ~ reg_main, data = videos.sub)
summary(fit)

library(ggplot2)
#clean overall dataset
covid_cleaned <- covidF21[complete.cases(covidF21),]
#import new GDP Data
newGDPData <- updatedGDPDataBEA
#remove row 9, D.C. from GDP Data
newGDPData <- newGDPData[-c(9),]
#Remove non-states and territories as they do not have the same situation as the rest
of the US
covid_cleaned <- covid_cleaned[-c(48,37,42,12,9), ]
#replace faulty 2017 GDP data set with typo-free data from U.S. BEA
covid_cleaned$state.gdp.2017 <- newGDPData$X1
#remove NY, NJ, MA, CT, outliers
covid_cleaned <- covid_cleaned[-c(32,30), ]
#MA CT
covid_cleaned <- covid_cleaned[-c(21,7), ]
#setup data subset
covidGDPDeaths.sub <- subset(covid_cleaned, select =
c("state.gdp.2017","state.death.7.10", "state.pop.2010", "name"))
#in order to remove potentially spurious variable of population divide by population
to give
#deaths per capita and gdp per capita
covidGDPDeaths.sub$deathsPerCapita = covidGDPDeaths.sub$state.death.7.10 /
covidGDPDeaths.sub$state.pop.2010
covidGDPDeaths.sub$gdpPerCapita = covidGDPDeaths.sub$state.gdp.2017 /
covidGDPDeaths.sub$state.pop.2010
#data looks complete so no need to factor
#Linear regression
ggplot(covidGDPDeaths.sub, aes(x=gdpPerCapita, y=deathsPerCapita))+
geom_point() +
geom_smooth(method = lm, se = FALSE) +
ggtitle("Relationship between GDP per capita and Deaths per Capita") +
xlab("GDP per Capita") +
ylab("Deaths per Capita")
# Calculate linear regression and get results
covidGDPDeaths.sub.lm <- lm(deathsPerCapita ~ gdpPerCapita, data = covidGDPDeaths.sub)
#Residual Plots
covidGDPDeaths.sub$resids = covidGDPDeaths.sub.lm$residuals
#test residuals
#Residuals plot
ggplot(data = covidGDPDeaths.sub, aes(x=gdpPerCapita, y=resids))+
geom_point() +
geom_smooth(method = lm, se = FALSE) +
ggtitle("Residual Plot") +
xlab("GDP per Capita") +
ylab("Residuals")
residuals <- covidGDPDeaths.sub$resids
# Histogram of Residuals
ggplot(data = covidGDPDeaths.sub, aes(residuals)) +
geom_histogram(aes(y =..density..),
bins=sqrt(nrow(covidGDPDeaths.sub))+2, fill="grey", col="black") +
geom_density(col="red", lwd=1) +
stat_function(fun=dnorm, args = list(mean = mean(residuals), sd = sd(residuals)),
col = "blue", lwd = 1) +
ggtitle("Residuals Histogram")
#QQ Plot
ggplot(data = covidGDPDeaths.sub, aes(sample= residuals)) +
stat_qq() +
geom_abline(data= covidGDPDeaths.sub, slope = sd(residuals), intercept =
mean(residuals)) +
ggtitle("QQ-Plot of Residuals")
#Shapiro Test
shapiro.test(covidGDPDeaths.sub$resids)
#Normality Violeted, fix by SQRT Deaths and recalculate regression
covidGDPDeaths.sub$deathsPerCapita_sqrt <- sqrt(covidGDPDeaths.sub$deathsPerCapita)
#Linear regression
ggplot(covidGDPDeaths.sub, aes(x=gdpPerCapita, y=deathsPerCapita_sqrt))+
geom_point() +
geom_smooth(method = lm, se = FALSE) +
ggtitle("Relationship between GDP per capita and Deaths per Capita") +
xlab("GDP per Capita") +
ylab("Deaths per Capita")
# Calculate linear regression and get results
covidGDPDeaths.sub.lm <- lm(deathsPerCapita_sqrt ~ gdpPerCapita, data =
covidGDPDeaths.sub)
#Residual Plots
covidGDPDeaths.sub$resids = covidGDPDeaths.sub.lm$residuals

#test residuals
#Residuals plot
ggplot(data = covidGDPDeaths.sub, aes(x=gdpPerCapita, y=resids))+
geom_point() +
geom_smooth(method = lm, se = FALSE) +
ggtitle("Residual Plot") +
xlab("GDP per Capita") +
ylab("Residuals")
residuals <- covidGDPDeaths.sub$resids
# Histogram of Residuals
ggplot(data = covidGDPDeaths.sub, aes(residuals)) +
geom_histogram(aes(y =..density..),
bins=sqrt(nrow(covidGDPDeaths.sub))+2, fill="grey", col="black") +
geom_density(col="red", lwd=1) +
stat_function(fun=dnorm, args = list(mean = mean(residuals), sd = sd(residuals)),
col = "blue", lwd = 1) +
ggtitle("Residuals Histogram")
#QQ Plot
ggplot(data = covidGDPDeaths.sub, aes(sample= residuals)) +
stat_qq() +
geom_abline(data= covidGDPDeaths.sub, slope = sd(residuals), intercept =
mean(residuals)) +
ggtitle("QQ-Plot of Residuals")
#Shapiro Test
shapiro.test(covidGDPDeaths.sub$resids)
#normality works now
# Correlation
cor(covidGDPDeaths.sub$deathsPerCapita_sqrt, covidGDPDeaths.sub$gdpPerCapita)
#results of LR
summary(covidGDPDeaths.sub.lm)
# Generate the 2-sided Confidence Interval (CI) for the parameters
confint(covidGDPDeaths.sub.lm, level = 0.99)
#Population mean confidence at several points based off GDP Per Capita.
pointEstimate <- data.frame(gdpPerCapita = 0.045)
predict(covidGDPDeaths.sub.lm, pointEstimate, interval = "confidence", level = 0.99)
pointEstimate <- data.frame(gdpPerCapita = 0.055)
predict(covidGDPDeaths.sub.lm, pointEstimate, interval = "confidence", level = 0.99)
pointEstimate <- data.frame(gdpPerCapita = 0.065)
predict(covidGDPDeaths.sub.lm, pointEstimate, interval = "confidence", level = 0.99)
