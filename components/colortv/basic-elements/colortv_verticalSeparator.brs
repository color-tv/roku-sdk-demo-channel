function init()
    m.separator = m.top.findNode("separator")
    m.separatorFocusedAnimation = m.top.findNode("separatorFocusedAnimation")
    m.separatorUnfocusedAnimation = m.top.findNode("separatorUnfocusedAnimation")

    m.top.ObserveField("focused", "setSeparatorFocused")
    m.top.ObserveField("colors", "setColors")
end function

function setSeparatorFocused()
    if m.top.focused then
        m.separatorFocusedAnimation.control = "start"
    else
        m.separatorUnfocusedAnimation.control = "start"
    end if
end function

function setColors()
    reversedColors = m.top.colors
    reversedColors.reverse()
    m.separatorFocusedAnimation.getChild(0).keyValue = m.top.colors
    m.separatorFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.separatorUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.separatorUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
end function
