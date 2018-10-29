
req.packages=c("shiny","jpeg","tesseract","wordcloud","tm","RColorBrewer","quanteda","DT")
if(any(! req.packages  %in% installed.packages()))
  stop(
    paste0("Not all dependent packages are installed on your computer.\n Please install: ",
           paste(req.packages[!req.packages %in% installed.packages()],collapse=","),
           ". See '?install.packages' for more information on how to install R packages.")
  )


library(shiny)
library(shinythemes)
library(jpeg)
library(tesseract)
library(wordcloud)
library(tm)
library(RColorBrewer)
library(quanteda)
library(DT)
library(shinyWidgets)

shinyUI(fluidPage(theme="file.css",

                  div(class="myTitle",
                      titlePanel("OCR Made Simpler")),
     setBackgroundColor(
  color = c("#5600a1","#2387d7"),
  gradient = "linear",
  direction = "top"
),  

  titlePanel(""),

div(class="myContent",   
  sidebarLayout(
    sidebarPanel(width = 3,
      
      fileInput('file1', 'Choose an image (max 5MB)'),
      tags$hr(),
      sliderInput("maxwords", "Maximum number of words in cloud:", 1, 200, 100),
      sliderInput("minfreq","Minimum word frequency in cloud:",1,200,20),
      checkboxInput("stopwords", "Remove (English) stopwords", value = FALSE)
      
    ),
    
    
    mainPanel(
      tabsetPanel(
        tabPanel(
          "Introduction",
          htmlOutput("intro")
        ),
        tags$tab(
          tags$style(type = "text/css", "a{color: #ffffff;}")
        ),
        tabPanel(
          "Image & extracted text",
          fluidRow(
            column(
              width=7,
              imageOutput("plaatje")
            ),
            column(
              width=5,
              verbatimTextOutput("OCRtext")
            )
          )
        ),
        tabPanel(
          "Wordcloud",
          plotOutput("cloud", height = "600px")
        )
      )
    )
  ))
))
