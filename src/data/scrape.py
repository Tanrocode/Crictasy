from selenium import webdriver
from selenium.webdriver.support.ui import Select
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from datetime import date

if platform == "darwin":
  PATH = "/Users/rishit/Downloads/chromedriver"
  driver = webdriver.Chrome(executable_path=PATH)

if platform == "win32":
  PATH = "C:\Program Files (x86)\geckodriver.exe"
  driver = webdriver.Firefox(executable_path=PATH)


def get_run_data(date_cricket):
    try:
        Label=["Position","Player Name","Matches","Innings","Not Outs","Runs","Highest Score","Average","Balls Faced","Strike Rate","100's","50's","Fours","Sixes"]
        driver.get("https://www.iplt20.com/stats/2021/most-runs")
        wait = WebDriverWait(driver, 15)
        wait.until(EC.visibility_of_element_located((By.XPATH, "/html/body/main/div[2]/div/div/div[2]/div[1]/div[1]")))
        driver.find_element_by_xpath("/html/body/main/div[2]/div/div/div[2]/div[1]/div[1]").click()
        choose_data = driver.find_element_by_class_name("drop-down__dropdown-list__option")
        todays_date = date.today()
        choose_data.find_element_by_xpath(f"/html/body/main/div[2]/div/div/div[2]/div[1]/ul/li[{(todays_date.year-date_cricket)+1}]").click()

        for i in range(2,62):
            for labels in range(1,15):
                elem = driver.find_element_by_xpath(f"/html/body/main/div[2]/div/div/div[3]/table/tbody/tr[{(i)}]/td[{(labels)}]")
                if(labels==1):
                    print(f"\n{(Label[labels-1])}:{(elem.text)}")
                else:
                    print(f"{(Label[labels-1])}:{(elem.text)}")

    finally:
        driver.close()


def get_wicket_data(date_cricket):
    try:
        Label2=["Position","Player Name","Matches","Innings","Overs","Runs","Wickets","Best Bowling Innings","Average","Economy","Bowling Strike Rate","4 wickets","5 wickets"]
        driver.get("https://www.iplt20.com/stats/2021/most-wickets")
        wait = WebDriverWait(driver, 15)
        wait.until(EC.visibility_of_element_located((By.XPATH, "/html/body/main/div[2]/div/div/div[2]/div[1]/div[1]")))
        driver.find_element_by_xpath("/html/body/main/div[2]/div/div/div[2]/div[1]/div[1]").click()
        choose_data = driver.find_element_by_class_name("drop-down__dropdown-list__option")
        todays_date = date.today()
        choose_data.find_element_by_xpath(f"/html/body/main/div[2]/div/div/div[2]/div[1]/ul/li[{(todays_date.year-date_cricket)+1}]").click()

        for i in range(2,52):
            for labels2 in range(1,14):
                elem2 = driver.find_element_by_xpath(f"/html/body/main/div[2]/div/div/div[3]/table/tbody/tr[{(i)}]/td[{(labels2)}]")
                if(labels2==1):
                    print(f"\n{(Label2[labels2-1])}:{(elem2.text)}")
                else:
                    print(f"{(Label2[labels2-1])}:{(elem2.text)}")
    finally:
        driver.close()
    
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


get_player_stats("\nRavindra jadeja")


