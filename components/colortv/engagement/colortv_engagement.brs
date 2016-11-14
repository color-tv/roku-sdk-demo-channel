sub init()
    'It seems the default value has to be set for the <interface> field, otherwise we can't set it from the outside
    m.top.dataModel = {}

    m.progressSpinner = m.top.findNode("progressSpinner")
    m.actionbutton = m.top.findNode("actionButton")
    m.closebutton = m.top.findNode("closeButton")
    m.closebuttonbg = m.top.findNode("closeButtonBg")
    m.autoCloseTimer = m.top.findNode("autoCloseTimer")
    m.background = m.top.findNode("bg")    

    m.currentlyfocused = "actionButton"
    m.top.setFocus(true)
    m.closebutton.visible = false
    m.actionbutton.visible = false
    m.autoCloseTimer.visible = false
    m.engagementFormShown = false
    if m.background.loadStatus = "ready" then 
        onBackgroundLoaded()
    else
        m.background.ObserveField("loadStatus", "onBackgroundLoaded")
    end if
    m.top.findNode("impressionTimer").ObserveField("fire", "countImpression")
    m.top.findNode("impressionTimer").control = "start"
    m.autoCloseTimer.ObserveField("closeAd", "exitView")
End sub

function onBackgroundLoaded()
    if m.background.loadStatus = "ready" then
        initAdViews()
    else if m.background.loadStatus = "failed" then
    ' TODO: handle this gracefully
    end if
end function

function initAdViews()
    m.closebutton.visible = true
    m.actionbutton.visible = true
    m.actionbutton.focused = true
    startAutoCloseTimer()
    closeProgressSpinner()
end function

function onKeyEvent(key as String, press as Boolean) as Boolean    
    keyIntercepted = false
    if (key = "left" or key = "right") then
        keyIntercepted = true
        if press then
            changeButtonFocus()
        end if
    else if key = "back" then
        keyIntercepted = true
        if not press and m.engagementFormShown then
            hideEngagementForm()
        else if not press
            exitView()
        else 
        end if
    elseif key = "OK" then
      keyIntercepted = true
      if not press and m.currentlyfocused = "closeButton" then
        exitView()
      else if m.currentlyfocused = "actionButton"
        m.actionbutton.buttonClicked = press
        if not press then
            performEngagement()
        end if
      end if
    end if
    cancelAutoCloseTimer()
    return keyIntercepted 
end function

function changeButtonFocus()
    if m.currentlyfocused = "actionButton" then
        m.closebutton.focused = true
        m.actionbutton.focused = false
        m.currentlyfocused = "closeButton"                
    else
        m.actionbutton.focused = true
        m.closebutton.focused = false
        m.currentlyfocused = "actionButton"
    end if
end function

function setAdModel() as Void    
    if m.top.dataModel.count() = 0 then
        return
    end if    

    updateViewWithAd()
end function

function updateViewWithAd()
    setupActionButton()
    
    m.background.uri = m.top.dataModel.ads[0].backgroundUrl
    m.autoCloseTimer.duration = m.top.dataModel.autoCloseDuration
end function

function setupActionButton()
    actionButton = m.top.dataModel.ads[0].actionButton

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
    m.actionButton.translation = [actionButton.xPosition, actionButton.yPosition]
end function
