library(imager)
library(scales)

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

# Image registration
source("image_registration.R")
cnt <- read.csv("convex_hull/60000-lower.csv", header = F, col.names = c("X", "Y"))
lower_ref <- read.csv("convex_hull/60000-lower-ref.csv", header = F, col.names = c("X", "Y"))
upper_ref <- read.csv("convex_hull/60000-upper-ref.csv", header = F, col.names = c("X", "Y"))
lower60k <- raw_cord2new_cord(cnt, lower_ref, upper_ref)
plot(x = lower60k[,1], y = lower60k[,2], type = "n")
polygon(x = lower60k[,1], y = lower60k[,2], col = alpha("red", 0.4))

cnt10k <- read.csv("convex_hull/10000-lower.csv", header = F, col.names = c("X", "Y"))
lower_ref10k <- read.csv("convex_hull/10000-lower-ref.csv", header = F, col.names = c("X", "Y"))
upper_ref10k <- read.csv("convex_hull/10000-upper-ref.csv", header = F, col.names = c("X", "Y"))
lower10k <- raw_cord2new_cord(cnt10k, lower_ref10k, upper_ref10k)
polygon(x = lower10k[,1], y = lower10k[,2], col = alpha("blue", 0.4))
