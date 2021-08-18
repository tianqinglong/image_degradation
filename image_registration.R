raw_cord2new_cord <- function(cnt, lower_ref, upper_ref)
# cnt is contour; lower_ref is the lower circle; upper_ref is the upper circle
{
  lower_center <- colMeans(lower_ref)
  upper_center <- colMeans(upper_ref)
  base_vector <- upper_center-lower_center
  
  theta_base <- atan2(base_vector[2], base_vector[1])
  r_base <- sqrt(sum(base_vector^2))
  
  polar_mat <- matrix(ncol = 2, nrow = nrow(cnt))
  for (i in 1:nrow(cnt))
  {
    pnt <- cnt[i,]
    cur_vector <- as.matrix(pnt-lower_center)
    theta_cur <- atan2(cur_vector[2], cur_vector[1])
    r_cur <- sqrt(sum(cur_vector^2))
    
    theta_real <- theta_cur-theta_base
    r_real <- r_cur/r_base
    
    polar_mat[i,] <- c(r_real, theta_real)
  }
  
  xy_mat <- cbind(polar_mat[,1]*cos(polar_mat[,2]),
                  polar_mat[,1]*sin(polar_mat[,2]))
  xy_mat <- as.data.frame(xy_mat)
  colnames(xy_mat) <- c("X", "Y")
  return(xy_mat)
}
