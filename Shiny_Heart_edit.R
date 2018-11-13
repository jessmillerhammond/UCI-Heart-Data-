####Import relevant libraries. 

library(readr) 

library(Hmisc) # Used for the describe() function. 

library(lubridate) 

library(dplyr) 

library(plotly) 

library(stringr) 

library(rebus) 
library(tidyverse)
##Import data 
###https://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/heart-disease.names
heart1 <- read_csv("D:\\My Passport\\Courses\\UNH\\Fall 2018\\R and Tableau\\HeartData.csv")


# ### Convert zero values to NAs for cholesterol and hear rate

heart1$Cholesterol[heart1$Cholesterol==0] <- NA
heart1$Max_HeartRate[heart1$Max_HeartRate==0] <- NA

###Drop missing values:
heart1<- heart1[complete.cases(heart1), ]
###Create a flat file

# heart_file <- gather(heart3, "Demographic", "Value", 1:5)
# 
####Build Shiny App
library(shiny)
library(reshape2)
#heart1 <- read_csv("HeartData.csv")
heart2 <- melt(heart1, id.vars = c("X1", "Age", "Gender", "location", "Sex", "Heart_Disease_Binary"))


# Create a Shiny app object


ui <- fluidPage(
  titlePanel("UCI Heart Disease Data Set"),
  sidebarLayout(
    sidebarPanel(
      tabsetPanel(
        tabPanel("Feature Selection",
                 radioButtons("rb", "Select Gender", choices = 
                                unique(heart1$Gender), selected = unique(heart1$Gender)[1],inline = FALSE),
                 selectInput("si","Select Feature",choices = unique(heart2$variable), selected = unique(heart2$variable)[1]
                 )
        )
      )
      
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Read Me",
                 h2("About"),
                 textOutput("read") 
        ),
        tabPanel("Data Table",
                 h2("Data Table"),
                 dataTableOutput(outputId = "table")
        ),
        tabPanel("Histogram",
                 h2("Density Plot of Features"),
                 h3("Colored by Binary Classification of Heart Disease"),
                 plotlyOutput("hist")
        )
        
        
      )
      
    )
  )
  
  
)

server <- function(input, output, session) {
  filtered_data <- reactive({filter(heart2, Gender == input$rb, variable == input$si)})

  
  output$hist <- renderPlotly(
    {
      p <- ggplot(filtered_data(), aes(x =value, color = as.factor(Heart_Disease_Binary)))+geom_density(alpha=0.5)
      ggplotly(p)   
      
    }
  )
  output$table <- renderDataTable(
    {
      select(filtered_data(),c("X1", "Age", "Gender", "location", "Sex","Heart_Disease_Binary","variable","value"))
    }
  )
  output$read <- renderText(
    {
      "Title: Heart Disease Databases

      2. Source Information:
      (a) Creators: 
      -- 1. Hungarian Institute of Cardiology. Budapest: Andras Janosi, M.D.
      -- 2. University Hospital, Zurich, Switzerland: William Steinbrunn, M.D.
      -- 3. University Hospital, Basel, Switzerland: Matthias Pfisterer, M.D.
      -- 4. V.A. Medical Center, Long Beach and Cleveland Clinic Foundation:
      Robert Detrano, M.D., Ph.D.
      (b) Donor: David W. Aha (aha@ics.uci.edu) (714) 856-8779   
      (c) Date: July, 1988
      "
      }
    )
}

shinyApp(ui, server)


