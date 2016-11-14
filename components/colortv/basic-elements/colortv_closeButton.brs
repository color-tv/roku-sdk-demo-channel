sub init()
    m.buttonbg = m.top.findNode("closeButtonBg")
    m.top.focused = false

    m.top.ObserveField("focused", "focusButton")
    m.top.ObserveField("scaleRotateCenter", "setScaleRotateCenter")
    m.scaleUpAnimation = m.top.findNode("scaleUpAnimation")
    m.scaleDownAnimation = m.top.findNode("scaleDownAnimation")
    m.buttonbg.scaleRotateCenter = m.top.scaleRotateCenter

    m.top.ObserveField("width", "setCloseButtonWidth")
    m.top.ObserveField("height", "setCloseButtonHeight")
end sub

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

function setCloseButtonHeight()
    m.buttonbg.height = m.top.height
end function

function setCloseButtonWidth()
    m.buttonbg.width = m.top.width
end function
