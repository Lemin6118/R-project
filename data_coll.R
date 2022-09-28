
#install.packages("rstudioapi")

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

getwd()

loc <- read.csv("./sigun_code.csv", fileEncoding="UTF-8")
loc$code <- as.character(loc$code)
head(loc, 2) 

datelist <- seq(from = as.Date('2021-01-01'), 
                to   = as.Date('2021-12-31'), 
                by    = '1 month')            
datelist <- format(datelist, format = '%Y%m') 
datelist[1:3] 

#인증키
service_key <- 'D%2BzZ%2B%2BKS2q7h3dBQmQua7MUzCFuL%2FHRCKHy26%2FZHCLwgDj0SK0hX%2FOMoK3kIEyzw4lp%2FQLsK%2FWktchm9THQi%2BA%3D%3D'

service_key

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

length(url_list)



browseURL(paste0(url_list[1])) 


library(XML)        # install.packages("XML")      
library(data.table) # install.packages("data.table")
library(stringr)    # install.packages("stringr")

raw_data <- list()  # XML 파일 저장소
root_Node <- list() # 거래 내역 추출 데이터 임시 저장
total <- list()     # 거래 내역 정리 데이터 임시 저장
if(!dir.exists("./02_raw_data")){
  dir.create("02_raw_data") # 새로운 폴더 만들기
}
# 2단계 : 자료 요청 및 응답 받기

for(i in 1:length(url_list)){
  raw_data[[i]] <- xmlTreeParse(url_list[i], useInternalNodes = TRUE,encoding = "utf-8")
  root_Node[[i]] <- xmlRoot(raw_data[[i]])
  
  items <- root_Node[[i]][[2]][['items']] 
  
  size <- xmlSize(items)
   

  item <- list()
  
  item_temp_dt <- data.table() 
  
  Sys.sleep(.1)
  
  for(m in 1:size){ 
    
    #---# 세부 거래내역 분리   
    item_temp <- xmlSApply(items[[m]],xmlValue)
    item_temp_dt <- data.table(year = item_temp[4],     # 거래 년 
                               month = item_temp[7],    # 거래 월
                               day = item_temp[8],      # 거래 일
                               price = item_temp[1],    # 거래금액
                               code = item_temp[12],    # 지역코드
                               dong_nm = item_temp[5],  # 법정동
                               jibun = item_temp[11],   # 지번
                               con_year = item_temp[3], # 건축연도 
                               apt_nm = item_temp[6],   # 아파트 이름   
                               area = item_temp[9],     # 전용면적
                               floor = item_temp[13])   # 층수 
    item[[m]] <- item_temp_dt}
    
  apt_bind <- rbindlist(item) 

  region_nm <- subset(loc, code== str_sub(url_list[i],115, 119))$addr_1
  
  month <- str_sub(url_list[i],130, 135) 
  
  path <- as.character(paste0("./02_raw_data/", region_nm, "_", month,".csv"))
  
  if(!file.exists(path)){
    write.csv(apt_bind, path)     # csv 저장
    msg <- paste0("[", i,"/",length(url_list), "] 수집한 데이터를 [", path,"]에 저장 합니다.")
  }else{
    msg <- paste0("[", i,"/",length(url_list), "] 수집한 데이터가 [", path,"]에 이미 존재 합니다.")
  }
  
  cat(msg, "\n\n")
} 

setwd(dirname(rstudioapi::getSourceEditorContext()$path)) 
files <- dir("./02_raw_data")    # 폴더 내 모든 파일 이름 읽기
library(plyr)               # install.packages("plyr")
apt_price <- ldply(as.list(paste0("./02_raw_data/", files)), read.csv) # 모든 파일 하나로 결합
tail(apt_price, 2)  # 확인

if(!dir.exists("./03_integrated")){
  dir.create("./03_integrated")   # 새로운 폴더 생성
}
save(apt_price, file = "./03_integrated/03_apt_price.rdata") # 저장
write.csv(apt_price, "./03_integrated/03_apt_price.csv")   

#---# 1) 날짜로 연속형 변수 만들기

seq(from = as.Date('1990-01-01'), # 시작시점
    to   = as.Date('2020-12-31'), # 종료시점
    by    = '1 year')             # 단위 


#---# 2) 중첩 반복문 만들기
 
for (i in 1:3) {     # 외부 반복문
  for (j in 1:3) {   # 내부 반복문
    Sys.sleep(0.1)   # 0.1초 멈춤
    print(paste(i,j,sep=","))
  }
}

#---# 3) XML 자료 저장하기

#---# 주소 가져오기
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml" 
#---# https://~ 를 http://~ 변경하고 저장
library(XML)        # install.packages("XML")   
file <- xmlTreeParse(sub("s", "", URL), useInternal = TRUE)  
#---# 저장된 xml을 데이터프리엠으로 변환
file <- xmlToDataFrame(file)  
#---# 행렬 바꾸기(matrix transpose)  
file <- as.data.frame(t(file))  
head(file)
