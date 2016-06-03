# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re

class Alfresco(unittest.TestCase):
    base_url = "http://10.200.2.120:8080"
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
#        self.base_url = "http://10.200.2.120:8080/alfresco"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_alfresco(self):
        driver = self.driver
        driver.get(self.base_url + "/alfresco/faces/jsp/dashboards/container.jsp")
        driver.find_element_by_id("login").click()
        driver.find_element_by_id("loginForm:user-name").click()
        driver.find_element_by_id("loginForm:user-name").clear()
        driver.find_element_by_id("loginForm:user-name").send_keys("admin")
        driver.find_element_by_id("loginForm:user-password").clear()
        driver.find_element_by_id("loginForm:user-password").send_keys("adminpwd")
        driver.find_element_by_id("loginForm:submit").click()
    
    def is_element_present(self, how, what):
        try: self.driver.find_element(by=how, value=what)
        except NoSuchElementException as e: return False
        return True
    
    def is_alert_present(self):
        try: self.driver.switch_to_alert()
        except NoAlertPresentException as e: return False
        return True
    
    def close_alert_and_get_its_text(self):
        try:
            alert = self.driver.switch_to_alert()
            alert_text = alert.text
            if self.accept_next_alert:
                alert.accept()
            else:
                alert.dismiss()
            return alert_text
        finally: self.accept_next_alert = True
    
    def tearDown(self):
        self.driver.quit()
        self.assertEqual([], self.verificationErrors)

def run_test(class_test):
    suite = unittest.TestLoader().loadTestsFromTestCase(class_test)
    return unittest.TextTestRunner(verbosity=2).run(suite)

if __name__ == "__main__":
    unittest.main()
