# R-project

# 이민석

# 8주차 2022. 10. 26

### 주소와 좌표 결합하기 
  
````
 # [1단계: 데이터 불러오기]
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
load("./04_preprocess/04_preprocess.rdata")    # 주소 불러오기
load("./05_geocoding/05_juso_geocoding.rdata") # 좌표 불러오기

 # [2단계: 주소 + 좌표 결합]
library(dplyr)   # install.packages('dplyr')
apt_price <- left_join(apt_price, juso_geocoding, 
                       by = c("juso_jibun" = "apt_juso")) # 결합
apt_price <- na.omit(apt_price)   # 결측치 제거
````


# 7주차 2022. 10. 19
### 중간고사

# 6주차 2022. 10. 12
###  전처리 데이터 저장
- 2가지 단계를 시행필요
````
1. 컬럼 추출

apt_price <- apt_price %>% select(ymd, ym, year, code, addr_1, apt_nm,
                                  juso_jibun, price, con_year, area, floor, py, cnt)  # 컬럼 추출
head(apt_price, 2)  # 자료 확인

- select() 함수는 데이터에서 필요한 변수만 추출하고 싶을 때 사용한다.

2. 전처리 데이터 저장

setwd(dirname(rstudioapi::getSourceEditorContext()$path))
dir.create("./04_pre_process")  # 새로운 폴더 생성
save(apt_price, file = "./04_pre_process/04_pre_process.rdata")  # 저장
write.csv(apt_price, "./04_pre_process/04_pre_process.csv")
````

````
카카오 로컬 API 키
- 카카오 개발자 사이트
  → https://developers.kakao.com
````
# 6주차 2022. 10. 06

자료 수집을 위한 크롤러 제작 단계 : 1단계에 -> 5단계

### 자료 요청 후 응답
````
for (i in 1:length(url_list)) {  # 요청 목록(url_list) 반복
  raw_data[[i]] <- xmlTreeParse(url_list[i], useInternalNodes = TRUE,
                                encoding = "utf-8")  # 결과 저장
  root_Node[[i]] <- xmlRoot(raw_data[[i]])  # URL로 저장 후 XML로 파일을 추출
````

추출 데이터 확인 -> 응답 내역 저장 -> 자료 통합


# 5주차 2022. 09. 28

컴파일 시 이미 실행된 행동(폴더생성, 데이터 생성)에 대한 처리 추가

if(!file.exists(path))   
if(!dir.exists(path))

크롤링 문제 발생   
트래픽 횟수 1000번 제한으로 1번 접속 시 마다 횟수 차감 (컴파일 시 300회 차감)   
25회로 조정 필요 

# 4주차 2022. 09. 22

### paste 와 paste0 차이   
빈 공백을 없애주는 작업이 포함되어 있다.
````
paste("A","B","C",seq="")  -> "ABC" 
= paste("A","B","C") -> "ABC"

````


### 크롤링 하여 파일 저장

"?" 로 조건절을 만든 후 각 조건에 해당하는 파라미터 삽입 후 url_list[]에 값을 넣어준다.
````
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
````

### Sys.sleep(0.1) 사용하는 이유
````
-> 기존 for문에 대한 처리가 완료된 후 작업을 하기 위하여 사용   
-> 크롤링을 하며 무한히 웹에 접속하게되어 해당 서버가 해킹으로 감지할 우려를 방지
````
# 3주차 2022. 09. 14

참고 소스를 이용하여 크롤링

데이터 인코딩 변경

중첩반복문을 이용한 csv 파일 생성

# 2주차 2022. 09 .07

### 공공데이터 API XML
http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTrade

개인 인증키(encoder) 사용 및 Get 방식 조건 전달

텍스트 마이닝 워드 클라우드

install.packages("wordcloud")
library(wordcloud)

R스튜디오 인코딩 UTF-8 로 수정 (git에서 한글깨져서 수정)

# 1주차 2022. 08. 31

R언어 기초 내용






