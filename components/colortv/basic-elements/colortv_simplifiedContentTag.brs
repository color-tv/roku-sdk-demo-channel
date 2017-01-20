sub init()
    m.tagLabel = m.top.findNode("tagLabel")
    m.background = m.top.findNode("tagBackground")
    m.circleRight = m.top.findNode("circleRight")
    m.circleLeft = m.top.findNode("circleLeft")


    m.backgroundFocusedAnimation = m.top.findNode("backgroundFocusedAnimation")
    m.circleLeftFocusedAnimation = m.top.findNode("circleLeftFocusedAnimation")
    m.circleRightFocusedAnimation = m.top.findNode("circleRightFocusedAnimation")
    m.labelFocusedAnimation = m.top.findNode("labelFocusedAnimation")
    m.backgroundUnfocusedAnimation = m.top.findNode("backgroundUnfocusedAnimation")
    m.labelUnfocusedAnimation = m.top.findNode("labelUnfocusedAnimation")
    m.circleLeftUnfocusedAnimation = m.top.findNode("circleLeftUnfocusedAnimation")
    m.circleRightUnfocusedAnimation = m.top.findNode("circleRightUnfocusedAnimation")

    m.top.ObserveField("text", "setLabelText")
    m.top.ObserveField("focused", "focusTags")
    m.top.ObserveField("colors", "setColors")
end sub

function setLabelText()
    m.tagLabel.text = m.top.text
    textLength = m.top.text.len()
    containerMaxLenghtDimension = 500
    approximateCharacterWidthDimension = 10
    paddingXDimension = 5
    roundedEgdesWidthDimension = 50
    if m.top.translation[0] + approximateCharacterWidthDimension * textLength + paddingXDimension > containerMaxLenghtDimension then
        m.background.width = containerMaxLenghtDimension - m.top.translation[0]
        paddingDimension = 15
        m.tagLabel.width = m.background.width + paddingDimension
        m.tagLabel.translation = [paddingDimension,0]
    else
        m.background.width = approximateCharacterWidthDimension * textLength + paddingXDimension
        m.tagLabel.width = m.background.width + roundedEgdesWidthDimension
    end if

    oneRoundedEdgeWidthDimension = 23
    circleTranslationX = m.background.width + oneRoundedEdgeWidthDimension
    circleTranslationY = m.circleRight.translation[1]
    circleTranslation = [circleTranslationX, circleTranslationY]
    m.circleRight.translation = circleTranslation
    m.top.viewWidth = m.background.width + 2 * oneRoundedEdgeWidthDimension
end function

function focusTags()
    if m.top.focused then
        m.backgroundFocusedAnimation.control = "start"
        m.circleLeftFocusedAnimation.control = "start"
        m.circleRightFocusedAnimation.control = "start"
        m.labelFocusedAnimation.control = "start"
    else
        m.backgroundUnfocusedAnimation.control = "start"
        m.circleLeftUnfocusedAnimation.control = "start"
        m.circleRightUnfocusedAnimation.control = "start"
        m.labelUnfocusedAnimation.control = "start"
    end if
end function

function setColors()
    reversedColors = m.top.colors
    reversedColors.reverse()
    m.tagLabel.color = m.top.colors[0] 
    m.background.blendColor = m.top.colors[0] 
    m.circleRight.blendColor = m.top.colors[0] 
    m.circleLeft.blendColor = m.top.colors[0]
    m.backgroundFocusedAnimation.getChild(0).keyValue = m.top.colors
    m.backgroundFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.backgroundUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.backgroundUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.labelFocusedAnimation.getChild(0).keyValue = m.top.colors
    m.labelFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.labelUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.labelUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.circleLeftFocusedAnimation.getChild(0).keyValue = m.top.colors
    m.circleLeftFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.circleLeftUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.circleLeftUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.circleRightFocusedAnimation.getChild(0).keyValue = m.top.colors
    m.circleRightFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.circleRightUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.circleRightUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
end function
