sub init()
    m.focusedAnimation = m.top.findNode("focusedAnimation")
    m.unfocusedAnimation = m.top.findNode("unfocusedAnimation")
    m.actionButton = m.top.findNode("actionButton")
    m.top.ObserveField("focused", "focusView")
end sub

function focusView()
    if m.top.focused then
        m.focusedAnimation.control = "start"
    else
        m.unfocusedAnimation.control = "start"
    end if
end function

function setContentModel() as Void
    contentModel = m.top.contentModel
    if contentModel.backgroundUrl <> invalid then
        m.top.findNode("backgroundImage").uri = contentModel.backgroundUrl
    else if contentModel.thumbnailUrl <> invalid then
        m.top.findNode("backgroundImage").uri = contentModel.thumbnailUrl
    end if

    if contentModel.impressionUrl <> invalid then
        m.top.impressionNode.impression = contentModel.impressionUrl
    end if

    if contentModel.actionButton <> invalid then
        setupActionButton()
    else
        m.actionbutton.visible = false
    end if

    m.top.ObserveField("focused", "focusView")
end function

function setupActionButton()
    actionButton = m.top.contentModel.actionButton

    if isEmailOrPhoneAction(actionButton) then
        if actionButton.actionType = "CLICK_TO_EMAIL" then
            iconName = "color_tv_icon_mail.png"
        else if actionButton.actionType = "CLICK_TO_CALL" then
            iconName = "color_tv_icon_phone.png"
        else 
            iconName = "color_tv_icon_sms.png"
        end if
        m.actionbutton.findNode("actionButtonIcon").uri = "pkg:/images/colortv/" + iconName
    else
        m.actionbutton.findNode("actionButtonIcon").visible = false
        m.actionbutton.findNode("buttonLabel").translation = "[0,0]"
    end if

    m.actionButton.buttonLabelText = actionButton.text
    
    m.actionButton.buttonColor = colorFromRGB(actionButton.backgroundRed, actionButton.backgroundGreen, actionButton.backgroundBlue)
    m.actionButton.buttonClickedColor = colorFromRGB(actionButton.backgroundRed - 50, actionButton.backgroundGreen - 50, actionButton.backgroundBlue - 50)
    m.actionButton.buttonLabelColor = colorFromRGB(actionButton.textRed, actionButton.textGreen, actionButton.textBlue)
    m.actionButton.findNode("actionButtonBg").scale = [1,1]
end function

function isEmailOrPhoneAction(actionButton) as Boolean
    return actionButton.actionType = "CLICK_TO_EMAIL" or actionButton.actionType = "CLICK_TO_CALL" or actionButton.actionType = "CLICK_TO_SMS"
end function

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
