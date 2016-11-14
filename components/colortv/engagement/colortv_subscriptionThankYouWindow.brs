sub init()
    m.okButton = m.top.findNode("okButton")
    m.okButton.focused = true
End sub

function onKeyEvent(key as String, press as Boolean) as Boolean    
    keyIntercepted = false
    if key = "left" or key = "right" then
        keyIntercepted = true
    else if key = "OK" or key = "back" then
        keyIntercepted = true
        if key = "OK" then
            m.okButton.buttonClicked = press
        end if
        if not press then
            exitView()
        end if
    end if
    return keyIntercepted 
end function

function exitView()
    if m.top.parentNodeReference.findNode("colorTvAdEvents") <> invalid then
        m.top.parentNodeReference.findNode("colorTvAdEvents").closeAd = true
    end if
    if m.top.parentNodeReference.findNode("colorTvGridEvents") <> invalid then
        m.top.parentNodeReference.findNode("colorTvGridEvents").closed = true
    end if
end function
