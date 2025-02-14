
# Analyzing Survey Data in R


### Overall Purpose of the Code:
The code performs data analysis and visualization on a dataset related to financial well-being. It primarily focuses on filtering and transforming data based on income, education, gender, and generation. The goal is to analyze and visualize the financial well-being scores (`FWBscore`) across different demographic groups such as income levels, gender, and generation. The code ultimately generates summary statistics and visualizes the results in a bar plot.

### Technologies and Packages Used:

- **R Programming Language**: The code is written in R, which is widely used for statistical analysis, data manipulation, and visualization.
- **R Packages**:
  - **`dplyr`**: This package is used for data manipulation. It allows for easy filtering, selecting, summarizing, and transforming data.
  - **`ggplot2`**: This package is used for data visualization. It creates plots and charts, in this case, bar plots to represent the data.

### Methods Used:

1. **Data Import**:
   - The dataset is imported from an external URL using `read.csv()`.

2. **Data Filtering**:
   - The code uses `filter()` from the `dplyr` package to filter out records with income greater than $49,999.

3. **Data Selection**:
   - The `select()` function from `dplyr` is used to pick specific columns for further analysis, such as gender, household size, income, and financial well-being score.

4. **Creating Binary (Dummy) Variables**:
   - The `ifelse()` function is used to create a binary variable (`COLLEGE`), which takes a value of 1 if the education level is above a certain threshold and 0 otherwise.

5. **Renaming Categorical Variables**:
   - The `recode()` function from `dplyr` is used to rename the income categories into more understandable labels (e.g., "Less than $20,000" instead of "1").

6. **Creating New Categorical Variables**:
   - The `ifelse()` function is again used to combine `PPGENDER` (gender) and `generation` into a new variable, `GENERATION.GENDER`, that categorizes individuals by both their gender and generational group (e.g., "Male, Pre-Boomer").

7. **Summary Statistics**:
   - The `group_by()` and `summarise()` functions from `dplyr` are used to group the data by the new `GENERATION.GENDER` variable and calculate summary statistics such as count, mean, median, and standard deviation of the financial well-being score.

8. **Visualization**:
   - The `ggplot2` package is used to create bar plots. The `geom_bar()` function is used to create the bars, while `coord_flip()` is used to flip the axes, and `theme_light()` applies a light theme to the plot.

### Summary:
This R code involves:
- **Data Import**: From a URL.
- **Data Transformation**: Filtering, selecting columns, and creating new variables.
- **Data Analysis**: Calculating summary statistics.
- **Data Visualization**: Creating bar plots to visualize financial well-being scores.

The technologies and methods used are primarily based on **R**, with **`dplyr`** for data manipulation and **`ggplot2`** for visualization. The core techniques are filtering, summarizing, recoding, and visualizing data.







# R
Analyzing Survey Data in R
Here is the content written in Markdown format:

```markdown
# R Code Explanation

This document explains the R code in the file `Analyzesurveydata.R`.

## 1. Installing and loading the `dplyr` package

```r
install.packages("dplyr") 
library(dplyr)
```
- Installs the `dplyr` package, which is used for data manipulation, and loads it into the R environment.

## 2. Importing dataset

```r
data <- read.csv("https://www.consumerfinance.gov/documents/5614/NFWBS_PUF_2016_data.csv")
```
- Imports a CSV file from a URL into R and stores it as a dataframe called `data`.

## 3. Filtering data based on income

```r
income50k <- data %>% filter(PPINCIMP <= 4)
table(income50k$PPINCIMP)
```
- Filters the dataset to include only records where the `PPINCIMP` (income variable) is less than or equal to 4 (which corresponds to income up to $49,999). 
- Then creates a frequency table of `PPINCIMP` values for this filtered subset.

## 4. Selecting specific columns

```r
sp_column <- income50k %>% select(PPGENDER, PPHHSIZE, PPINCIMP, FWBscore, finalwt)
```
- Selects specific columns from the `income50k` subset for further analysis: `PPGENDER` (gender), `PPHHSIZE` (household size), `PPINCIMP` (income), `FWBscore` (financial well-being score), and `finalwt` (final weight).

## 5. Creating a binary (dummy) variable

```r
data$COLLEGE <- ifelse(data$PPEDUC >= 4, 1, 0)
```
- Creates a new variable `COLLEGE`, which takes a value of 1 if `PPEDUC` (education level) is 4 or higher (typically indicating college education) and 0 if less than 4.

## 6. Renaming the levels of a categorical variable

```r
data$PPINCIMP <- recode(data$PPINCIMP, 
                        "1" = "Less than $20,000", 
                        "2" = "$20,000 to $29,999", 
                        "3" = "$30,000 to $39,999", 
                        "4" = "$40,000 to $49,999", 
                        "5" = "$50,000 to $59,999", 
                        "6" = "$60,000 to $74,999", 
                        "7" = "$75,000 to $99,999", 
                        "8" = "$100,000 to $149,999", 
                        "9" = "$150,000 or more")
```
- Renames the numeric values of `PPINCIMP` to more readable categories representing income ranges.

## 7. Creating a new categorical variable based on gender and generation

```r
data$GENERATION.GENDER <- ifelse(data$PPGENDER == 1 & data$generation == 1, 'Male, Pre-Boomer',
                                 ifelse(data$PPGENDER == 1 & data$generation == 2, 'Male, Boomer',
                                        ifelse(data$PPGENDER == 1 & data$generation == 3, 'Male, Gen X',
                                               ifelse(data$PPGENDER == 1 & data$generation == 4, 'Male, Millennial',
                                                      ifelse(data$PPGENDER == 2 & data$generation == 1, 'Female, Pre-Boomer',
                                                             ifelse(data$PPGENDER == 2 & data$generation == 2, 'Female, Boomer',
                                                                    ifelse(data$PPGENDER == 2 & data$generation == 3, 'Female, Gen X',
                                                                           'Female, Millennial')))))))
```
- Creates a new variable `GENERATION.GENDER` that combines `PPGENDER` (gender) and `generation` into a new category (e.g., "Male, Pre-Boomer" or "Female, Millennial").

## 8. Summary statistics by generation and gender

```r
table <- data %>% group_by(GENERATION.GENDER) %>%
  summarise(Count = n(), 
            Mean.FWBScore = round(mean(FWBscore), digits = 1), 
            Median.FWBScore = round(median(FWBscore), digits = 1),
            SD.FWBScore = round(sd(FWBscore), digits = 1))
```
- Generates a summary table grouping by `GENERATION.GENDER` and calculates the count, mean, median, and standard deviation of the `FWBscore` (financial well-being score).

## 9. Creating a barplot

```r
install.packages("ggplot2") 
library(ggplot2)
ggplot(table, aes(x = GENERATION.GENDER, y = Mean.FWBScore)) + 
  geom_bar(stat = "identity")
```
- Installs and loads the `ggplot2` package and creates a bar plot showing the mean financial well-being score (`Mean.FWBScore`) by `GENERATION.GENDER`.

## 10. Customized barplot

```r
ggplot(table, aes(x = GENERATION.GENDER, y = Mean.FWBScore)) + 
  geom_bar(stat = "identity") + 
  coord_flip() +
  theme_light() +
  labs(y = "Average Financial Well-Being Score", x = " ")
```
- Creates a similar bar plot as above, but flips the axes, applies a light theme, and adds custom labels to the plot.

---

This R code performs data cleaning, transformation, and visualization steps to analyze financial well-being scores based on income, gender, and generation.
