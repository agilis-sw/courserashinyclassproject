library(shiny)
shinyUI(
	pageWithSidebar(
               headerPanel("Investing: Asset Class Performance Exploration Tool"),
               sidebarPanel(
                       helpText("This application is designed to help explore the",
                                "performance of various asset classes for a selected",
                                "range of years measured as percentage return, based on data obtained from",
                                "Fidelity Investments for an overall period ranging from",
                                "1998 through 2013.

                                The performance is displayed as a",
                                "box-and-whiskers plot in order to facilitate a",
                                "side-by-side comparison.
                                ",
                                "Simply use the sliders to select the lower and",
                                "upper dates, and the plot is generated on the fly.
                                ",
                                "Note that the application won't allow you to select",
                                "an upper bound below the lower bound."),
                       h3('Select Time Period:'),
                       uiOutput("startYearSlider"),
                       uiOutput("endYearSlider")
               ),
               mainPanel(
                    h3('Asset Class Performance Box-and-whiskers Plot'),
                    h4(textOutput("startYearVal")),
                    h4(textOutput("endYearVal")),
                    plotOutput("perfPlot")
               )
	)
)

