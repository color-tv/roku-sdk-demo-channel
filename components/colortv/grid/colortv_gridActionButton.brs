sub init()
    m.top.ObserveField("contentModel", "setupView")
end sub

function setupView()
    if m.top.contentModel <> invalid then
        contentModel = m.top.contentModel
        buttonLabelYTranslationDimension = -1
        if isIconType() then
            m.top.findNode("buttonIcon").uri = chooseCorrectIconDependingOnType(contentModel.actionType)
            m.top.findNode("buttonIcon").visible = true
            buttonLabelXTranslationDimension = 18
            m.top.findNode("buttonLabel").translation = [buttonLabelXTranslationDimension,buttonLabelYTranslationDimension]
        else
            m.top.findNode("buttonLabel").translation = [0,buttonLabelYTranslationDimension]
            m.top.findNode("buttonIcon").visible = false
        end if
        m.top.findNode("buttonLabel").text = contentModel.text
    end if
end function

function isIconType()
    actionType = m.top.contentModel.actionType
    return actionType = "CLICK_TO_EMAIL" or actionType = "CLICK_TO_SMS" or actionType = "CLICK_TO_CALL"
end function

function chooseCorrectIconDependingOnType(actionType)
    iconName = "color_tv_icon_"
    if actionType = "CLICK_TO_CALL" then
        iconName += "phone"
    else if actionType = "CLICK_TO_SMS" then
        iconName += "sms"
    else if actionType = "CLICK_TO_EMAIL" then
        iconName += "mail"
    end if

    return "pkg:/images/colortv/" + iconName + ".png"
end function
