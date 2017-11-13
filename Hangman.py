import urllib.request
import bs4
from selenium.webdriver.support.ui import Select
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

options = webdriver.ChromeOptions()
#options.add_argument("--headless")

categories = []

url = 'https://www.thegamegal.com/word-generator/'
driver = webdriver.Chrome(chrome_options=options)
driver.get(url)
select = Select(driver.find_element_by_id('game'))
select.select_by_value('1')
cat = driver.find_element_by_id('category')
for option in cat.find_elements_by_tag_name('option'):
    categories.append(option.text)
print(categories)
driver.find_element_by_xpath('//*[@id="newword-button"]').click()

#element2 = driver.find_element_by_css_selector("css=div[id='gennedword-container']")
#print(element2.find_element_by_css_selector("p[@class='text-center']").text)

#word_a = driver.find_element_by_id('gennedword-container')
#word_a = driver.find_element_by_xpath('//*[@id="gennedword-container"]')
word = driver.find_element_by_xpath('//*[@id="gennedword"]')
#word = driver.find_element_by_class_name('text-center')
#for i in word:
#    print(i.text)
#print(word.tag_name)
#print(word.get_attribute('text'))
print(word.get_attribute('innerHTML'))
#//*[@id="newword-button"] //*[@id="gennedword"]
#driver.close()
