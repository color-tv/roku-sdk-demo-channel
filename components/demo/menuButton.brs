sub init()
    m.buttonbg = m.top.findNode("buttonBg")
    m.buttonlabel = m.top.findNode("buttonLabel")
    m.top.buttonFocused = false
    m.top.buttonClicked = false

    m.top.ObserveField("buttonLabelText", "setButtonLabel")
    m.top.ObserveField("buttonColor", "setButtonColor")
    m.top.ObserveField("buttonHighlightedColor", "setButtonHighlightedColor")
    m.top.ObserveField("buttonClickedColor", "setButtonClickColor")
    m.top.ObserveField("buttonFocused", "setButtonFocused")
    m.top.ObserveField("buttonClicked", "setButtonClicked")
end sub

function setButtonLabel()
    m.buttonlabel.text = m.top.buttonLabelText
end function

function setButtonColor()
    m.buttonbg.color = m.top.buttonColor
    m.normalColor = m.top.buttonColor
end function

function setButtonHighlightedColor()
    m.highlightedColor = m.top.buttonHighlightedColor
end function

function setButtonClickColor()
    m.clickedColor = m.top.buttonClickedColor
end function

function setButtonFocused()
    if m.top.buttonFocused then
        m.buttonbg.color = m.highlightedColor
    else
        m.buttonbg.color = m.normalColor
    end if
end function

function setButtonClicked()
    if m.top.buttonClicked then
        m.buttonbg.color = m.clickedColor
    else
        m.buttonbg.color = m.highlightedColor
    end if
end function
