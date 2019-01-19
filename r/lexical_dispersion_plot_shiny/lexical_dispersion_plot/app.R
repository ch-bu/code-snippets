#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(tidytext)
library(pacman)

bk_color <- "#252525"
grey_color <- "#565656"


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  includeCSS("styles.css"),
   
   # Application title
   titlePanel("Plot your own lexical dispersion plots"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        textAreaInput("caption", "Your Text", "Paste your text here",
                      height = "400px"),
        textAreaInput("keywords", "Keywords", "Keywords seperated by a comma",
                      height = "100px"),
        actionButton("button", "Analyze text")
      ),

      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("lexicalDispersionPlot"),
         plotOutput("xray")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  observeEvent(input$button, {
    output$lexicalDispersionPlot <- renderPlot({
      
      # Unnest tokens
      tokens_unnested <- tibble(text = isolate(input$caption)) %>%
        unnest_tokens(word, text) 
      
      # Get full length of tokens
      token_length <- nrow(tokens_unnested)
      
      # Get keywords
      keywords <- isolate(input$keywords) %>%
        str_split(",") %>% {.[[1]]} %>%
        str_trim() %>%
        str_to_lower
      
      # Filter relevant words
      cleaned <- tokens_unnested %>%
        rowid_to_column() %>%
        filter(word %in% keywords)
      
      # Plot lexical dispersion plot
      ggplot(cleaned, aes(x = rowid, y = 1)) + 
        geom_segment(aes(xend = rowid, yend = 0), color = "#E55D87") +
        facet_grid(word ~ .) +
        scale_x_continuous(limits = c(1, token_length)) +
        guides(color = FALSE) +
        theme(
          plot.margin = unit(c(1, 1, 1, 1), "cm"),
          axis.ticks.y = ggplot2::element_blank(),
          axis.text.y = ggplot2::element_blank(),
          plot.background = element_rect(fill = bk_color, color = bk_color),
          panel.background = element_blank(),
          panel.grid.minor = element_line(colour = bk_color),
          panel.grid.major.x = element_line(colour = bk_color),
          panel.grid.major.y = element_line(colour = bk_color),
          axis.text = element_text(colour = "beige"),
          strip.text.y = element_text(size = 14),
          axis.title = element_text(colour = "beige"),
          plot.title = element_text(colour = "beige",
                                    margin = unit(c(0, 0, 1, 0), "cm")),
          panel.border = ggplot2::element_rect(colour = grey_color, fill = NA)
        ) +
        labs(
          x = "Token",
          y = ""
        )
    }, height = 600)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

