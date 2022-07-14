*** Settings ***
Documentation   This is for opening and closing browser
Library         SeleniumLibrary

*** Variables ***
${BROWSER}      chrome
${URL}          https://store.steampowered.com/

*** Keywords ***
Begin Web Test
    Open Browser    ${URL}      ${BROWSER}
    Maximize Browser Window
    Sleep    2s

End Web Test
    Close Browser

