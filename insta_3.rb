require 'selenium-webdriver'
require 'byebug'
require 'nokogiri'

Selenium::WebDriver::Chrome.driver_path = `which chromedriver-helper`.chomp # 설치한 크롬 드라이버 사용
options = Selenium::WebDriver::Chrome::Options.new # 크롬 헤드리스 모드 위해 옵션 설정
options.add_argument('--disable-gpu') # 크롬 헤드리스 모드 사용 위해 disable-gpu setting
options.add_argument('--headless') # 크롬 헤드리스 모드 사용 위해 headless setting
@browser = Selenium::WebDriver.for :chrome, options: options # 실레니움 + 크롬 + 헤드리스 옵션으로 브라우저 실행

# print "키워드를 입력해주세요 : "
# keyword = gets.chomp

# instagram_url = "https://www.instagram.com/explore/tags/#{keyword}"

insta_login_url = "https://www.instagram.com/accounts/login/"
id_input_path = '/html/body/div[1]/section/main/div/article/div/div[1]/div/form/div[2]/div/label/input'
pw_input_path = '/html/body/div[1]/section/main/div/article/div/div[1]/div/form/div[3]/div/label/input'
login_path = "/html/body/div[1]/section/main/div/article/div/div[1]/div/form/div[4]"
instagram_url = "https://www.instagram.com/explore/tags/%ED%99%8D%EB%8C%80%EC%B9%B4%ED%8E%98/"



@browser.get instagram_url

sleep 5

top_xpath = "/html/body/div[1]/section/main/article/div[1]/div/div/div[1]/div[1]/a"
top = @browser.find_element(xpath: top_xpath)

top.click

location_arr = []

8.times do |i|
    begin
        sleep 1
        if i == 0 
            next_btn = @browser.find_element(xpath: "/html/body/div[5]/div[1]/div/div/a")
        else
            next_btn = @browser.find_element(xpath: "/html/body/div[5]/div[1]/div/div/a[2]")
        end
        location = @browser.find_element(xpath: "/html/body/div[5]/div[2]/div/article/header/div[2]/div[2]/div[2]/a")
        
        location_info = Hash.new
        location_info[:text] = location.text
        location_info[:href] = location.attribute("href")
        location_arr.push(location_info)
        next_btn.click
    rescue
        p i
        next_btn.click
        next
    end
end

sleep 5

@browser.get insta_login_url # 로그인 페이지 가기

sleep 3

inputID = @browser.find_element(xpath: id_input_path)
inputID.send_keys "martinmsy" # 입력
inputPW = @browser.find_element(xpath: pw_input_path)
inputPW.send_keys "Blue0821!@" # 입력
login_btn = @browser.find_element(xpath: login_path)
login_btn.click

sleep 3

result = []
p "좌표"
location_arr.each do |l|
    p l[:href]
    @browser.navigate().to l[:href]
    
    sleep 3
    
    title = @browser.find_element(xpath: "/html/body/div[1]/section/main/article/header/div[2]/h1")
    result_info = Hash.new
    result_info[:text] = title.text
    
    doc = Nokogiri::HTML(@browser.page_source)
    location_hash = JSON.parse doc.css("script")[-12].text.split("window._sharedData = ").last.split("\;").first
    lat = location_hash["entry_data"]["LocationsPage"].first["graphql"]["location"]["lat"]
    lng = location_hash["entry_data"]["LocationsPage"].first["graphql"]["location"]["lng"]
    result_info[:lat] = lat
    result_info[:lng] = lng
    result.push(result_info)
    rescue
        p "rescue"
        next
end
p "end"
p result
@browser.quit
# tops.click

# sleep 0.2
#     title = item.find_element(class: "O4GlU").text
#     addr = item.find_element(class: "O4GlU").attribute("href").text
#     puts "#{title} , #{addr}"
    


# @browser.quit