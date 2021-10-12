from selenium import webdriver
from selenium.webdriver.support.ui import Select

PATH = "C:\Program Files (x86)\geckodriver.exe"

driver = webdriver.Firefox(executable_path=PATH)

driver.get("https://www.iplt20.com/stats/2021/most-runs")
print(driver.title)

def get_run_data(date):
    try:
        choose_data = Select(driver.find_element_by_class_name("drop-down__clickzone.js-dropdown-trigger"))
        choose_data.select_by_visible_text(str(date))
        elem = driver.find_elements_by_class_name("top-players__r  is-active")
        print(elem.text)
    finally:
        driver.close()

print(get_run_data(2021))

