require 'selenium-webdriver'
require 'nokogiri'
require 'byebug'

Selenium::WebDriver::Chrome.driver_path = `which chromedriver-helper`.chomp # 설치한 크롬 드라이버 사용
options = Selenium::WebDriver::Chrome::Options.new # 크롬 헤드리스 모드 위해 옵션 설정
options.add_argument('--disable-gpu') # 크롬 헤드리스 모드 사용 위해 disable-gpu setting
options.add_argument('--headless') # 크롬 헤드리스 모드 사용 위해 headless setting
@browser = Selenium::WebDriver.for :chrome, options: options # 실레니움 + 크롬 + 헤드리스 옵션으로 브라우저 실행

insta_login_url = "https://www.instagram.com/accounts/login/"
id_input_path = '/html/body/div[1]/section/main/div/article/div/div[1]/div/form/div[2]/div/label/input'
pw_input_path = '/html/body/div[1]/section/main/div/article/div/div[1]/div/form/div[3]/div/label/input'
login_path = "/html/body/div[1]/section/main/div/article/div/div[1]/div/form/div[4]"

@browser.get insta_login_url # 로그인 페이지 가기

sleep 3


inputID = @browser.find_element(xpath: id_input_path)
inputID.send_keys "martinmsy" # 입력
inputPW = @browser.find_element(xpath: pw_input_path)
inputPW.send_keys "Blue0821!@" # 입력
login_btn = @browser.find_element(xpath: login_path)
login_btn.click

sleep 3

@browser.navigate().to "https://www.instagram.com/explore/locations/135284330516331/i-am-autumn/"

sleep 3
title = @browser.find_element(xpath: "/html/body/div[1]/section/main/article/header/div[2]/h1")

p title.text

doc = Nokogiri::HTML(@browser.page_source)
location_hash = JSON.parse doc.css("script")[-12].text.split("window._sharedData = ").last.split("\;").first
lat = location_hash["entry_data"]["LocationsPage"].first["graphql"]["location"]["lat"]
lng = location_hash["entry_data"]["LocationsPage"].first["graphql"]["location"]["lng"]
p "lat : #{lat}, lng : #{lng}"
@browser.quit