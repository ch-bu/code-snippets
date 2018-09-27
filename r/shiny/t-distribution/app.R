library(shiny)
library(tidyverse)
library(shinyWidgets)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("The Student T-Distribution Simulation"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("df1",
                     "Degrees of Freedom 1:",
                     min = 1,
                     max = 50,
                     value = 29),
         
         sliderInput("df2",
                     "Degrees of Freedom 2:",
                     min = 1,
                     max = 50,
                     value = 5),
         materialSwitch(inputId = "show_plot_1", value = TRUE, 
                        label = "Show first plot"),
         materialSwitch(inputId = "show_plot_2", value = TRUE, 
                        label = "Show first two"),
         materialSwitch(inputId = "show_plot_3", value = TRUE, 
                        label = "Show standard normal distribution")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("densityPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$densityPlot <- renderPlot({

    my_plot <- ggplot(NULL, aes(rnorm(100)))
      
      if (input$show_plot_1) {
        my_plot = my_plot + geom_area(stat = "function", fun = dt, 
                  fill = "#998ec3", alpha = .5, 
                  args = list(df = input$df1))
      }
      
      if (input$show_plot_2) {
        my_plot = my_plot + geom_area(stat = "function", fun = dt, 
                  fill = "#7fc97f", alpha = .5, 
                  args = list(df = input$df2))
      }
    
      if (input$show_plot_3) {
        my_plot = my_plot + geom_area(stat = "function", fun = dnorm, 
                                      color = "black",
                                      fill = NA, 
                                      linetype = "dashed", alpha = .5)
      }
    
      my_plot = my_plot + xlab("T-Werte") +
        ylab("Dichte") +
        xlim(-5, 5) +
        ylim(0, 0.5) +
        theme_minimal()
      
      return(my_plot)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

