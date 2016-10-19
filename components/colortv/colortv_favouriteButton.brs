sub init()
    m.backgroundFocusedAnimation = m.top.findNode("backgroundFocusedAnimation")
    m.backgroundUnfocusedAnimation = m.top.findNode("backgroundUnfocusedAnimation")
    m.buttonLabelFocusedAnimation = m.top.findNode("buttonLabelFocusedAnimation")
    m.buttonLabelUnfocusedAnimation = m.top.findNode("buttonLabelUnfocusedAnimation")
    m.buttonIconFocusedAnimation = m.top.findNode("buttonIconFocusedAnimation")
    m.buttonIconUnfocusedAnimation = m.top.findNode("buttonIconUnfocusedAnimation")

    m.top.ObserveField("colors", "setColors")
    m.top.ObserveField("textColors", "setTextColors")
    m.top.ObserveField("focused", "focusButton")
end sub

function setColors()
    reversedColors = m.top.colors
    reversedColors.reverse()
    m.backgroundFocusedAnimation.getChild(0).keyValue = m.top.colors
    m.backgroundUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.top.findNode("buttonBg").blendColor = m.top.colors[0]
end function

function setTextColors()
    reversedColors = m.top.textColors
    reversedColors.reverse()
    m.buttonLabelFocusedAnimation.getChild(0).keyValue = m.top.textColors
    m.buttonLabelFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.buttonLabelUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.buttonLabelUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.buttonIconFocusedAnimation.getChild(0).keyValue = m.top.textColors
    m.buttonIconFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.buttonIconUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.buttonIconUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.top.findNode("buttonLabel").color = m.top.textColors[0]
    m.top.findNode("buttonIcon").blendColor = m.top.textColors[0]
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
