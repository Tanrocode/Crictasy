from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from datetime import date
from sys import platform
import json
import secrets
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

if platform == "darwin":
  PATH = "/Users/rishit/Downloads/chromedriver"
  cred = credentials.Certificate('/Users/rishit/Downloads/crictasy-5a73d-firebase-adminsdk-djecp-5f396548db (1) 11.06.03 PM.json')
  driver = webdriver.Chrome(executable_path=PATH)

if platform == "win32":
  PATH = "C:\Program Files (x86)\geckodriver.exe"
  cred = credentials.Certificate('C:/Users/herot/Documents/crictasy-5a73d-firebase-adminsdk-djecp-7024b5c721.json')
  driver = webdriver.Firefox(executable_path=PATH)

#firebase_admin.initialize_app(cred)
#db = firestore.client()

def get_wicket_data(date_cricket):
        Dict={}
        Player_dict={}
        Label=["Position","Player Name","Matches","Innings","Not Outs","Runs","Highest Score","Average","Balls Faced","Strike Rate","100's","50's","Fours","Sixes"]
        driver.get(f"https://www.iplt20.com/stats/{date_cricket}/mostWkts?stats_type=bowling")
        wait = WebDriverWait(driver, 15)
        element = driver.find_element_by_xpath('/html/body/main/section/div/div/div[2]/div[3]/div[2]/div[2]/div/a')
        driver.execute_script("arguments[0].click();", element)
        
        for i in range(2,52):
            for labels in range(1,14):
                elem = driver.find_element_by_xpath(f"/html/body/main/section/div/div/div[2]/div[3]/div[2]/div[2]/table/tbody/tr[{(i)}]/td[{(labels)}]")
                Player_dict[f"{(Label[labels-1])}"]=elem.text
                ID_header = driver.find_element_by_xpath(f"/html/body/main/section/div/div/div[2]/div[3]/div[2]/div[2]/table/tbody/tr[{(i)}]/td[2]")
                ID=ID_header.text
                Dict[f"{(i-1)}"]=Player_dict
            Player_dict={}
            
        return Dict

#x = 2021 # current year

#data = get_wicket_data(x)
#doc_ref = db.collection(u'wicketdata').document(u'{}'.format(x))
#doc_ref.delete()
#doc_ref.set({
  #'WICKET DATA': data
#})

