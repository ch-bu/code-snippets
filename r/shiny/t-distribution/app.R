library(shiny)
library(ggplot2)
library(shinyWidgets)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("T-Distribution simulation"),
   
   fluidRow(
     column(8, align = "center", 
      plotOutput("densityPlot")
    ),
    column(3, 
      HTML("<h2>About the simulation</h2>
           <p>The t-distribution is a probability distribution, which is
            widely used to test the difference between two sample means. 
           The t-distribution
           is commonly used for small sample sizes where the population
           standard deviation is not none.</p>
           <p>On the left you can see three distributions. The green and 
           purple density plots display two t-distributions with 
           arbitrary set degrees of freedom. The dashed line indicates 
           the standard normal distribution. With an increase in the
           degrees of freedom the t-distribution approximates the
           standard normal distribution.<p>
           <p>Try to adjust the degrees of freedom in both density plots
           and see how the t-distributions behave compared
           to the standard normal distribution.</p>")
           )
   ),
   fluidRow(
      column(4, 
             HTML("<h2 style='color: #998ec3; text-align: center'>Purble T-Distribution</h2>"),
             
             column(8,
                sliderInput("df1",
                            "Adjust the degrees of freedom:",
                            min = 1,
                            max = 50,
                            value = 29)
                    ),
              column(4,
                 switchInput(inputId = "show_plot_1", value = TRUE, 
                             label = "Show density distribution")
                 )
      ),
      column(4,
             HTML("<h2 style='color: #7fc97f; text-align: center'>Green T-Distribution</h2>"),
             column(8,
                sliderInput("df2",
                            "Adjust the degrees of freedom:",
                            min = 1,
                            max = 50,
                            value = 5)
             ),
             column(4,
                    switchInput(inputId = "show_plot_2", value = TRUE, 
                                label = "Show density distribution")
             )
      ),
      column(1, 
             switchInput(inputId = "show_plot_3", value = TRUE, 
                         label = "Show standard normal distribution") 
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
    
      my_plot = my_plot + xlab("x") +
        ylab("P(x)") +
        xlim(-5, 5) +
        ylim(0, 0.5) +
        theme_minimal()
      
      return(my_plot)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

