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
from iplrundata import get_run_data
from iplwicketdata import get_wicket_data
cred = credentials.Certificate('/Users/rishit/Downloads/crictasy-5a73d-firebase-adminsdk-djecp-5f396548db (1) 11.06.03 PM.json')
firebase_admin.initialize_app(cred)
db = firestore.client()
doc_ref = db.collection(u'players').document('players')
doc=doc_ref.get()
doc=doc.to_dict()
data=get_wicket_data(2021)
data1=get_run_data(2021)
for i in range(1,61):
    doc_ref.set({
        data1[str(i)]["Player Name"]: 1,
        
    },merge=True)
for j in range(1,51):
    try:
        validation=doc[data[str(j)]["Player Name"]]
    except:
        doc_ref.set({
            data[str(j)]["Player Name"]: 1
        
         },merge=True)
   
        
    
    