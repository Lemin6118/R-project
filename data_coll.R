
install.packages("rstudioapi")

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

getwd()

loc <- read.csv("./Open_data_R_with_Shiny/01_code/sigun_code/sigun_code.csv", fileEncoding="UTF-8")
loc$code <- as.character(loc$code)
head(loc, 2) 

datelist <- seq(from = as.Date('2021-01-01'), 
                to   = as.Date('2021-12-31'), 
                by    = '1 month')            
datelist <- format(datelist, format = '%Y%m') 
datelist[1:3] 

#인증키
service_key <- "D%2BzZ%2B%2BKS2q7h3dBQmQua7MUzCFuL%2FHRCKHy26%2FZHCLwgDj0SK0hX%2FOMoK3kIEyzw4lp%2FQLsK%2FWktchm9THQi%2BA%3D%3D"

url_list <- list() 
cnt <-0

for(i in 1:nrow(loc)){
  for(j in 1:length(datelist)){ 
    cnt <- cnt + 1 
    url_list[cnt] <- paste0("http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTrade?",
                            "LAWD_CD=", loc[i,1],
                            "&DEAL_YMD=", datelist[j],
                            "&numOfRows=", 100,
                            "&serviceKey=", service_key) 
  } 
  Sys.sleep(0.1) 
  msg <- paste0("[", i,"/",nrow(loc), "]  ", loc[i,3], " 의 크롤링 목록이 생성됨 => 총 [", cnt,"] 건")
  cat(msg, "\n\n") 
}
