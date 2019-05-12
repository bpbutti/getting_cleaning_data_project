library(data.table)
library(tidyverse)
library(readxl)
library(xml2)

download_file_curl <- function(input_data_folder,
                               file_name,
                               file_extension,
                               file_url){
  file_name_ext <- paste(file_name, file_extension, sep = ".")
  file_date_name <- paste0(file_name, "_date.txt")
  file_path <- file.path(input_data_folder, file_name_ext)
  file_date_path <- file.path(input_data_folder, file_date_name)
  
  if(!file.exists(file_path)){
    download.file(
      url = file_url,
      destfile = file_path,
      method = "curl")
    
    date_downloaded <- date()
    write_file(
      x = date_downloaded,
      path = file_date_path)
  }
}