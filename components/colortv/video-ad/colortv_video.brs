sub init()
    'It seems the default value has to be set for the <interface> field, otherwise we can't set it from the outside
    m.top.dataModel = {}

    m.progressSpinner = m.top.findNode("progressSpinner")
    m.actionbutton = m.top.findNode("actionButton")
    m.countDownTimer = m.top.findNode("countDownTimer")
    m.videoNode = m.top.findNode("videoNode")

    m.currentlyfocused = "actionButton"
    m.top.setFocus(true)
    m.actionbutton.visible = false
    m.countDownTimer.visibility = false
    m.engagementFormShown = false
    
    m.videoNode.ObserveField("state", "onVideoStatechanged")
    m.top.ObserveField("videoContent", "setVideoContent")
    m.videoNode.ObserveField("position", "updateTimer")

    m.top.findNode("impressionTimer").ObserveField("fire", "countImpression")
    m.top.findNode("impressionTimer").control = "start"
End sub

function setVideoContent()
    videoContent = createObject("RoSGNode", "ContentNode")
    videoContent.url = m.top.videoContent.streams[0].url
    m.videoNode.content = videoContent
    m.videoNode.control = "play"
    m.videoNode.enableUI = false
    m.videoNode.enableTrickPlay = false
end function

function onVideoStatechanged()
    if m.videoNode.state = "playing" then
        initAdViews()
    else if m.videoNode.state = "error" then
    ' TODO: handle this gracefully
    else if m.videoNode.state = "finished" then
        m.top.findNode("colorTvAdEvents").closeAd = true
    end if
end function

function initAdViews()
    m.actionbutton.visible = true
    m.actionbutton.focused = true
    m.countDownTimer.visibility = true
    m.countDownTimer.duration = m.videoNode.duration
    m.countDownTimer.startTimer = true
    closeProgressSpinner()
end function

function updateTimer()
    m.countDownTimer.currentPosition = m.videoNode.position
end function

function onKeyEvent(key as String, press as Boolean) as Boolean    
    keyIntercepted = false
    if key = "back" then
        keyIntercepted = true
        if not press and m.engagementFormShown then
            m.videoNode.control = "resume"
            hideEngagementForm()
        else if not press
            exitView()
        else 
        end if
    elseif key = "OK" then
      keyIntercepted = true
      if m.currentlyfocused = "actionButton"
        m.actionbutton.buttonClicked = press
        if not press then
            m.videoNode.control = "pause"
            performEngagement()
        end if
      end if
    end if
    return keyIntercepted 
end function

function setAdModel() as Void
    if m.top.dataModel.count() = 0 then
        return
    end if    

    updateViewWithAd()
end function

function updateViewWithAd()
    setupActionButton()
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
