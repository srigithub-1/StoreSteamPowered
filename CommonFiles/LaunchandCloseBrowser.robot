*** Settings ***
Documentation   This is for opening and closing browser
Library         SeleniumLibrary

*** Variables ***
${BROWSER}      chrome
${URL}          https://store.steampowered.com/

*** Keywords ***
Begin Web Test
    Open Browser    ${URL}      ${BROWSER}
    #Set Window Size    1920    1024
    Maximize Browser Window
    Sleep    5s

End Web Test
    Close Browser

