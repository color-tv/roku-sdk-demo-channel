sub init()
    m.overlay = m.top.findNode("overlay")
    m.engagementButton = m.top.findNode("engagementButton")
    m.inputField = m.top.findNode("inputField")
    m.keyboardDialog = m.top.findNode("keyboardDialog")
    m.keyboardDialog.buttons = ["OK", "cancel"]
    m.keyboardDialog.ObserveField("buttonSelected", "keyboardButtonSelected")
    m.top.ObserveField("clickedModel", "setInputType")

    m.keyboardDialog.visible = false

    m.engagementButton.focused = true

    m.hidingKeyboard = false
End sub

function setInputType()
    actionButtonType = m.top.clickedModel.actionButton.actionType
    if actionButtonType = "CLICK_TO_CALL" or actionButtonType = "CLICK_TO_SMS" then
        m.inputType = "phone"
        inputHint = "Enter phone number here"
    else if actionButtonType = "CLICK_TO_EMAIL"
        m.inputType = "email"
        inputHint = "Enter email here"
    end if

    m.inputField.hintText = inputHint
    m.keyboardDialog.title = inputHint
    
    storedInput = invalid
    model = m.top.parentNodeReference.dataModel
    if model <> invalid then
        if m.inputType = "phone"
            storedInput = model.storedPhoneNumber
        else if m.inputType = "email"
            storedInput = model.storedEmailAddress
        end if
    end if
    if storedInput <> invalid then 
        m.inputField.text = storedInput
        m.keyboardDialog.text = storedInput
        m.keyboardDialog.keyboard.textEditBox.cursorPosition  = Len(storedInput)
    end if
    setSubscriptionText()
end function

function setSubscriptionText()
    if m.top.clickedModel <> invalid then
        m.top.findNode("subscriptionText").text = m.top.clickedModel.description
    end if
end function

function onKeyEvent(key as String, press as Boolean) as Boolean    
    keyIntercepted = false
    if (key = "left" or key = "right") and not m.keyboardDialog.visible then
        keyIntercepted = true
        if press then
            changeButtonFocus()
        end if
    else if key = "OK" then
        keyIntercepted = true
        if not press and m.hidingKeyboard then
            focusActionButtonAfterKeyboardHidden()
        else if not press and m.inputField.hasFocus() then
            showKeyboard()
        else if m.engagementButton.focused then
            m.engagementButton.buttonClicked = press
            if not press then
                validateInput()
            end if
        end if
    else if key = "back" and m.keyboardDialog.visible then
        keyIntercepted = true
    end if
    return keyIntercepted 
end function

function changeButtonFocus()
    if m.engagementButton.focused then
        m.engagementButton.focused = false
        m.inputField.SetFocus(true)
        m.inputField.active = true
    else
        m.engagementButton.focused = true
        m.inputField.active = false
        m.engagementButton.SetFocus(true)
    end if
end function

function focusActionButtonAfterKeyboardHidden()
    m.hidingKeyboard = false
    m.engagementButton.focused = true
    m.engagementButton.SetFocus(true)
end function

function validateInput()
    if (m.inputType = "email" and validateEmail()) or (m.inputType = "phone" and validatePhone()) then
        showThankYou()
    else if m.inputType = "email"
        showMailError()
    else
        showPhoneError()
    end if
end function


function validateEmail()
    regex = CreateObject("roRegex", "\A[^@]+@[^@]+\z", "")
    return regex.isMatch(m.inputField.text)
end function

function validatePhone()
    regex = CreateObject("roRegex", "[\(]?[0-9]{3}[\)]?[ ]?[-]?[ ]?[0-9]{3}[ ]?[-]?[ ]?[0-9]{3,4}", "")
    return regex.isMatch(m.inputField.text)
end function

function showThankYou()
    if m.top.parentNodeReference.findNode("colorTvSubscriptionEvents") <> invalid then
        m.top.parentNodeReference.findNode("colorTvSubscriptionEvents").subscribed = m.top.findNode("inputField").text
    else if m.top.parentNodeReference.findNode("colorTvDiscoveryCenterEvents") <> invalid then
        subscribedData = {
            clickedItemModel: m.top.clickedModel
            inputValue: m.top.findNode("inputField").text
        }
        m.top.parentNodeReference.findNode("colorTvDiscoveryCenterEvents").subscribed = subscribedData
    end if
    m.subscriptionThankYou = createObject("RoSGNode","colortv_subscriptionThankYouWindow")
    m.subscriptionThankYou.id = "subscriptionThankYouWindow"
    m.subscriptionThankYou.parentNodeReference = m.top.parentNodeReference
    m.top.parentNodeReference.appendChild(m.subscriptionThankYou)
    m.subscriptionThankYou.setFocus(true)
    hideSubscriptionWindow()
end function

function hideSubscriptionWindow()
    m.overlay.visible = false
end function

function showMailError()
    showError("Incorrect mail has been entered")
end function

function showPhoneError()
    showError("Incorect phone number has been entered")
end function

function showError(text as String)
    m.toast = createObject("RoSGNode","colortv_toast")
    m.toast.id = "toast"
    m.toast.parentNodeReference = m.top
    m.toast.text = text
    m.top.appendChild(m.toast)
    m.toast = invalid
end function

function showKeyboard()
    m.engagementButton.focused = false
    m.inputField.active = false
    m.keyboardDialog.visible = true
    m.keyboardDialog.SetFocus(true)
end function

function keyboardButtonSelected()
    if m.keyboardDialog.buttonSelected = 0
        m.inputField.text = m.keyboardDialog.text
        m.inputField.cursorPosition = Len(m.inputField.text)
    end if
    m.keyboardDialog.visible = false
    m.hidingKeyboard = true
end function
