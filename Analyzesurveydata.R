
#Installs the package
install.packages("dplyr") 
library(dplyr) #Loads the package

# importing dataset

data <- read.csv("https://www.consumerfinance.gov/documents/5614/NFWBS_PUF_2016_data.csv")


#Gets the <$50k income subset
income50k <- data %>% filter(PPINCIMP<=4)
table(income50k$PPINCIMP)


#Selecting specific columns
sp_column <- income50k %>% select(PPGENDER,PPHHSIZE,PPINCIMP,FWBscore,finalwt)



#Creating a binary (a.k.a dummy) variable
table(data$PPEDUC)


#COLLEGE takes a value of 1 if PPEDUC >= 4; COLLEGE takes a value of 0 if PPEDUC < 4.
data$COLLEGE<- ifelse(data$PPEDUC>=4,1,0)



#Renaming the levels of a categorical variable
data$PPINCIMP <-  recode(data$PPINCIMP,"1"="Less than $20,000", 
                         "2"="$20,000 to $29,999",
                         "3"="$30,000 to $39,999",
                         "4"="$40,000 to $49,999",
                         "5"="$50,000 to $59,999",
                         "6"="$60,000 to $74,999",
                         "7"="$75,000 to $99,999",
                         "8"="$100,000 to $149,999",
                         "9"="$150,000 or more")
table(data$PPINCIMP)


# Creating a new categorical variable
table(data$PPINCIMP)
table(data$PPGENDER)





data$GENERATION.GENDER <- ifelse(data$PPGENDER==1 & data$generation==1, 'Male, Pre-Boomer',
                                 ifelse(data$PPGENDER==1 & data$generation==2, 'Male, Boomer',
                                        ifelse(data$PPGENDER==1 & data$generation==3, 'Male, Gen X',
                                               ifelse(data$PPGENDER==1 & data$generation==4, 'Male, Millennial',
                                                      ifelse(data$PPGENDER==2 & data$generation==1, 'Female, Pre-Boomer',
                                                             ifelse(data$PPGENDER==2 & data$generation==2, 'Female, Boomer',
                                                                    ifelse(data$PPGENDER==2 & data$generation==3, 'Female, Gen X',
                                                                           'Female, Millennial')))))))


table(data$GENERATION.GENDER)

#Creating a summary statistics table
table <- data %>% group_by(GENERATION.GENDER) %>%
  summarise(Count=n(), 
            Mean.FWBScore=round(mean(FWBscore),digits=1), 
            Median.FWBScore=round(median(FWBscore),digits=1),
            SD.FWBScore=round(sd(FWBscore),digits=1)
  )

#Creating a barplot

install.packages("ggplot2") #Installs the package

library(ggplot2)

library(dplyr) #Loads the package

ggplot(table, aes(x=GENERATION.GENDER, y=Mean.FWBScore)) + 
  geom_bar(stat = "identity")



ggplot(table, aes(x=GENERATION.GENDER, y=Mean.FWBScore)) + 
  geom_bar(stat = "identity")+ 
  coord_flip()+
  theme_light()+
  labs(y="Average Financial Well-Being Score", x=" ")
