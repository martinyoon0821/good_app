require 'selenium-webdriver'
require 'byebug'

Selenium::WebDriver::Chrome.driver_path = `which chromedriver-helper`.chomp # 설치한 크롬 드라이버 사용
options = Selenium::WebDriver::Chrome::Options.new # 크롬 헤드리스 모드 위해 옵션 설정
options.add_argument('--disable-gpu') # 크롬 헤드리스 모드 사용 위해 disable-gpu setting
options.add_argument('--headless') # 크롬 헤드리스 모드 사용 위해 headless setting
@browser = Selenium::WebDriver.for :chrome, options: options # 실레니움 + 크롬 + 헤드리스 옵션으로 브라우저 실행

# print "키워드를 입력해주세요 : "
# keyword = gets.chomp

# instagram_url = "https://www.instagram.com/explore/tags/#{keyword}"
instagram_url = "https://www.instagram.com/explore/tags/%ED%99%8D%EB%8C%80%EC%B9%B4%ED%8E%98/"

@browser.get instagram_url

sleep 5

# tops_ary = []

# tops_xpath = "/html/body/span/section/main/article/div[1]/div/div/div[1]/div"
# tops = @browser.find_elements(xpath: tops_xpath)
# tops_ary = tops_ary + tops

# tops_2_xpath = "/html/body/span/section/main/article/div[1]/div/div/div[2]/div"
# tops_2 = @browser.find_elements(xpath: tops_2_xpath)
# tops_ary = tops_ary + tops_2

# tops_3_xpath = "/html/body/span/section/main/article/div[1]/div/div/div[3]/div"
# tops_3 = @browser.find_elements(xpath: tops_3_xpath)
# tops_ary = tops_ary + tops_3

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
        # p location.text
        # p location.attribute("href")
        # p "------------------------------"
        
        next_btn.click
    rescue
        p i
        next_btn.click
        next
    end
end

p location_arr
@browser.quit
# tops.click

# sleep 0.2
#     title = item.find_element(class: "O4GlU").text
#     addr = item.find_element(class: "O4GlU").attribute("href").text
#     puts "#{title} , #{addr}"
    


# @browser.quit