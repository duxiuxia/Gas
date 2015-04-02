# ADAP-GC

# Get EIC from the raw data

# Written by Xiuxia Du in March 2015.

rm(list=ls())


code_path <- "/Users/xdu4/Documents/Duxiuxia/myGitHub/Gas"
file_path <- "/Users/xdu4/Documents/Duxiuxia/Dataset"

in_file_name <- "D_C12_10SPLIT_1.CDF"
in_file_full_name <- paste(file_path, in_file_name, sep=.Platform$file.sep)

if( !is.element("ncdf", installed.packages()[,1]) )
    install.packages("ncdf")

library("ncdf")

ncid <- open.ncdf(in_file_full_name)
#     print(ncid)

point_count <- get.var.ncdf(ncid, "point_count")
mass_values <- get.var.ncdf(ncid, "mass_values")
intensity_values <- get.var.ncdf(ncid, "intensity_values")
inter_scan_time <- get.var.ncdf(ncid, "inter_scan_time")

scan_count <- length(point_count)



close.ncdf(ncid)



for (i in 500:500) {
    point_start <- sum(point_count[1:i-1])+1
    point_end <- sum(point_count[1:i])
    
    current_mass_values <- mass_values[point_start:point_end]
    current_intensity_values <- intensity_values[point_start:point_end]
    
#     start <- 211
#     end <- 240
#     
#     plot(current_mass_values[start:end], current_intensity_values[start:end], type="h")
    
    current_mass_values <- round(mass_values[point_start:point_end])
    current_intensity_values <- intensity_values[point_start:point_end]
    
    current_scan <- data.frame(mz=current_mass_values, abundance=current_intensity_values)
    
    unique_mz <- unique(current_scan$mz)
    
    re <- split(current_scan, current_scan$mz)
    
    yy <- lapply(re, getMax)
}



getMax <- function(x) {
    II <- which(x$abundance == max(x$abundance))
        return(x[II[1],])
}




