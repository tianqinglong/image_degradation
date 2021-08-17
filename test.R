library(imager)

# Read in the hand-processed image
img50k <- load.image("outlined_photo/50000.png")

# Read in the convex-hull (contour of damaged area)
lower <- read.csv("convex_hull/50000-lower.csv", header = F, col.names = c("X", "Y"))

# Plot the contour on the hand-processed image
plot(img50k)
for(i in 1:(nrow(lower)-1))
{
  x_cor <- lower[i, 1]
  x_cor_next <- lower[i+1, 1]
  
  y_cor <- lower[i, 2]
  y_cor_next <- lower[i+1, 2]
  
  lines(x = c(x_cor, x_cor_next), y = c(y_cor, y_cor_next), col = "blue", lwd = 2)
}
lines(x = c(x_cor_next, lower[1,1]), y = c(y_cor_next, lower[1,2]))

# Plot the contour on a blank image
blank_img <- as.cimg(array(1, dim = c(1598, 2048, 1, 4)))
plot(blank_img)
for(i in 1:(nrow(lower)-1))
{
  x_cor <- lower[i, 1]
  x_cor_next <- lower[i+1, 1]
  
  y_cor <- lower[i, 2]
  y_cor_next <- lower[i+1, 2]
  
  lines(x = c(x_cor, x_cor_next), y = c(y_cor, y_cor_next), col = "blue", lwd = 2)
}
lines(x = c(x_cor_next, lower[1,1]), y = c(y_cor_next, lower[1,2]))