from selenium import webdriver
from selenium.webdriver.support.ui import Select
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time

PATH = "C:\Program Files (x86)\geckodriver.exe"

driver = webdriver.Firefox(executable_path=PATH)

driver.get("https://www.iplt20.com/stats/2021/most-runs")
print(driver.title)

def get_run_data(date):
    try:
        wait = WebDriverWait(driver, 15)
        wait.until(EC.visibility_of_element_located((By.XPATH, "/html/body/main/div[2]/div/div/div[2]/div[1]/div[1]")))
        driver.find_element_by_xpath("/html/body/main/div[2]/div/div/div[2]/div[1]/div[1]").click()
        choose_data = driver.find_element_by_class_name("drop-down__dropdown-list__option")
        choose_data.find_element_by_xpath(f"/html/body/main/div[2]/div/div/div[2]/div[1]/ul/li[{(2021-date)+1}]").click()
        elem = driver.find_elements_by_class_name("top-players__r  is-active")
        print(elem)
    finally:
        driver.close()

print(get_run_data(2020))

