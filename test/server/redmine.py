# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re

class Redmine(unittest.TestCase):
    base_url = "http://10.200.3.9:3000/"
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
        #self.base_url = "http://10.200.3.58:3000/"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_redmine(self):
        driver = self.driver
        driver.get(self.base_url)
        driver.find_element_by_link_text("Sign in").click()
        driver.find_element_by_id("username").clear()
        driver.find_element_by_id("username").send_keys("admin")
        driver.find_element_by_id("password").clear()
        driver.find_element_by_id("password").send_keys("admin")
        driver.find_element_by_name("login").click()
        driver.find_element_by_link_text("Home").click()
        driver.find_element_by_link_text("My page").click()
        driver.find_element_by_link_text("Projects").click()
        driver.find_element_by_link_text("Administration").click()
        driver.find_element_by_link_text("Help").click()
    
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

    # def run_test():
    #     unittest.main()

def run_test(class_test):
    suite = unittest.TestLoader().loadTestsFromTestCase(class_test)
    return unittest.TextTestRunner(verbosity=2).run(suite)

if __name__ == "__main__":
    unittest.main()
