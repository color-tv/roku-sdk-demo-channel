sub init()
    'It seems the default value has to be set for the <interface> field, otherwise we can't set it from the outside
    m.top.dataModel = {}

    m.progressSpinner = m.top.findNode("progressSpinner")
    m.actionbutton = m.top.findNode("actionButton")
    m.closebutton = m.top.findNode("closeButton")
    m.closebuttonbg = m.top.findNode("closeButtonBg")
    m.autoCloseTimer = m.top.findNode("autoCloseTimer")

    m.currentlyfocused = "slider"
    m.engagementFormShown = false
    
    m.top.findNode("impressionTimer").ObserveField("fire", "countImpression")
    m.top.findNode("impressionTimer").control = "start"
    m.autoCloseTimer.ObserveField("closeAd", "exitView")
    m.top.ObserveField("cancelAutoCloseTimer", "cancelAutoCloseTimer")
    m.top.ObserveField("screenshotsLoaded", "closeProgressSpinner")
End sub

function onKeyEvent(key as String, press as Boolean) as Boolean    
    keyIntercepted = isOneOfTheButtonsToIntercept(key)

    if key = "left" or key = "right" then
        if press then
            changeButtonFocus()
        end if
    else if key = "down" then
        if press then
            setFocusOnActionButton()
        end if
    else if key = "up" then
        if press then
            setFocusOnScreenshotSlider()
        end if
    else if key = "back" then
        if not press and m.engagementFormShown then
            hideEngagementForm()
        else if not press
            exitView()
        else 
        end if
    else if key = "OK" then
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

function isOneOfTheButtonsToIntercept(key) as Boolean
    return key = "left" or key = "right" or key = "down" or key = "up" or key = "back" or key = "OK"
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

function setFocusOnActionButton()
    if m.currentlyfocused = "slider" then
        m.actionbutton.focused = true
        m.closebutton.focused = false
        m.currentlyfocused = "actionButton"
        m.actionbutton.setFocus(true)
    end if
end function

function setFocusOnScreenshotSlider()
    if (m.currentlyfocused = "actionButton" or m.currentlyfocused = "closeButton") and not m.engagementFormShown then
        m.currentlyfocused = "slider"
        m.actionbutton.focused = false
        m.closebutton.focused = false
        m.screenshotSlider.setFocus(true)
    end if
end function

function setAdModel() as Void    
    if m.top.dataModel.count() = 0 then
        return
    end if    

    updateWithAd()
end function

function updateWithAd()
    ad = m.top.dataModel.ads[0]

    setupActionButton()

    setupScreenshotSlider()

    setAppRating(ad.rating)
    
    m.top.findNode("appLogo").uri = ad.backgroundUrl

    m.autoCloseTimer.duration = m.top.dataModel.autoCloseDuration

    m.top.findNode("appTitle").text = ad.title
    m.top.findNode("appPrice").text = ad.price
    m.top.findNode("appReviewsNumber").text = ad.reviews.toStr() + " Ratings"
    m.top.findNode("appDescription").text = ad.description
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

    actionButtonLabel = m.actionbutton.findNode("buttonLabel")
    actionButtonBackground = m.actionbutton.findNode("actionButtonBg")
    actionButtonIcon = m.actionbutton.findNode("actionButtonIcon")

    m.actionButton.buttonLabelText = actionButton.text
    
    m.actionButton.buttonColor = colorFromRGB(actionButton.backgroundRed, actionButton.backgroundGreen, actionButton.backgroundBlue)
    m.actionButton.buttonClickedColor = colorFromRGB(actionButton.backgroundRed - 50, actionButton.backgroundGreen - 50, actionButton.backgroundBlue - 50)
    m.actionButton.buttonLabelColor = colorFromRGB(actionButton.textRed, actionButton.textGreen, actionButton.textBlue)

    actionButtonBackground.width = 437
    actionButtonBackground.height = 95

    actionButtonLabel.width = 437
    actionButtonLabel.height = 95

    actionButtonIcon.translation = "[40,28]"
end function

function setupScreenshotSlider()
    m.screenshotSlider = m.top.findNode("screenshotSlider")
    m.screenshotSlider.parentNodeReference = m.top
    m.screenshotSlider.screenshots = m.top.dataModel.ads[0].screenshots
    m.screenshotSlider.setFocus(true)
end function

function setAppRating(rating)
    wholeStars = fix(rating)
    rest = rating - wholeStars
    starsText = ""
    for i = 1 to wholeStars
        starsText += "1"
    end for
    if rest > 0 then
        starsText += "2"
    end if
    m.top.findNode("appRating").text = starsText
end function
