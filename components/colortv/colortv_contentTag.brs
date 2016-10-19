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
    containerMaxLenght = 300
    approximateCharacterWidth = 7
    paddingX = 3
    roundedEgdesWidth = 30
    if m.top.translation[0] + approximateCharacterWidth * textLength + paddingX > containerMaxLenght then
        m.background.width = containerMaxLenght - m.top.translation[0]
        m.tagLabel.width = m.background.width + 10
        m.tagLabel.translation = [10,0]
    else
        m.background.width = approximateCharacterWidth * textLength + paddingX
        m.tagLabel.width = m.background.width + roundedEgdesWidth
    end if

    oneRoundedEdgeWidth = 14
    circleTranslationX = m.background.width + oneRoundedEdgeWidth
    circleTranslationY = m.circleRight.translation[1]
    circleTranslation = [circleTranslationX, circleTranslationY]
    m.circleRight.translation = circleTranslation
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
