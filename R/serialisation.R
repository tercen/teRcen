#' Convert File to Tercen Table
#' 
#' Serialise a file to a Tercen operator output table. 
#' @export
file_to_tercen <- function(file_path, chunk_size_bits = 1e6, filename = NULL) {
  
  if (is.null(filename)) {
    filename <- basename(file_path)
  }
  
  mimetype <- switch(
    tools::file_ext(file_path),
    png = "image/png",
    svg = "image/svg+xml", 
    csv = "text/csv",
    pdf = "application/pdf",
    "unknown"
  )
  
  raw_vector <- readBin(
    file_path,
    "raw",
    file.info(file_path)[1, "size"]
  )
  
  splitted <- split(
    x = raw_vector, 
    f = ceiling((seq_along(raw_vector) * 8) / chunk_size_bits)
  )
  
  output_txt <- unlist(
    x = lapply(X = splitted, FUN = base64enc::base64encode)
  )
  
  df <- tibble::tibble(
    filename = filename,
    mimetype = mimetype,
    .content = output_txt
  )
  
  return(df)
  
}
