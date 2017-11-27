library(shiny)
library(ggvis)


source("code/functions.R")
scores <- read.csv("data/cleandata/cleanscores.csv")

gradedf <- scores %>% dplyr::group_by(Grades)  %>%
           dplyr::summarise(Freq = n(), Prop = round(n()/nrow(scores), 2))

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Grade Visualizer"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(

      conditionalPanel(
          condition = "input.tabs == 'Barchart'",
          tableOutput("table")
        ), # end conditional panel
    
        conditionalPanel(
             condition = "input.tabs == 'Histogram'",   
      selectInput("xvar0", 
                  label = h3("Select variable"), 
                  choices = 
                  list("HW1","HW2","HW3","HW4","HW5","HW6","HW7","HW8",
              "HW9","ATT","QZ1","QZ2","QZ3","QZ4","EX1","EX2",
              "Test1","Test2","Quiz","Homework","Overall","Grades","Lab")
             ), #end select
                sliderInput("width",
                  label = "Bind width",
                  min = 1,
                  max = 10,
                  value = 2)
        ), # end conditional panel 
    

      conditionalPanel(
               condition = "input.tabs == 'Scatterplot'",   
      selectInput("xvar", 
                  label = h3("Select variable"), 
                  choices = 
                  list("HW1","HW2","HW3","HW4","HW5","HW6","HW7","HW8",
              "HW9","ATT","QZ1","QZ2","QZ3","QZ4","EX1","EX2",
              "Test1","Test2","Quiz","Homework","Overall","Grades","Lab")
             ), #end select

      selectInput("yvar", 
                  label = h3("Select variable"), 
                  choices = 
                  list("HW1","HW2","HW3","HW4","HW5","HW6","HW7","HW8",
              "HW9","ATT","QZ1","QZ2","QZ3","QZ4","EX1","EX2",
              "Test1","Test2","Quiz","Homework","Overall","Grades","Lab")
             ), #end select

     sliderInput("opacity", "Opacity",
                  min = 0, 
                  max = 1, 
                  value = .7), 
   
    radioButtons("smooth", label = h3("Show line"),
                   choices = list("none"  = 1, 
                                  "lm"    = 2, 
                                  "loess" = 3), 
                   selected = 1)
          ) # end conditional panel

      ), # 

      # sliderInput("width",
      #             label = "Bind width",
      #             min = 1,
      #             max = 10,
      #             value = 2),
      # tableOutput("table") 

      #     ),
    mainPanel(
      
      # # Output: Tabset w/ plot, summayr, and table ----
      tabsetPanel(id = "tabs", 
                  type = "tabs",
                  tabPanel("Barchart", 
                    ggvisOutput("barPlot")
                    # verbatimTextOutput("tbl_text"), 
                    ),
                  tabPanel("Histogram",
                      ggvisOutput("histPlot"),
                      verbatimTextOutput("summary")
                    ),
                  tabPanel("Scatterplot",
                       ggvisOutput("scatterPlot"), 
                       verbatimTextOutput("correlation")
                    )
                ) # end tabset panel 
      
 
    ) # end main Panel
  ) # sidebar Layout
)






# Define server logic required to draw a histogram
server <- function(input, output) {
  

  vis_scatter <- reactive({
    # Normally we could do something like props(x = ~HW1, y = ~HW2),
    # but since the inputs are strings, we need to do a little more work.
    xvar <- prop("x", as.symbol(input$yvar))
    yvar <- prop("y", as.symbol(input$xvar))

    gg <- scores %>% 
          ggvis(x = xvar, y = yvar) %>% 
          layer_points(size :=  50,
                       fillOpacity := input$opacity) 
          # layer_model_predictions(model = "lm")

    if(input$smooth == 2){
      gg <- gg %>% layer_model_predictions(model = "lm")
    } 
    if (input$smooth == 3){
      if(input$yvar == input$xvar){
        gg 
      } else {
        gg <- gg %>% layer_model_predictions(model = "loess") 
      }
    }
    gg  
  })

  vis_scatter %>% bind_shiny("scatterPlot")


  vis_hist <- reactive({
    # Normally we could do something like props(x = ~HW1, y = ~HW2),
    # but since the inputs are strings, we need to do a little more work.
    xvar <- prop("x", as.symbol(input$xvar0))


    histogram <- scores %>%
      ggvis(x = xvar) %>%
      layer_histograms(stroke := 'white', width = input$width)
  })
  
  vis_hist %>% bind_shiny("histPlot")


  vis_bar <- reactive({

      barchart <- scores %>%
      ggvis(~Grades) %>%
      layer_bars( )


  })

    vis_bar %>% bind_shiny("barPlot")


  # vis_bar %>% bind_shiny("barPlot")
  output$correlation <- renderPrint({
     correlation <- cor(scores[, input$xvar], scores[, input$yvar])
     paste0("Correlation: ", correlation)
    })

  output$summary <- renderPrint({

      print_stats(scores[, input$xvar0])
     

  })

  output$table <- renderTable({ gradedf})

}




# Run the application 
shinyApp(ui = ui, server = server)