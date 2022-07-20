*** Settings ***
Documentation   Keywords for the landing page
Library         SeleniumLibrary
Library         Collections
Library         ExcelLibrary
Library         OperatingSystem
Library         ReadExcelInput.py

*** Variables ***
${i}=   Set Variable    1
${j}=   Set Variable    1
${k}=   Set Variable    1
${l}=   Set Variable    1
${m}=   Set Variable    1
${GameCategory}

*** Keywords ***
Top Sellers link should be visible on the left panel in the page
    Wait Until Element Is Visible    xpath=//h2[contains(text(),'Top Sellers')]

User is able to search Free to Play games
    #Search Games by Tag "Free to Play"
    Wait Until Element Is Visible       xpath=//input[@value='enter search term or tag']
    Input Text       xpath=//input[@value='enter search term or tag']     Free to play
    Wait Until Element Is Enabled    xpath=//button[@type='submit']//span      timeout=2    #Wait Until Search button is enabled
    Click Element    xpath=//button[@type='submit']//span       # Click the Search button
    Sleep    2s

User is able to search On Sale games
    #Search Games by Tag "Free to Play"
    Wait Until Element Is Visible       xpath=//input[@value='enter search term or tag']
    Input Text       xpath=//input[@value='enter search term or tag']     Games on sale
    Wait Until Element Is Enabled    xpath=//button[@type='submit']//span      timeout=2    #Wait Until Search button is enabled
    Click Element    xpath=//button[@type='submit']//span       # Click the Search button
    Sleep    2s

Game count and details should be captured and exported successfully

    # Check whether test case is for Free to play or On Sale
    ${GameCategory}=    Get Value       xpath=//input[@value='enter search term or tag']

    #Count the number of Games shown
    ${GamesCountFreetoPlay}=    Get Element Count     xpath=//div[@id='search_resultsRows']/a

    #Dictionary to capture game name, release date, price and category
    &{GameDetails}      Create Dictionary
    @{GamePrice}        Create List

    #Print the name, release date and the above category
    FOR    ${i}    IN RANGE    1    ${GamesCountFreetoPlay}
        ${GameName}=    Get Text    xpath=//div[@id='search_resultsRows']/a[${i}]/div[2]/div/span
        ${GameReleaseDate}=     Get Text    xpath=//div[@id='search_resultsRows']/a[${i}]/div[2]/div[2]
        #${GameReleasePrice}=    Get Text    xpath=//div[@class='responsive_search_name_combined']/div[4]/div[2]
        Set To Dictionary    ${GameDetails}      ${GameName}    ${GameReleaseDate}    #${GameReleasePrice}
    END

    #Print the price and the above category
    FOR    ${j}    IN RANGE    1    ${GamesCountFreetoPlay}
        ${GameReleasePrice}=    Get Text    xpath=//div[@id='search_resultsRows']/a[${j}]/div[2]/div[4]/div[2]
        Append To List    ${GamePrice}      ${GameReleasePrice}
    END

    #Get all the Game Names
    @{Names}=    Get Dictionary Keys    ${GameDetails}
    #Get the count of the games

    #Get all the Release Dates
    @{ReleaseDate}=     Get Dictionary Values    ${GameDetails}

    #Get the length of the games list
    ${GC}=     Get Length    ${Names}

#    FOR    ${m}    IN RANGE    1    ${GC}
#        # Write to excel document
#        Log To Console   ${GamePrice.__getitem__(${m-1})}
#    END

    List PrintElements    names

#    FOR    ${k}    IN RANGE    1    ${GC}
#        # Write to excel document
#        Write Excel Cell    ${k+1}   1   ${names.__getitem__(${k-1})}
#        # Save the excel
#        Save Excel Document    filename=GameDetails.xlsx
#    END

    IF    '${GameCategory}' == 'Free to play'
        # Open the excel document for writing into it
        Open Excel Document    filename=GameDetails.xlsx  doc_id=docid

        FOR    ${l}    IN RANGE    1    ${GC}
        # Write to excel document
        Write Excel Cell    ${l+1}   1   ${names.__getitem__(${l-1})}           Free to play
        Write Excel Cell    ${l+1}   2   ${ReleaseDate.__getitem__(${l-1})}     Free to play
        Write Excel Cell    ${l+1}   3   ${GamePrice.__getitem__(${l-1})}       Free to play
        Write Excel Cell    ${l+1}   4   Free to Play                           Free to play
        # Save the excel
        Save Excel Document    filename=GameDetails.xlsx

        END

        # Close the Excel Sheet
        Close Current Excel Document

    END

    IF    '${GameCategory}' == 'Games on sale'
        # Open the excel document for writing into it
        Open Excel Document    filename=GameDetails.xlsx  doc_id=docid

        FOR    ${l}    IN RANGE    1    ${GC}
            # Write to excel document
            Write Excel Cell    ${l+1}   1   ${names.__getitem__(${l-1})}           On Sale
            Write Excel Cell    ${l+1}   2   ${ReleaseDate.__getitem__(${l-1})}     On Sale
            Write Excel Cell    ${l+1}   3   ${GamePrice.__getitem__(${l-1})}       On Sale
            Write Excel Cell    ${l+1}   4   Games on sale                          On Sale
            # Save the excel
            Save Excel Document    filename=GameDetails.xlsx

        END

        # Close the Excel Sheet
        Close Current Excel Document

    END
