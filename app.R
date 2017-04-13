#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
if("shiny" %in% rownames(installed.packages()) == FALSE) {install.packages("shiny")}
if("doBy" %in% rownames(installed.packages()) == FALSE) {install.packages("DT")}
if("rNVD3" %in% rownames(installed.packages()) == FALSE) {install.packages("RODBC")}
if("doBy" %in% rownames(installed.packages()) == FALSE) {install.packages("doBy")}
if("devtools" %in% rownames(installed.packages()) == FALSE) {install.packages("devtools")}
if("rCharts" %in% rownames(installed.packages()) == FALSE) {require(devtools)
  install_github('rCharts', 'ramnathv')}


library(shiny)

library(rCharts)
require(rNVD3)

require(devtools)
library(doBy)
#install_github('rNVD3', 'ramnathv')


df  <- read.csv(file="F:\\Maxwell\\Other\\MFO\\CSV Files\\Analysis_Sep19_New.csv", header=TRUE, sep=",")
df_treat <- df[which(df$Baseline==0),]
df_base <- df[which(df$Baseline==1),]
mdf_treat <- aggregate(df_treat$Poverty.Likelihood, list(df_treat$Village.Code.Final), mean)
mdf_base <- aggregate(df_base$Poverty.Likelihood, list(df_base$Village.Code.Final), mean)




dfB <- df[which(df$country=="Burkina"),]
dfS <- df[which(df$country=="Senegal"),]
dfU <- df[which(df$country=="Uganda"),]


dfB_treat <- dfB[which(dfB$Baseline==0),]
dfB_base <- dfB[which(dfB$Baseline==1),]
mdfB_treat <- aggregate(dfB_treat$Poverty.Likelihood, list(dfB_treat$Village.Code.Final), mean)
mdfB_base <- aggregate(dfB_base$Poverty.Likelihood, list(dfB_base$Village.Code.Final), mean)


colnames(mdfB_treat) <- c("village.code","mean.y")
colnames(mdfB_base) <- c("village.code","mean.x")
mdfB <- merge(mdfB_treat, mdfB_base, by.x="village.code", by.y="village.code")
mdfB$difference <- mdfB$mean.y-mdfB$mean.x
mdfB <- mdfB[-1,]


dfS_treat <- dfS[which(dfS$Baseline==0),]
dfS_base <- dfS[which(dfS$Baseline==1),]
mdfS_treat <- aggregate(dfS_treat$Poverty.Likelihood, list(dfS_treat$Village.Code.Final), mean)
mdfS_base <- aggregate(dfS_base$Poverty.Likelihood, list(dfS_base$Village.Code.Final), mean)

colnames(mdfS_treat) <- c("village.code","mean.y")
colnames(mdfS_base) <- c("village.code","mean.x")
mdfS <- merge(mdfS_treat, mdfS_base, by.x="village.code", by.y="village.code")
mdfS$difference <- mdfS$mean.y-mdfS$mean.x
mdfS <- mdfS[-1,]


dfU_treat <- dfU[which(dfU$Baseline==0),]
dfU_base <- dfU[which(dfU$Baseline==1),]
mdfU_treat <- aggregate(dfU_treat$Poverty.Likelihood, list(dfU_treat$Village.Code.Final), mean)
mdfU_base <- aggregate(dfU_base$Poverty.Likelihood, list(dfU_base$Village.Code.Final), mean)

colnames(mdfU_treat) <- c("village.code","mean.y")
colnames(mdfU_base) <- c("village.code","mean.x")
mdfU <- merge(mdfU_treat, mdfU_base, by.x="village.code", by.y="village.code")
mdfU$difference <- mdfU$mean.y-mdfU$mean.x
mdfU <- mdfU[-1,]



partners = rep("", times = nrow(mdfB))
typePN = rep("", times = nrow(mdfB))
typeFP = rep("", times = nrow(mdfB))
typeSBL = rep("", times = nrow(mdfB))


for (i in 1:nrow(mdfB)){
  if(nrow(dfB_treat[dfB_treat$Village.Code.Final==as.character(mdfB$village.code[i]),]>0))
    partners[i] <- as.character(dfB_treat[dfB_treat$Village.Code.Final==as.character(mdfB$village.code[i]),]$Partner.Name) 
  
  if(nrow(dfB_treat[dfB_treat$Village.Code.Final==as.character(mdfB$village.code[i]),]>0))
    typePN[i] <- as.character(dfB_treat[dfB_treat$Village.Code.Final==as.character(mdfB$village.code[i]),]$propoornormal) 
  
  if(nrow(dfB_treat[dfB_treat$Village.Code.Final==as.character(mdfB$village.code[i]),]>0))
    typeFP[i] <- as.character(dfB_treat[dfB_treat$Village.Code.Final==as.character(mdfB$village.code[i]),]$flatproportional) 
  
  if(nrow(dfB_treat[dfB_treat$Village.Code.Final==as.character(mdfB$village.code[i]),]>0))
    typeSBL[i] <- as.character(dfB_treat[dfB_treat$Village.Code.Final==as.character(mdfB$village.code[i]),]$squeezebetonnelimite) 
  
  
}
mdfB$partner <- partners
mdfB$typePN <- typePN
mdfB$typeFP <- typeFP
mdfB$typeSBL <- typeSBL

partners = rep("", times = nrow(mdfS))
typePN = rep("", times = nrow(mdfS))
typeFP = rep("", times = nrow(mdfS))
typeSBL = rep("", times = nrow(mdfS))

for (i in 1:nrow(mdfS)){
  if(nrow(dfS_treat[dfS_treat$Village.Code.Final==as.character(mdfS$village.code[i]),]>0))
    partners[i] <- as.character(dfS_treat[dfS_treat$Village.Code.Final==as.character(mdfS$village.code[i]),]$Partner.Name) 
  
  if(nrow(dfS_treat[dfS_treat$Village.Code.Final==as.character(mdfS$village.code[i]),]>0))
    typePN[i] <- as.character(dfS_treat[dfS_treat$Village.Code.Final==as.character(mdfS$village.code[i]),]$propoornormal) 
  
  if(nrow(dfS_treat[dfS_treat$Village.Code.Final==as.character(mdfS$village.code[i]),]>0))
    typeFP[i] <- as.character(dfS_treat[dfS_treat$Village.Code.Final==as.character(mdfS$village.code[i]),]$flatproportional) 
  
  if(nrow(dfS_treat[dfS_treat$Village.Code.Final==as.character(mdfS$village.code[i]),]>0))
    typeSBL[i] <- as.character(dfS_treat[dfS_treat$Village.Code.Final==as.character(mdfS$village.code[i]),]$squeezebetonnelimite) 
  
  
}
mdfS$partner <- partners
mdfS$typePN <- typePN
mdfS$typeFP <- typeFP
mdfS$typeSBL <- typeSBL

partners = rep("", times = nrow(mdfU))
typePN = rep("", times = nrow(mdfU))
typeFP = rep("", times = nrow(mdfU))
typeSBL = rep("", times = nrow(mdfU))

for (i in 1:nrow(mdfU)){
  if(nrow(dfU_treat[dfU_treat$Village.Code.Final==as.character(mdfU$village.code[i]),]>0))
    partners[i] <- as.character(dfU_treat[dfU_treat$Village.Code.Final==as.character(mdfU$village.code[i]),]$Partner.Name) 
  
  if(nrow(dfU_treat[dfU_treat$Village.Code.Final==as.character(mdfU$village.code[i]),]>0))
    typePN[i] <- as.character(dfU_treat[dfU_treat$Village.Code.Final==as.character(mdfU$village.code[i]),]$propoornormal) 
  
  if(nrow(dfU_treat[dfU_treat$Village.Code.Final==as.character(mdfU$village.code[i]),]>0))
    typeFP[i] <- as.character(dfU_treat[dfU_treat$Village.Code.Final==as.character(mdfU$village.code[i]),]$flatproportional) 
  
  if(nrow(dfU_treat[dfU_treat$Village.Code.Final==as.character(mdfU$village.code[i]),]>0))
    typeSBL[i] <- as.character(dfU_treat[dfU_treat$Village.Code.Final==as.character(mdfU$village.code[i]),]$squeezebetonnelimite) 
  
  
}
mdfU$partner <- partners
mdfU$typePN <- typePN
mdfU$typeFP <- typeFP
mdfU$typeSBL <- typeSBL


# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
  
  sidebarPanel( width = 3,
            selectInput("country", "Country List:", choices = c("Burkina", "Senegal", "Uganda"),selected = ""),
            
            #selectInput("partner", "Partner List:", as.matrix(unique(data.frame("All",dfB$Partner.Name))),selected = ""),
            uiOutput("Box1"),                                            
            selectInput("type", "Package Type:", choices = c("All",
                                                             "Propoor/Normal" = "typePN",
                                                             "Flat/Proportional" ="typeFP",
                                                             "Squeeze/bettone/limite"="typeSBL"))
            
            #textOutput("text")
  ),
  # Show a plot of the generated distribution
  mainPanel(
    tabsetPanel(
      
      tabPanel("Diff Mean",  
               showOutput("myChart1","nvd3")))
    
  )
  
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {
  
  output$text <- renderText(
    paste(grepl(input$partner,"Kdg"))
  )
  dataInput <- reactive({
  })
  
  output$Box1 = renderUI({
    if(input$country == "Burkina")
      selectInput("partner", "Partner List:", as.matrix(unique(data.frame("All",dfB$Partner.Name))),selected = NULL)
    else if(input$country == "Senegal")
      selectInput("partner", "Partner List:", as.matrix(unique(data.frame("All",dfS$Partner.Name))),selected = NULL)
    else if(input$country == "Uganda")
      selectInput("partner", "Partner List:", as.matrix(unique(data.frame("All",dfU$Partner.Name))),selected = NULL)
  })
  
  output$myChart1 <- renderChart2({
    if(grepl(input$country,"Burkina"))
      data <-  mdfB
    else if(grepl(input$country,"Senegal"))
      data <-  mdfS
    else 
      data <-  mdfU
    if(grepl(input$partner,"All")){
      if(grepl(input$type,"All"))
        p1 <- nPlot(difference ~ village.code, data, group = c('partner'),
                type = 'multiBarChart')
      else 
        p1 <- nPlot(difference ~ village.code, data,
                    group = input$type, type = 'multiBarChart')
    }else
      p1 <- nPlot(difference ~ village.code, data[which(data$partner==as.character(input$partner)),],
                  group = input$type, type = 'multiBarChart')
    return(p1)
  })
})



# Run the application 
shinyApp(ui = ui, server = server)

