function countImpression()
    m.top.findNode("colorTvAdEvents").adShown = true
end function

function exitView()
    m.top.findNode("colorTvAdEvents").closeAd = true
end function

function performEngagement()
    if m.top.dataModel.ads[0].type = "appstore" or m.top.dataModel.ads[0].type = "content" or m.top.dataModel.ads[0].actionButton.actionType = "CLICK_TO_APPSTORE" or m.top.dataModel.ads[0].actionButton.actionType = "CLICK_TO_CONTENT" then
        m.top.findNode("colorTvAppstoreEvents").clicked = true
    else
        showEngagementForm()
    end if
end function

function showEngagementForm()    
    m.engagementFormShown = true
    m.actionbutton.focused = false
    m.subscriptionForm = createObject("RoSGNode","colortv_subscriptionWindow")
    m.subscriptionForm.id = "subscriptionWindow"
    m.subscriptionForm.parentNodeReference = m.top
    m.subscriptionForm.clickedModel = m.top.dataModel.ads[0]
    m.top.appendChild(m.subscriptionForm)
    m.subscriptionForm.setFocus(true)
end function

function hideEngagementForm()
    m.engagementFormShown = false
    m.top.removeChild(m.subscriptionForm)
    m.top.SetFocus(true)
    m.subscriptionForm.removeChildrenIndex(m.subscriptionForm.getChildCount(), 0)
    m.subscriptionForm = invalid
    m.actionbutton.focused = true
end function

function startAutoCloseTimer()
    if m.autoCloseTimer <> invalid then
        if m.top.dataModel.autoCloseVisible = "false" then
            m.autoCloseTimer.visible = false
        else
            m.autoCloseTimer.visible = true
        end if
    m.autoCloseTimer.startTimer = true
    end if
end function

function cancelAutoCloseTimer()
    if m.autoCloseTimer <> invalid then
        if m.autoCloseTimer.startTimer then
            m.autoCloseTimer.visible = false
            m.autoCloseTimer.startTimer = false
        end if
    end if
end function

function isEmailOrPhoneAction(actionButton) as Boolean
    return actionButton.actionType = "CLICK_TO_EMAIL" or actionButton.actionType = "CLICK_TO_CALL" or actionButton.actionType = "CLICK_TO_SMS"
end function

' These 2 methods can be removed if we find a BrightScript equivalent of printf / String.format(), which any sane language should have

function IntToZeroPaddedHexString(decimalNumber as Integer) as String 
    if decimalNumber < 0 then
        decimalNumber = 0
    end if
    hexString = StrI(decimalNumber, 16)
    if(decimalNumber < 16) then 
        hexString = "0" + hexString
    end if
    return hexString
end function

function colorFromRGB(red as Integer, green as Integer, blue as Integer) as String
    color = "0x" + IntToZeroPaddedHexString(red) + IntToZeroPaddedHexString(green) + IntToZeroPaddedHexString(blue) + "ff"
    return color
end function

function closeProgressSpinner()
    m.top.removeChild(m.progressSpinner)
    startAutoCloseTimer()
end function
