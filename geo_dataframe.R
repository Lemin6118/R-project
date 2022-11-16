#==============================================================================================
#  6-1: 좌표계와 지오 데이터 포맷
#==============================================================================================

# 좌표계(CRS): 평면 지도 좌표를 타원 구의 좌표으로 변환하기 위한 보정의 기준.
# EPSG: 좌표계를 표준화하고자 부여한 코드.
# 국내: 국토지리정보원의 GRS80 / EPSG:5186
# 글로벌: WGS84 / EPSG:4326

# R의 데이터프레임은 학 특성의 위치 정보를 저장하기에 적합하지 않은 표맷이기 때문에 공간 분석에 한계가 있음.
# 이를 개선하고자 2005년 sp package 발표.
# sp는 R에서 점, 선, 면 같은 공간 정보를 처리할 목적으로 만든 데이터 포맷.
# 그러나 sp의 경우 속도는 빠르나, 데이터 일부를 편집하거나 수정하는이 어렵다는 단점을 갖고있다.
# 여기서 편집기능을 보완한 패키지가 sf package이다.
# 하지만 sf의 경우 sp의 속도를 따라갈 수 없기때문에 일반적으로 sp와 sf를 함께 사용한다.



#==============================================================================================
#  6-2: 주소와 좌표 결합하기
#==============================================================================================


# 1단계: 데이터 불러오기

setwd(dirname(rstudioapi::getSourceEditorContext()$path))
load("./04_preprocess/04_preprocess.rdata")    # 주소 불러오기
load("./05_geocoding/05_juso_geocoding.rdata") # 좌표 불러오기


# 2단계: 주소 + 좌표 결합

# install.packages('dplyr')
library(dplyr)
apt_price <- left_join(apt_price, juso_geocoding, 
                       by = c("juso_jibun" = "apt_juso")) # 결합
apt_price <- na.omit(apt_price)   # NA 제거



#==============================================================================================
#  6-3: 지오 데이터프레임 만들기
#==============================================================================================


# 1단계: 지오데이터프레임 생성

# install.packages('sp')
# install.packages('sf')

library(sp)
coordinates(apt_price) <- ~coord_x + coord_y    # 좌표값 할당
proj4string(apt_price) <- "+proj=longlat +datum=WGS84 +no_defs" # 좌표계(CRS) 정의
library(sf)
apt_price <- st_as_sf(apt_price)     # sp형 => sf형 변환


# 2단계: 지오데이터프레임 시각화

# install.packages('leaflet')

plot(apt_price$geometry, axes = T, pch = 1)   # 플롯 그리기 
library(leaflet)   # 지도 그리기
leaflet() %>% 
  addTiles() %>% 
  addCircleMarkers(data=apt_price[1:1000,], label=~apt_nm) # 일부분(1000개)만 그리기


# 3단계: 지오 데이터프레임 저장

dir.create("06_geodataframe")   # 새로운 폴더 생성
save(apt_price, file="./06_geodataframe/06_apt_price.rdata") # rdata 저장
write.csv(apt_price, "./06_geodataframe/06_apt_price.csv")   # csv 저장
