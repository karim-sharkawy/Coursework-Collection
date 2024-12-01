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

# Log transformation of duration
videos_cleaned$duration_log <- log(videos_cleaned$duration)  # Normalize the histogram

# Calculate mean and standard deviation for the transformed data
xbar <- mean(videos_cleaned$duration_log)  # Mean of log-transformed duration
s <- sd(videos_cleaned$duration_log)  # Standard deviation of log-transformed duration

# Histogram with density and normal distribution curve
ggplot(videos_cleaned, aes(duration_log)) +
  geom_histogram(aes(y = ..density..), bins = 18, fill = "grey", col = "black") +
  geom_density(col = "red", lwd = 1) +
  stat_function(fun = dnorm, args = list(mean = xbar, sd = s), col = "blue", lwd = 1) +
  ggtitle("Histogram of Duration Post Log Transformation")

# Boxplot of log-transformed duration
ggplot(videos_cleaned, aes(x = "", y = duration_log)) + 
  stat_boxplot(geom = "errorbar") +
  geom_boxplot() +
  ggtitle("Boxplot of Duration Post Log Transformation") +
  stat_summary(fun.y = mean, color = "black", geom = "point", size = 3)

# QQ plot of log-transformed duration
ggplot(videos_cleaned, aes(sample = duration_log)) + 
  stat_qq() +
  geom_abline(slope = s, intercept = xbar) +
  ggtitle("QQ Plot of Duration Post Log Transformation")

# Output mean and standard deviation
xbar  # Display mean
s  # Display standard deviation

# Number of rows in the dataset
nrow(videos_cleaned)  # Display number of rows

# Standard error calculation
s / sqrt(nrow(videos_cleaned))  # Standard error

# Critical value from t-distribution for 0.01 significance level and 1894 degrees of freedom
qt(0.01, 1894, lower.tail = FALSE)

# One-sample t-test for log-transformed duration with a mean of log(702)
t.test(videos_cleaned$duration_log, conf.level = .99, mu = log(702), alternative = 'two.sided')

# Degrees of freedom for the t-test
df <- length(videos_cleaned$duration_log) - 1  # Degrees of freedom

# Critical value for two-tailed test at alpha = 0.01
qt(0.01 / 2, df, lower.tail = FALSE)  # Critical value

# Plots before transformation (for comparison)

# Calculate mean and standard deviation for the original data
xbar <- mean(videos$duration)  # Mean of original duration
s <- sd(videos$duration)  # Standard deviation of original duration

# Histogram with density and normal distribution curve before transformation
ggplot(videos, aes(duration)) +
  geom_histogram(aes(y = ..density..), bins = 18, fill = "grey", col = "black") +
  geom_density(col = "red", lwd = 1) +
  stat_function(fun = dnorm, args = list(mean = xbar, sd = s), col = "blue", lwd = 1) +
  ggtitle("Histogram of Duration Before Transformation")

# Histogram of original duration for the cleaned data
ggplot(videos_cleaned, aes(duration)) +
  geom_histogram(aes(y = ..density..), bins = 18, fill = "grey", col = "black") +
  geom_density(col = "red", lwd = 1) +
  stat_function(fun = dnorm, args = list(mean = xbar, sd = s), col = "blue", lwd = 1) +
  ggtitle("Histogram of Duration Before Transformation")

# Boxplot of original duration
ggplot(videos_cleaned, aes(x = "", y = duration)) + 
  stat_boxplot(geom = "errorbar") +
  geom_boxplot() +
  ggtitle("Boxplot of Duration Before Transformation") +
  stat_summary(fun.y = mean, color = "black", geom = "point", size = 3)

# QQ plot of original duration
ggplot(videos_cleaned, aes(sample = duration)) + 
  stat_qq() +
  geom_abline(slope = s, intercept = xbar) +
  ggtitle("QQ Plot of Duration Before Transformation")


videos.sub <- subset(videos_cleaned, quality == "1080p", select = c("recommendations", "day_views"))  # Subset data for 1080p quality
recommendations <- videos.sub$recommendations  # Extract recommendations
day_views <- videos.sub$day_views  # Extract day_views

# Recommendations histogram with density and normal distribution curve
ggplot(videos.sub, aes(recommendations)) +
  geom_histogram(aes(y = ..density..), bins = sqrt(nrow(videos.sub)) + 2, fill = "grey", col = "black") +
  geom_density(col = "red", lwd = 1) +
  stat_function(fun = dnorm, args = list(mean = mean(videos.sub$recommendations), sd = sd(videos.sub$recommendations)), col = "blue", lwd = 1) +
  ggtitle("Recommendations Histogram")

# Day_views histogram with density and normal distribution curve
ggplot(videos.sub, aes(day_views)) +
  geom_histogram(aes(y = ..density..), bins = sqrt(nrow(videos.sub)) + 2, fill = "grey", col = "black") +
  geom_density(col = "red", lwd = 1) +
  stat_function(fun = dnorm, args = list(mean = mean(videos.sub$day_views), sd = sd(videos.sub$day_views)), col = "blue", lwd = 1) +
  ggtitle("Day_views Histogram")

# a) Scatterplot of recommendations vs day_views
ggplot(videos.sub, aes(x = recommendations, y = day_views)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE) +
  ggtitle("Relationship between recommendations and day_views") +
  xlab("Recommendations") +
  ylab("day_views")

# b) Residual Plots
videos.sub.lm <- lm(day_views ~ recommendations, data = videos.sub)  # Fit linear model
summary(videos.sub.lm)  # Summary of the linear model

# Residuals histogram
videos.sub$resids = videos.sub.lm$residuals  # Store residuals
ggplot(videos.sub, aes(resids)) +
  geom_histogram(aes(y = ..density..), bins = sqrt(nrow(videos.sub)) + 2, fill = "darkolivegreen1", col = "darkolivegreen4") +
  geom_density(col = "red", lwd = 1) +
  stat_function(fun = dnorm, args = list(mean = mean(videos.sub$resids), sd = sd(videos.sub$resids)), col = "blue", lwd = 1) +
  ggtitle("Residuals Histogram")

# Residuals QQ plot
ggplot(data = videos.sub, aes(sample = videos.sub$resids)) +
  stat_qq() +
  geom_abline(data = videos.sub, slope = sd(videos.sub$resids), intercept = mean(videos.sub$resids)) +
  ggtitle("QQ-Plot of Residuals")

# Residuals plot
ggplot(data = videos.sub, aes(x = recommendations, y = resids)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE) +
  ggtitle("Residual Plot") +
  xlab("Recommendations") +
  ylab("Residuals")

# Correlation between recommendations and day_views
cor(videos.sub$recommendations, videos.sub$day_views)  # Calculate correlation

# c) Generate the 2-sided Confidence Interval (CI) for the parameters
confint(videos.sub.lm, level = 0.99)  # Confidence interval for model parameters

# d) Population mean confidence at several points based on recommendation count
newdata <- data.frame(recommendations = 1250)  # Create new data point for prediction
predict(videos.sub.lm, newdata, interval = "confidence", level = 0.99)  # Prediction with CI
newdata <- data.frame(recommendations = 1750)  # Create another data point for prediction
predict(videos.sub.lm, newdata, interval = "confidence", level = 0.99)  # Prediction with CI
newdata <- data.frame(recommendations = 2250)  # Create another data point for prediction
predict(videos.sub.lm, newdata, interval = "confidence", level = 0.99)  # Prediction with CI

library(ggplot2)
videos <- videos_cleaned  # Assign cleaned videos to a new variable

# Calculate mean and standard deviation by region
xbar <- tapply(videos$duration, videos$reg_main, mean)  # Mean by region
s <- tapply(videos$duration, videos$reg_main, sd)  # Standard deviation by region

# Subset data excluding Oceania and select specific columns
videos.sub <- subset(videos, reg_main != "Oceania", select = c("reg_main", "duration"))  # Filter data
videos.sub$reg_main <- factor(videos.sub$reg_main)  # Convert region to factor
videos.sub$normal.density <- apply(videos.sub, 1, function(x){  # Calculate normal density for each row
  dnorm(as.numeric(x["duration"]), xbar[x["reg_main"]], s[x["reg_main"]])
})

# Calculate the maximum bin length based on the number of entries per region
binlen <- as.numeric(max(tapply(videos.sub$duration, videos.sub$reg_main, length)))  # Max bin length

# Plot histograms with normal distribution for each region
ggplot(videos.sub, aes(x = duration)) +
  geom_histogram(aes(y = ..density..), bins = sqrt(binlen) + 2, fill = "grey", col = "black") +  # Histogram
  facet_grid(reg_main ~ .) +  # Facet by region
  geom_density(col = "red", lwd = 1) +  # Density curve
  geom_line(aes(y = normal.density), col = "blue", lwd = 1) +  # Normal density curve
  ggtitle("Histograms of duration by main region")

# Log-transform the duration data
Logx <- log(videos$duration)  # Log-transformed duration

# Plot histogram and density of log-transformed data
ggplot(videos, aes(Logx)) +
  geom_histogram(aes(y = ..density..), bins = sqrt(nrow(videos)) + 2, fill = "grey", col = "black") +  # Histogram
  geom_density(col = "red", lwd = 1) +  # Density curve
  stat_function(fun = dnorm, args = list(mean = mean(Logx), sd = sd(Logx)), col = "blue", lwd = 1) +  # Normal curve
  ggtitle("The log-transformed data.") +  # Title
  xlab("Logx") +  # X-axis label
  ylab("Proportion")  # Y-axis label

# Add intercept and slope for each region
videos.sub$intercept <- apply(videos.sub, 1, function(x){xbar[x["reg_main"]]})  # Intercept for each region
videos.sub$slope <- apply(videos.sub, 1, function(x){s[x["reg_main"]]})  # Slope for each region

# QQ plots by region
ggplot(videos.sub, aes(sample = duration)) +
  stat_qq() +  # QQ plot
  facet_grid(reg_main ~ .) +  # Facet by region
  geom_abline(data = videos.sub, aes(intercept = intercept, slope = slope)) +  # Add regression line
  ggtitle("QQ Plots of duration by main region")

# One-way ANOVA for duration by region
fit <- aov(duration ~ reg_main, data = videos.sub)  # Fit ANOVA model
summary(fit)  # Display ANOVA summary

library(ggplot2)

# Clean overall dataset
covid_cleaned <- covidF21[complete.cases(covidF21),]  # Remove rows with missing values

# Import new GDP Data
newGDPData <- updatedGDPDataBEA  # Load updated GDP data

# Remove row 9 (D.C.) from GDP Data
newGDPData <- newGDPData[-c(9),]  # Remove D.C. from GDP data

# Remove non-states and territories as they do not have the same situation as the rest of the US
covid_cleaned <- covid_cleaned[-c(48,37,42,12,9), ]  # Remove non-state/territory rows

# Replace faulty 2017 GDP data with typo-free data from U.S. BEA
covid_cleaned$state.gdp.2017 <- newGDPData$X1  # Replace GDP data for 2017

# Remove NY, NJ, MA, CT, outliers
covid_cleaned <- covid_cleaned[-c(32,30), ]  # Remove NY, NJ
covid_cleaned <- covid_cleaned[-c(21,7), ]  # Remove MA, CT

# Setup data subset
covidGDPDeaths.sub <- subset(covid_cleaned, select = c("state.gdp.2017","state.death.7.10", "state.pop.2010", "name"))  # Select relevant columns

# Remove potentially spurious variable by dividing population to give deaths per capita and GDP per capita
covidGDPDeaths.sub$deathsPerCapita = covidGDPDeaths.sub$state.death.7.10 / covidGDPDeaths.sub$state.pop.2010  # Calculate deaths per capita
covidGDPDeaths.sub$gdpPerCapita = covidGDPDeaths.sub$state.gdp.2017 / covidGDPDeaths.sub$state.pop.2010  # Calculate GDP per capita

# Data looks complete so no need to factor
# Linear regression plot
ggplot(covidGDPDeaths.sub, aes(x = gdpPerCapita, y = deathsPerCapita)) +  # Scatter plot for GDP vs deaths
  geom_point() +  # Points
  geom_smooth(method = lm, se = FALSE) +  # Linear fit line
  ggtitle("Relationship between GDP per capita and Deaths per Capita") +  # Title
  xlab("GDP per Capita") +  # X-axis label
  ylab("Deaths per Capita")  # Y-axis label

# Calculate linear regression and get results
covidGDPDeaths.sub.lm <- lm(deathsPerCapita ~ gdpPerCapita, data = covidGDPDeaths.sub)  # Fit linear model

# Residual Plots
covidGDPDeaths.sub$resids = covidGDPDeaths.sub.lm$residuals  # Store residuals

# Test residuals
# Residuals plot
ggplot(data = covidGDPDeaths.sub, aes(x = gdpPerCapita, y = resids)) +  # Residuals vs GDP plot
  geom_point() +  # Points
  geom_smooth(method = lm, se = FALSE) +  # Fit line
  ggtitle("Residual Plot") +  # Title
  xlab("GDP per Capita") +  # X-axis label
  ylab("Residuals")  # Y-axis label

residuals <- covidGDPDeaths.sub$resids  # Store residuals for histogram

# Histogram of Residuals
ggplot(data = covidGDPDeaths.sub, aes(residuals)) +  # Histogram of residuals
  geom_histogram(aes(y = ..density..), bins = sqrt(nrow(covidGDPDeaths.sub)) + 2, fill = "grey", col = "black") +  # Histogram with density
  geom_density(col = "red", lwd = 1) +  # Overlay density curve
  stat_function(fun = dnorm, args = list(mean = mean(residuals), sd = sd(residuals)), col = "blue", lwd = 1) +  # Normal distribution curve
  ggtitle("Residuals Histogram")  # Title

# QQ Plot
ggplot(data = covidGDPDeaths.sub, aes(sample = residuals)) +  # QQ plot
  stat_qq() +  # QQ plot
  geom_abline(data = covidGDPDeaths.sub, slope = sd(residuals), intercept = mean(residuals)) +  # Add normal line
  ggtitle("QQ-Plot of Residuals")  # Title

# Shapiro Test
shapiro.test(covidGDPDeaths.sub$resids)  # Test normality of residuals

# Normality violated, fix by sqrt of deaths and recalculate regression
covidGDPDeaths.sub$deathsPerCapita_sqrt <- sqrt(covidGDPDeaths.sub$deathsPerCapita)  # Sqrt transformation on deaths

# Linear regression with transformed data
ggplot(covidGDPDeaths.sub, aes(x = gdpPerCapita, y = deathsPerCapita_sqrt)) +  # Scatter plot for transformed data
  geom_point() +  # Points
  geom_smooth(method = lm, se = FALSE) +  # Linear fit line
  ggtitle("Relationship between GDP per capita and Deaths per Capita") +  # Title
  xlab("GDP per Capita") +  # X-axis label
  ylab("Deaths per Capita")  # Y-axis label

# Calculate linear regression and get results with transformed data
covidGDPDeaths.sub.lm <- lm(deathsPerCapita_sqrt ~ gdpPerCapita, data = covidGDPDeaths.sub)  # Fit linear model

# Residual Plots for transformed data
covidGDPDeaths.sub$resids = covidGDPDeaths.sub.lm$residuals  # Store residuals for transformed model

# Test residuals
# Residuals plot
ggplot(data = covidGDPDeaths.sub, aes(x = gdpPerCapita, y = resids)) +  # Plot residuals vs GDP
  geom_point() +  # Points
  geom_smooth(method = lm, se = FALSE) +  # Fit line
  ggtitle("Residual Plot") +  # Title
  xlab("GDP per Capita") +  # X-axis label
  ylab("Residuals")  # Y-axis label
residuals <- covidGDPDeaths.sub$resids  # Store residuals

# Histogram of Residuals
ggplot(data = covidGDPDeaths.sub, aes(residuals)) +  # Histogram of residuals
  geom_histogram(aes(y = ..density..), bins = sqrt(nrow(covidGDPDeaths.sub)) + 2, fill = "grey", col = "black") +  # Histogram with density
  geom_density(col = "red", lwd = 1) +  # Overlay density curve
  stat_function(fun = dnorm, args = list(mean = mean(residuals), sd = sd(residuals)), col = "blue", lwd = 1) +  # Normal distribution curve
  ggtitle("Residuals Histogram")  # Title

# QQ Plot
ggplot(data = covidGDPDeaths.sub, aes(sample = residuals)) +  # QQ plot of residuals
  stat_qq() +  # QQ plot points
  geom_abline(data = covidGDPDeaths.sub, slope = sd(residuals), intercept = mean(residuals)) +  # Normal line
  ggtitle("QQ-Plot of Residuals")  # Title

# Shapiro Test
shapiro.test(covidGDPDeaths.sub$resids)  # Test normality of residuals

# Normality works now

# Correlation
cor(covidGDPDeaths.sub$deathsPerCapita_sqrt, covidGDPDeaths.sub$gdpPerCapita)  # Correlation between transformed deaths and GDP

# Results of Linear Regression
summary(covidGDPDeaths.sub.lm)  # Linear model summary

# Generate the 2-sided Confidence Interval (CI) for the parameters
confint(covidGDPDeaths.sub.lm, level = 0.99)  # 99% confidence interval for parameters

# Population mean confidence at several points based on GDP Per Capita
pointEstimate <- data.frame(gdpPerCapita = 0.045)  # GDP point estimate
predict(covidGDPDeaths.sub.lm, pointEstimate, interval = "confidence", level = 0.99)  # Confidence interval for 0.045 GDP

pointEstimate <- data.frame(gdpPerCapita = 0.055)  # Another GDP point estimate
predict(covidGDPDeaths.sub.lm, pointEstimate, interval = "confidence", level = 0.99)  # Confidence interval for 0.055 GDP

pointEstimate <- data.frame(gdpPerCapita = 0.065)  # Another GDP point estimate
predict(covidGDPDeaths.sub.lm, pointEstimate, interval = "confidence", level = 0.99)  # Confidence interval for 0.065 GDP
