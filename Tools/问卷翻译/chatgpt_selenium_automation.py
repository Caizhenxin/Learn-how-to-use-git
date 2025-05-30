import os
import socket
import threading
import time
import random
import pyperclip

from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.action_chains import ActionChains

class ChatGPTAutomation:

    def __init__(self, chrome_path):
        """
        This constructor automates the following steps:
        1. Open a Chrome browser with remote debugging enabled at a specified URL.
        2. Prompt the user to complete the log-in/registration/human verification, if required.
        3. Connect a Selenium WebDriver to the browser instance after human verification is completed.

        :param chrome_path: file path to chrome.exe
        """

        self.chrome_path = chrome_path

        url = r"https://chat.openai.com"
        print('find available port...')
        free_port = self.find_available_port()
        print('launch chrome with remote debugging...')
        self.launch_chrome_with_remote_debugging(free_port, url)
        print('setup webdriver...')
        self.driver = self.setup_webdriver(free_port)
        print('setupped.')
        
        self.cookie = self.get_cookie()
        self.wait_for_login()
        self.is_running = True

    @staticmethod
    def find_available_port():
        """ This function finds and returns an available port number on the local machine by creating a temporary
            socket, binding it to an ephemeral port, and then closing the socket. """

        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.bind(('', 0))
            s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            return s.getsockname()[1]

    def launch_chrome_with_remote_debugging(self, port, url):
        """ Launches a new Chrome instance with remote debugging enabled on the specified port and navigates to the
            provided url """

        def open_chrome():
            chrome_cmd = f"{self.chrome_path} --remote-debugging-port={port} --user-data-dir=remote-profile {url}"
            os.system(chrome_cmd)

        chrome_thread = threading.Thread(target=open_chrome)
        chrome_thread.start()

    def setup_webdriver(self, port):
        """  Initializes a Selenium WebDriver instance, connected to an existing Chrome browser
             with remote debugging enabled on the specified port"""

        service = Service()
        chrome_options = webdriver.ChromeOptions()

        # options.binary_location = 'D:/Coding/websites/OpenTransfer/chrome-win64/chrome.exe'
        chrome_options.add_experimental_option("debuggerAddress", f"127.0.0.1:{port}")
        driver = webdriver.Chrome(service=service, options=chrome_options)
        return driver

    def get_cookie(self):
        """
        Get chat.openai.com cookie from the running chrome instance.
        """
        cookies = self.driver.get_cookies()
        cookie = [elem for elem in cookies if elem["name"] == '__Secure-next-auth.session-token'][0]['value']
        return cookie

    def new_chat(self):
        # 按下 Ctrl + Shift + C 组合键
        actions = ActionChains(self.driver)
        actions.key_down(Keys.CONTROL).key_down(Keys.SHIFT).send_keys('o').key_up(Keys.SHIFT).key_up(Keys.CONTROL).perform()

    def send_prompt_to_chatgpt(self, prompt):
        """ Sends a message to ChatGPT and waits for 20 seconds for the response """
        time.sleep(0.5 + random.random())
        input_box = self.driver.find_element(by=By.XPATH, value='//textarea[contains(@id, "prompt-textarea")]')
        prompt = prompt.replace('`','\\`')
        time.sleep(0.5 + random.random())
        self.driver.execute_script(f"arguments[0].value = `{prompt}`;", input_box)
        time.sleep(0.3 + random.random())
        # actions = ActionChains(self.driver)
        # actions.key_down(Keys.CONTROL).send_keys(Keys.RETURN).key_up(Keys.CONTROL).perform()
        input_box.send_keys(Keys.RETURN)
        time.sleep(0.3)
        input_box.submit()

        self.check_response_ended()

    def check_response_ended(self):
        try:
            """ Checks if ChatGPT response ended """
            start_time = time.time()
            time.sleep(4)
            while len(self.driver.find_elements(By.CSS_SELECTOR, "button[data-testid='stop-button']")) > 0:
                time.sleep(1)
                # Exit the while loop after 200 seconds anyway
                if time.time() - start_time > 200:
                    break
            time.sleep(1)  # the length should be =4, so it's better to wait a moment to be sure it's really finished
        except:
            self.driver.close()
            self.driver.quit()
            self.is_running = False

    def return_chatgpt_conversation(self):
        """
        :return: returns a list of items, even items are the submitted questions (prompts) and odd items are chatgpt response
        """

        return self.driver.find_elements(by=By.CSS_SELECTOR, value='div.text-base')

    def save_conversation(self, file_name):
        """
        It saves the full chatgpt conversation of the tab open in chrome into a text file, with the following format:
            prompt: ...
            response: ...
            delimiter
            prompt: ...
            response: ...

        :param file_name: name of the file where you want to save
        """

        directory_name = "conversations"
        if not os.path.exists(directory_name):
            os.makedirs(directory_name)

        delimiter = "|^_^|"
        chatgpt_conversation = self.return_chatgpt_conversation()
        with open(os.path.join(directory_name, file_name), "a") as file:
            for i in range(0, len(chatgpt_conversation), 2):
                file.write(
                    f"prompt: {chatgpt_conversation[i].text}\nresponse: {chatgpt_conversation[i + 1].text}\n\n{delimiter}\n\n")

    def return_last_response(self):
        """ :return: the text of the last chatgpt response """
        response_elements = self.driver.find_elements(by=By.CSS_SELECTOR, value='div.text-base')
        return response_elements[-1].text

    def return_last_response_md(self):
        response = ''
        for _ in range(10):
            # 按下 Ctrl + Shift + C 组合键
            actions = ActionChains(self.driver)
            actions.key_down(Keys.CONTROL).key_down(Keys.SHIFT).send_keys('c').key_up(Keys.SHIFT).key_up(Keys.CONTROL).perform()
            response = pyperclip.paste()
            if response != '':
                break
            else:
                time.sleep(1000)
        
        return response

    def wait_for_login(self):
        while True:
            try:
                input_box = self.driver.find_element(by=By.XPATH, value='//textarea[contains(@id, "prompt-textarea")]')
                break
            except:
                print("Waiting for login...")
                time.sleep(5)  # You can adjust the waiting time as needed

    def quit(self):
        """ Closes the browser and terminates the WebDriver session."""
        print("Closing the browser...")
        self.driver.close()
        self.driver.quit()
        self.is_running = False

    def is_driver_quitted(self):
        try:
            self.driver.find_element(by=By.XPATH, value='//textarea[contains(@id, "prompt-textarea")]')
            self.is_running = True
            return False
        except:
            self.is_running = False
            return True
