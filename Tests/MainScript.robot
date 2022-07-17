*** Settings ***
Documentation   This is a demo site
Test Setup      Begin Web Test
Test Teardown   End Web Test
Resource        ../CommonFiles/LaunchandCloseBrowser.robot
Resource        ../Keywords/HomePage.robot
Resource        ../Keywords/TopSellers.robot

*** Variables ***
@{gamenames}
${i}=    Set Variable    1
${j}=    Set Variable    1
${TotalNumberofGames}
${GameName}

*** Test Cases ***

TC01_Free to Play Games
    When I Open the Home Page and the page is displayed successfully
    Then Top Sellers link should be visible on the left panel in the page
    And User is able to search Free to Play games
    Then Game count and details should be captured and exported successfully

TC02_On Sale Games
    When I Open the Home Page and the page is displayed successfully
    Then Top Sellers link should be visible on the left panel in the page
    And User is able to search On Sale games
    Then Game count and details should be captured and exported successfully




