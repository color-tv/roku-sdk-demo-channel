sub init()
    m.top.setFocus(true)
    m.top.ObserveField("dataModel", "setAdModel")
    showEngagementForm()
End sub

function setAdModel()
    m.subscriptionForm.clickedModel = m.top.dataModel.ads[0]
end function

function onKeyEvent(key as String, press as Boolean) as Boolean    
    keyIntercepted = false
    if key = "left" or key = "right" or key = "OK" or key = "back" then
        keyIntercepted = true
        if key = "back" and not press then
            exitView()
        end if
    end if
    return keyIntercepted 
end function

function exitView()
    m.top.findNode("colorTvSubscriptionEvents").closed = true
end function

function showEngagementForm()
    m.subscriptionForm = createObject("RoSGNode","colortv_subscriptionWindow")
    m.subscriptionForm.id = "subscriptionWindow"
    m.subscriptionForm.parentNodeReference = m.top
    m.top.appendChild(m.subscriptionForm)
    m.subscriptionForm.setFocus(true)
end function