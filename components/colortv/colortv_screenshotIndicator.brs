sub init()
    m.scaleUpAnimation = m.top.findNode("scaleUpAnimation")
    m.scaleDownAnimation = m.top.findNode("scaleDownAnimation")
    m.top.ObserveField("focused", "focusIndicator")
end sub

function focusIndicator()
    if m.top.focused then
        m.scaleUpAnimation.control = "start"
    else 
        m.scaleDownAnimation.control = "start"
    end if
end function
