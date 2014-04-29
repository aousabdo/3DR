library(shiny)
library(grDevices)
library(shinyRGL)

footer <- source("footer.R")$value

funlist <- list(
  "sin(x + y)",
  "x^2-y^2",
  "x*y^3 - y*x^3", 
  "x^3 + y^3*sin(x) ", 
  "-x*y*exp(-x^2-y^2)", 
  "(x^2 + 3*y^2)*exp(-x^2-y^2)",
  "log(abs(x)*abs(y))*sin(x+y)",
  "atan(-x^2*y/4)",
  "atan(-x^2+y^2)",
  "atan(-x^2*y^-2/8)",
  "atan(-x^2+y^3/4)",
  "cos(abs(x)+abs(y))",
  "sin(sqrt(x^2+y^2))",
  "sin(x+y)*(x^4-y^4)",
  "Catherdral Function"="sqrt(x^4+y^4)/(x^10+y^10+5)",
  "Volcano Functino"="sqrt(x^2+y^2)/(x^2+y^2+2.5)",
  "sin(r)/r, r = sqrt(x^2 + y^2)"="sin(sqrt(x^2 + y^2))/sqrt(x^2 + y^2)", 
  "sin(abs(x)+abs(y))*tan(0.1*x)",
  "cos(abs(x)+abs(y))*(abs(x)+abs(y))",
  "cos(x + y)*r, r = sqrt(x^2 + y^2)"= "cos(x+y)*sqrt(x^2 + y^2)", 
  "sin(x^2+3y^2)/(0.1+r^2)+(x^2+5y^2)*exp(1-r^2)/2"=
    "sin(x^2+3*y^2)/(0.1+x^2+y^2)+(x^2+5*y^2)*exp(1-x^2-y^2)/2"
)

shinyUI(pageWithSidebar(
#   headerPanel("Free Online 3D Grapher"),
  headerPanel(
    HTML(
      '<div id="stats_header">
			Free Online 3D Grapher
			<a href="http://www.statstudio.net/free-tools/" target="_blank">
			<img id="statstudio_logo" align="right" alt="StatStudio Logo" src="./StatStudio_Logo.png", height = 72, width = 72>
			</a>
			</div>'
    ),
    "Free Online 3D Grapher"
  ),
  sidebarPanel(
    HTML("<p align=\"justify\">This web app makes 3D graphs of mathematical functions. You 
can either select a function from the list below, or enter your own function by 
chekcing the box next to the \"Input Function to Plot\" below.</p>"),
    br(),
    conditionalPanel(condition="input.userInput != true", 
                     selectInput("fun", "Select Function to Graph:", choices=funlist, 
                                 selected="sin(r)/r, r = sqrt(x^2 + y^2)"),
                     br()
    ),
    checkboxInput(inputId = "userInput",
                  label = strong("Input Function to Plot:"),
                  value = FALSE),
    conditionalPanel(condition="input.userInput == true",  
                     HTML("<p align=\"justify\">Enter a valid function in x and/or y. The app will recognize only x, y, 
and a valid mathematical expression. 
The form of the function is z(x,y) = f(x,y), you don't need to include the left hand side of the equation, 
just the part you wanted graphed, i.e. f(x,y). You have to follow
the R syntax when entering a function, for example you need to use the \" * \" sign when multiplying. Examples:</p>"),
                     helpText("1)  x+y+sin(x+y)"),
                     helpText("2)  tanh(x-y)"),
                     helpText("3)  log(x+y+9)*exp(x)"),
                     helpText("4)  exp(x+y)/(1+exp(x+y))"),
                     textInput("userfun", "", value="sin(x+y)"),
                     br()
    ),
    br(),
    sliderInput("theta", "Theta: Horizontal Rotation Angle:", min=0, max=360, step=1, value=90),
    br(),  
    sliderInput("phi", "Phi: Vertical Rotation Angle:", min=-180, max=180, step=1, value=30),
    br(),
    sliderInput("x", "X-axis Range:", min=-50, max=50, step=1, value=c(-10,10)),
    br(),
    sliderInput("y", "Y-axis Range:", min=-50, max=50, step=1, value=c(-10,10)),
    br(),
    sliderInput("z", "Expansion Coefficient on Vertical axis:", min=0.1, max=1, step=0.1, value=0.5), 
    br(),
    sliderInput("res", "Graph Resolution:", min=1, max=10, step=0.1, value=5),
#     HTML("<hr />"),
#     HTML('Created using <a href = \"http://www.r-project.org/\" target="_blank"> R</a> and 
#                   <a href = \"http://www.rstudio.com/shiny/\" target="_blank"> Shiny</a>. 
#          Hosted by <a href ="http://www.rstudio.com" target="_blank"> RStudio </a>'),
   footer()
  ),
  mainPanel(plotOutput("plot", width="700px", height="700px")
  )
  
))