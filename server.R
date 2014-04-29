library(shiny)
library(grDevices)

nbcol <- 100
jet.colors <- colorRampPalette( c("darkblue","blue","skyblue", "green", "yellow", "red"), 
                                interpolate="linear" )
colorRampPalette(c("#00007F", "blue", "#007FFF", "cyan",
                   "#7FFF7F", "yellow", "#FF7F00", "red", "#7F0000"))
color <- jet.colors(nbcol)

shinyServer(function(input, output){
  output$plot <- renderPlot({
    theta <- input$theta
    phi   <- input$phi
    xmin  <- input$x[1]
    xmax  <- input$x[2]
    ymin  <- input$y[1]
    ymax  <- input$y[2]
    
    x <- seq(xmin, xmax, length= input$res*20)
    y <- seq(ymin, ymax, length= input$res*20)
    
    if(input$userInput){
      f <- function(x, y) {eval(parse(text=input$userfun))}
      funname <- input$userfun
    }
    else{ 
      f <- function(x,y) {eval(parse(text=input$fun))}
      funname <- input$fun
    }
    
    z <- outer(x, y, f)
    z[is.na(z)] <- 1
    
    nrz <- nrow(z)
    ncz <- ncol(z)
    
    # Compute the z-value at the facet centres
    zfacet <- z[-1, -1] + z[-1, -ncz] + z[-nrz, -1] + z[-nrz, -ncz]
    # Recode facet z-values into color indices
    facetcol <- cut(zfacet, nbcol)
    
    persp(x, y, z, theta = theta, phi = phi, expand = input$z, col = color[facetcol], 
          xlab = "X", ylab = "Y", zlab = funname, #axes=FALSE, box=FALSE,
          shade = 0.01, ticktype = "detailed",
          cex.axis = 1.5, cex.lab = 1.4, ltheta=10)
    mtext(text=expression(bold("StatStudio.net")), cex=2, font=2, side=1, col="blue")
  })
  
  #   output$sctPlot <- renderWebGL({
  #     points3d(xPts[1:200],
  #              yPts[1:200],
  #              zPts[1:200])
  #     axes3d()
  #   })
  
  
})