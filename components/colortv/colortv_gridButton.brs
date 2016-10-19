sub init()
    m.backgroundFocusedAnimation = m.top.findNode("backgroundFocusedAnimation")
    m.backgroundUnfocusedAnimation = m.top.findNode("backgroundUnfocusedAnimation")
    m.buttonLabelFocusedAnimation = m.top.findNode("buttonLabelFocusedAnimation")
    m.buttonLabelUnfocusedAnimation = m.top.findNode("buttonLabelUnfocusedAnimation")
    m.buttonIconFocusedAnimation = m.top.findNode("buttonIconFocusedAnimation")
    m.buttonIconUnfocusedAnimation = m.top.findNode("buttonIconUnfocusedAnimation")

    m.top.ObserveField("colors", "setColors")
    m.top.ObserveField("focused", "focusButton")
end sub

function setColors()
    reversedColors = m.top.colors
    reversedColors.reverse()
    m.backgroundFocusedAnimation.getChild(0).keyValue = reversedColors
    m.backgroundUnfocusedAnimation.getChild(0).keyValue = m.top.colors
    m.buttonLabelFocusedAnimation.getChild(0).keyValue = m.top.colors
    m.buttonLabelUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.buttonIconFocusedAnimation.getChild(0).keyValue = m.top.colors
    m.buttonIconUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.top.findNode("buttonBg").blendColor = reversedColors[0]
end function

function focusButton()
    if m.top.focused then
        m.backgroundFocusedAnimation.control = "start"
        m.buttonLabelFocusedAnimation.control = "start"
        m.buttonIconFocusedAnimation.control = "start"
    else 
        m.backgroundUnfocusedAnimation.control = "start"
        m.buttonLabelUnfocusedAnimation.control = "start"
        m.buttonIconUnfocusedAnimation.control = "start"
    end if
end function
