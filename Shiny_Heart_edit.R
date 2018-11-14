# # ####Import relevant libraries.
library(readr)
# #
library(Hmisc) # Used for the describe() function.
# #
library(lubridate)
# #
library(dplyr)
# #
library(plotly)
# #
library(stringr)
# #
 library(rebus)
library(tidyverse)
# # ##Import data
# # ###https://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/heart-disease.names
heart1 <- read_csv("D:\\My Passport\\Courses\\UNH\\Fall 2018\\R and Tableau\\HeartData.csv")
# #
#
# # ### Convert zero values to NAs for cholesterol and hear rate
#
heart1$Cholesterol[heart1$Cholesterol==0] <- NA
heart1$Max_HeartRate[heart1$Max_HeartRate==0] <- NA
# #
# # ###Drop missing values:
heart1<- heart1[complete.cases(heart1), ]
# #
# # ###Drop Unnecessary column_to_rownames
heart1 = subset(heart1, select = -c(3) )
# ###Create a flat file
#
#
# # ####Build Shiny App
library(shiny)
library(reshape2)
library(wesanderson)

heart2 <- melt(heart1, id.vars = c("X1", "Age", "Gender", "location", "Heart_Disease_Binary"))


# Create a Shiny app object


ui <- fluidPage(
  titlePanel("UCI Heart Disease Data Set"),
  sidebarLayout(
    sidebarPanel(
      tabsetPanel(
        tabPanel("Select Features",
                 radioButtons("rb", "Select Gender", choices = 
                                unique(heart2$Gender), selected = unique(heart2$Gender)[1],inline = FALSE),
                 selectInput("si","Select Metric",choices = 
                               unique(heart2$variable), selected = unique(heart2$variable)[1]),
                 radioButtons("cb", "Select Location",choices= 
                                unique(heart2$location),selected=  unique(heart2$location)[1], inline=FALSE)
                 )
                 
                 
        )
      ),
      
    
    mainPanel(
      tabsetPanel(
        tabPanel("Read Me",
                 h2("Background Information"),
                 htmlOutput("read")
                 
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
  filtered_data <- reactive({filter(heart2, Gender == input$rb, variable == input$si, location==input$cb)})

  
  output$hist <- renderPlotly(
    {
      p <- ggplot(filtered_data(), aes(x =value, color = as.factor(Heart_Disease_Binary),fill = as.factor(Heart_Disease_Binary)))+geom_histogram(stat="count", binwidth = 5, alpha=.5,show.legend = FALSE)
      
      ggplotly(p)   
      
    }
  )
  output$table <- renderDataTable(
    {
      select(filtered_data(),c("X1", "Age", "Gender", "location","Heart_Disease_Binary","variable","value"))
    }
  )
  output$read <- renderUI(
    {
      HTML("<h2>This dataset contains data related to heart disease diagnosis.</h2>
      <p>The data was collected from the following locations: </p>
      <p>1. Cleveland Clinic Foundation (cleveland.data) </p>
      <p>2. Hungarian Institute of Cardiology, Budapest (hungarian.data)</p>
      <p>3. V.A. Medical Center, Long Beach, CA (long-beach-va.data)<h3></p>")
      }
    )
}

shinyApp(ui, server)



