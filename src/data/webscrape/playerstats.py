from selenium import webdriver
from sys import platform
from pymongo import MongoClient

client = MongoClient()

if platform == "darwin":
  PATH = "/Users/rishit/Downloads/chromedriver"
  driver = webdriver.Chrome(executable_path=PATH)

if platform == "win32":
  PATH = "C:\Program Files (x86)\geckodriver.exe"
  driver = webdriver.Firefox(executable_path=PATH)

def get_player_stats(Name):
    try:
        NewName=""
        for i in range(0,len(Name)):
            if((Name[i])!=" "):
                NewName=NewName+Name[i]
            else:
                NewName=NewName+"-"
        print(Name)

        driver.get(f"https://www.espncricinfo.com/ask/cricket-qna/{(NewName)}-IPL&tournament=allt20")

        for rows in range(1,5):
            for value in range(1,4):
                Stats=driver.find_element_by_xpath(f"/html/body/div/div/div[2]/div[2]/div/div/div/div/div[1]/main/div[1]/section/div[1]/div[2]/div[1]/div[{(rows)}]/div[{(value)}]/div")
                print(Stats.text)
        
    finally:
        driver.close()

input_name = input(str("Input Player Name"))
get_player_stats(input_name)