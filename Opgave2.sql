library(httr)
library(rvest)

stations <- list(
  list(name = "Aarhus", url = "https://envs2.au.dk/Luftdata/Presentation/table/Aarhus/AARH3", js_url = "https://envs2.au.dk/Luftdata/Presentation/table/MainTable/Aarhus/AARH3"),
  list(name = "Risø", url = "https://envs2.au.dk/Luftdata/Presentation/table/Rural/RISOE", js_url = "https://envs2.au.dk/Luftdata/Presentation/table/MainTable/Rural/RISOE"),
  list(name = "Anholt", url = "https://envs2.au.dk/Luftdata/Presentation/table/Rural/ANHO", js_url = "https://envs2.au.dk/Luftdata/Presentation/table/MainTable/Rural/ANHO"),
  list(name = "HCAB", url = "https://envs2.au.dk/Luftdata/Presentation/table/Copenhagen/HCAB", js_url = "https://envs2.au.dk/Luftdata/Presentation/table/MainTable/Copenhagen/HCAB")
)

fetch_miljødata <- function(station_url, js_url) {
  raw_res <- GET(url = station_url, add_headers(`User-Agent` = "Mozilla/5.0"))
  raw_content <- content(raw_res, as = "text", encoding = "UTF-8")
  token <- read_html(raw_content) %>% 
    html_element("input[name='__RequestVerificationToken']") %>% 
    html_attr("value")
  
  post_res <- POST(url = js_url, 
                   add_headers(`User-Agent` = "Mozilla/5.0"),
                   body = list(`__RequestVerificationToken` = token), 
                   encode = "form")
  
  table_html <- content(post_res, as = "text", encoding = "UTF-8")
  table_page <- read_html(table_html)
  
  rows <- table_page %>% html_elements("tr")
  table_data <- rows %>% html_elements("td") %>% html_text(trim = TRUE)
  header <- table_page %>% html_elements("th") %>% html_text(trim = TRUE)
  
  header_amount <- length(header)
  table_matrix <- matrix(data = unlist(table_data), ncol = header_amount, byrow = TRUE)
  df <- as.data.frame(table_matrix)
  colnames(df) <- header
  
  df[, 2:header_amount] <- lapply(df[, 2:header_amount], function(x) as.numeric(gsub(",", ".", x)))
  
  return(df)
}

for (station in stations) {
  df <- fetch_miljødata(station$url, station$js_url)
  rds_filename <- paste0(station$name, "_", format(Sys.time(), "%Y-%m-%d_%H-%M"), ".rds")
  saveRDS(df, rds_filename)
  print(paste(station$name, "data gemt som", rds_filename))
}
