*** Settings ***
Documentation     This is a resource file, that can contain variables and keywords.
...               Keywords defined here can be used where this Keywords.resource in loaded.

*** Keywords ***
Common Suite Setup
    log     Common Suite Setup
    Log     ${SUITE NAME}
    @{suiteList}=               Split String
    ...     ${SUITE NAME}
    ...     .
    Log     ${suiteList}
    ${CURRENT_SUITE_NAME}=      Evaluate
    ...     "${suiteList[-1].strip().lower().replace(" ", "_")}"

    Set Suite Variable
    ...     ${CURRENT_SUITE_NAME}
    ...     ${CURRENT_SUITE_NAME}

    #========================================
    # import necessary resources - Import screen design
    #========================================
    Log     ===================== Import screen design =====================
    @{screen_design_files}=     OperatingSystem.List Files In Directory
    ...     ${project_setting_location}design${/}pages${/}
    ...     ${test_target_sub_system}.*.resource
    Log     ${screen_design_files}
    FOR     ${screen_design_file}       IN      @{screen_design_files}
        Import Resource
        ...     ${project_setting_location}design${/}pages${/}${screen_design_file}
    END

    #========================================
    # ./import necessary resources - Import data test
    #========================================
    Log     ===================== Import testdata =====================
#    @{data_test_files}=     OperatingSystem.List Files In Directory
#    ...     ${project_setting_location}testdata${/}${test_target_sub_system}${/}
#    ...     *.resource
#
#    Log     ${data_test_files}
#
#    FOR     ${data_test_file}       IN      @{data_test_files}
#        Import Resource
#        ...     ${project_setting_location}testdata${/}${test_target_sub_system}${/}${data_test_file}
#    END
    Log     ${project_setting_location}testdata${/}${test_target_sub_system}${/}${CURRENT_SUITE_NAME}.testdata.resource

    ${is_exist}   ${rc}=      Run Keyword And Ignore Error
    ...     OperatingSystem.File Should Exist
    ...         ${project_setting_location}testdata${/}${test_target_sub_system}${/}${CURRENT_SUITE_NAME}.testdata.resource
    Run Keyword If      '${is_exist}'=='PASS'
    ...     Import Resource
    ...         ${project_setting_location}testdata${/}${test_target_sub_system}${/}${CURRENT_SUITE_NAME}.testdata.resource

Open Url
    [Documentation]     Normal wait until the keyword succeeds.
    [Arguments]         ${url}
    Log     ${BROWSER}
    Log     ${url}
    Open Browser
    ...     ${url}
    ...     ${BROWSER}

Split String By 4k Character
    [Arguments]    ${content}
    @{content_list}=       Create List
    FOR    ${i}    IN RANGE    999999
        Log     ${content}
        ${content_length}=      Get Length      ${content}
        Log     ${content_length}
        ${is_last_content}=     Evaluate        ${content_length} < 4000

        IF      '${is_last_content}'=='${False}'
            ${content_4k}=  Get Substring
            ...     ${content}
            ...     0
            ...     4000
            Log     ${content_4k}

            Run keyword and ignore error
            ...     Should Contain
            ...     ${content_4k}
            ...     \n

            Run keyword and ignore error
            ...     Should Contain
            ...     ${content_4k}
            ...     \r\n

            Run keyword and ignore error
            ...     Should Contain
            ...     ${content_4k}
            ...     ${\n}

            ${content_4k_2}=  Fetch from Right      ${content_4k}       \n
            Log     ${content_4k_2}
            ${content_4k}=  Fetch from Left       ${content_4k}       ${content_4k_2}
        ELSE
            ${content_4k}=      Catenate        ${content}
        END

        Append To List      ${content_list}      ${content_4k}

        Exit For Loop If    ${is_last_content}
        Log     ${content}
        Log     ${content_4k}
        Log     ${content_4k_2}

        ${content}=     Fetch from Right
        ...     ${content}
        ...     ${content_4k}
        Log     ${content}

    END

    Log    ${content_list}

    [Return]    @{content_list}

Wait Element Available
    [Arguments]    ${element}

    wait until keyword succeeds
    ...     1800s
    ...     30s
    ...     Page Should Contain Element
    ...         ${element}

Delete ADS Element

    sleep   2s
    Run Keyword And Ignore Error
    ...     execute javascript
    ...         var element1=document.querySelector('#ads-chapter-google-top');
    ...         element1.parentNode.removeChild(element1);
    Run Keyword And Ignore Error
    ...     execute javascript
    ...         var element2=document.querySelector('#ads-chapter-top');
    ...         element2.parentNode.removeChild(element2);
    Run Keyword And Ignore Error
    ...     execute javascript
    ...         var element3=document.querySelector('#ads-chapter-longtop');
    ...         element3.parentNode.removeChild(element3);
    Run Keyword And Ignore Error
    ...     execute javascript
    ...         var element4=document.querySelector('#ads-chapter-nettruyenfull');
    ...         element4.parentNode.removeChild(element4);
    Run Keyword And Ignore Error
    ...     execute javascript
    ...         var element5=document.querySelector('.ads-mobile');
    ...         element5.parentNode.removeChild(element5);
    Run Keyword And Ignore Error
    ...     execute javascript
    ...         var element6=document.querySelector('.ads-network');
    ...         element6.parentNode.removeChild(element6);
    Run Keyword And Ignore Error
    ...     execute javascript
    ...         var element7=document.querySelector('.ads-desktop');
    ...         element7.parentNode.removeChild(element7);
    Run Keyword And Ignore Error
    ...     execute javascript
    ...         var element8=document.querySelector('.ads-responsive');
    ...         element8.parentNode.removeChild(element8);
    Run Keyword And Ignore Error
    ...     execute javascript
    ...         var element9=document.querySelector('.ads-mobile');
    ...         element9.parentNode.removeChild(element9);
