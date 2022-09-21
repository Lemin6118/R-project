# R-project

# 이민석

# 4주차 2022. 09. 22

## paste 와 paste0 차이   
빈 공백을 없애주는 작업이 포함되어 있다.
````
paste("A","B","C",seq="")  -> "ABC" 
= paste("A","B","C") -> "ABC"

````


## 크롤링 하여 파일 저장

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

## Sys.sleep(0.1) 사용하는 이유
````
-> 기존 for문에 대한 처리가 완료된 후 작업을 하기 위하여 사용   
-> 크롤링을 하며 무한히 웹에 접속하게되어 해당 서버가 해킹으로 감지할 우려를 방지
````
# 3주차 2022. 09. 14

참고 소스를 이용하여 크롤링

데이터 인코딩 변경

중첩반복문을 이용한 csv 파일 생성

# 2주차 2022. 09 .07

## 공공데이터 API XML
http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTrade

개인 인증키(encoder) 사용 및 Get 방식 조건 전달

텍스트 마이닝 워드 클라우드

install.packages("wordcloud")
library(wordcloud)

R스튜디오 인코딩 UTF-8 로 수정 (git에서 한글깨져서 수정)

# 1주차 2022. 08. 31

R언어 기초 내용






