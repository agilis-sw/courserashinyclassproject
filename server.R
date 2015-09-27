library(shiny)
library(reshape2)
library(ggplot2)

normalize <- function(df) {
        dfn=melt(df,id="Year")
        names(dfn)[2]="Asset.class"
        names(dfn)[3]="Return"
        dfn$Asset.class=as.factor(dfn$Asset.class)
        return(dfn)
}

dosummaryplot <- function(dfn, yearfrom, yearto) {
        gtitle = paste("Summary performance of asset classes for period", as.character(yearfrom), "through", as.character(yearto))
        dfnx = dfn[(dfn$Year >= yearfrom & dfn$Year <= yearto), ];
        plt=ggplot(dfnx, aes(x=Asset.class, y=Return, fill=Asset.class)) + geom_boxplot() +
                stat_summary(fun.y=mean, geom="point", shape=5, size=4) +
                scale_x_discrete("Asset Class",
                                 labels=c("Smallcap Stock","Value Stock","Largecap Stock","Growth Stock",
                                          "Real Estate Stock","Foreign Developed Stock","Hi Yield Bond",
                                          "Investment Grade Bond","Emerging Market Stock","Commodity"))+
                scale_y_continuous("Return (percent)",breaks=c(-60,-55,-50,-45,-40,-35,-30,-25,-20,-15,-10,-5,0,5,10,15,20,25,30,35,40,45,50,55,60))+
                ggtitle(gtitle)
        #print(plt)
        #ggsave(filename="asset-perf-summary.png",plot=plt)
        return(plt)
}

df = read.csv("asset-class-performance-1998-thru-2013.csv")
dfn <- normalize(df)
minYear = dfn[1,1]
maxYear = dfn[nrow(dfn),1]


shinyServer(
     function(input, output) {
             output$startYearSlider <- renderUI(
                     sliderInput("startYear", "Year From (Inclusive): ", value=minYear, min=minYear, max=maxYear, step=1, sep="")
             )
             output$endYearSlider <- renderUI(
                     sliderInput("endYear", "Year To (Inclusive): ", value=maxYear, min=input$startYear, max=maxYear, step=1, sep="")
             )
             output$startYearVal = renderText(paste('Year from (inclusive):',input$startYear))
             output$endYearVal = renderText(paste('Year to (inclusive):',input$endYear))
             output$perfPlot = renderPlot(dosummaryplot(dfn, input$startYear, input$endYear))
     }
)

