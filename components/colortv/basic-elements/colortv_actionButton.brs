sub init()
    m.buttonbg = m.top.findNode("actionButtonBg")
    m.buttonlabel = m.top.findNode("buttonLabel")
    m.scaleUpAnimation = m.top.findNode("scaleUpAnimation")
    m.scaleDownAnimation = m.top.findNode("scaleDownAnimation")
    m.top.buttonClicked = false
    m.top.focused = false

    m.top.ObserveField("buttonLabelText", "setButtonLabel")
    m.top.ObserveField("buttonColor", "setButtonColor")
    m.top.ObserveField("buttonLabelColor", "setButtonLabelColor")
    m.top.ObserveField("buttonClickedColor", "setButtonClickColor")
    m.top.ObserveField("buttonClicked", "setButtonClicked")
    m.top.ObserveField("focused", "focusButton")
    m.top.ObserveField("scaleRotateCenter", "setScaleRotateCenter")
    m.buttonbg.scaleRotateCenter = m.top.scaleRotateCenter
    m.buttonbg.scale = "[0.8,0.8]"
end sub

function setButtonLabel()
    m.buttonlabel.text = m.top.buttonLabelText
end function

function setButtonColor()
    m.buttonbg.blendColor = m.top.buttonColor
    m.normalColor = m.top.buttonColor
end function

function setButtonLabelColor()
    m.buttonlabel.color = m.top.buttonLabelColor
end function

function setButtonClickColor()
    m.clickedColor = m.top.buttonClickedColor
end function

function setButtonClicked()
    if m.top.buttonClicked then
        m.buttonbg.blendColor = m.clickedColor
    else
        m.buttonbg.blendColor = m.normalColor
    end if
end function

function focusButton()
    if m.top.focused then
        m.scaleUpAnimation.control = "start"
    else 
        m.scaleDownAnimation.control = "start"
    end if
end function

function setScaleRotateCenter()
    m.buttonbg.scaleRotateCenter = m.top.scaleRotateCenter
end function
