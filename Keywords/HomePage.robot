*** Settings ***
Documentation   Keywords for the landing page
Library         SeleniumLibrary

*** Keywords ***
I Open the Home Page and the page is displayed successfully
    Wait Until Page Contains Element    xpath=//div[@class='gutter_items']//a[contains(@href,'topsellers')]     timeout=10
    # Wait Until Page Contains Element    css=div.gutter_items[href^='topsellers']
    # Click Element       css=div.gutter_items[href^='topsellers']  #.a[href^='topsellers']
    Click Element    xpath=//div[@class='gutter_items']//a[contains(@href,'topsellers')]
