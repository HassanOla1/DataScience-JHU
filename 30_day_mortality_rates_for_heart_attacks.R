
# loading the data
myfile <- list.files("./Hospital_Compare", full.names = TRUE)
outcome <- read.csv("./rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv",
                    colClasses = "character")

## overview of the data
head(outcome)
summary(outcome)
ncol(outcome)
nrow(outcome)
names(outcome)

# histogram of the 30-day death rates from heart attack
histogram_data <- as.numeric(outcome[, 11])

hist(histogram_data, 
     main = "Hospital 30-day Mortality Rates from Heart Attacks",
     xlab = "Deaths", 
     col = "red")

