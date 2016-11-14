sub init()
    m.gridDiscoveryElement = m.top.findNode("gridDiscoveryElement")
    m.gridContentElement = m.top.findNode("gridContentElement")
    m.gridContentSimplifiedElement = m.top.findNode("gridContentSimplifiedElement")

    m.top.ObserveField("currentScreenPosition", "tryToCountImpression")
    m.top.ObserveField("backgroundColor", "setBackgroundColor")
    m.top.ObserveField("favouriteButtonColor", "setFavouriteButtonColor")
    m.top.ObserveField("favouriteButtonTextColor", "setFavouriteButtonTextColor")
    m.top.ObserveField("textColor", "setTextColor")
end sub

function tryToCountImpression()
    contentModel = m.top.contentModel
    if contentModel <> invalid and isViewVisible() and not isImpressionCounted() and contentModel.impressionUrl <> invalid then
        if m.top.parentNodeReference <> invalid then
            newArray = []
            parentImpressionCountedArray = m.top.parentNodeReference.impressionCountedArray
            newArray.append(parentImpressionCountedArray)
            newArray.push(m.top.currentlyShownElementIndex)
            m.top.parentNodeReference.impressionCountedArray = newArray
        end if
        m.top.impressionNode.impression = m.top.contentModel.impressionUrl
    end if
end function

function isViewVisible() as Boolean
    return m.top.currentScreenPosition >= 0 and m.top.currentScreenPosition <= 2
end function

function isImpressionCounted() as Boolean
    for i = 0 to m.top.parentNodeReference.impressionCountedArray.count() - 1
        if m.top.parentNodeReference.impressionCountedArray[i] = m.top.currentlyShownElementIndex
            return true
        end if
    end for
    return false
end function

function setBackgroundColor()
    if isContentRecommendation() then
        if not isSimplifiedContentRecommendation() then
            m.gridContentElement.backgroundColor = m.top.backgroundColor
        end if
    else
        m.gridDiscoveryElement.backgroundColor = m.top.backgroundColor
    end if
end function

function setFavouriteButtonColor()
    if not isSimplifiedContentRecommendation() then
        m.gridContentElement.favouriteButtonColor = m.top.favouriteButtonColor
    end if
end function

function setFavouriteButtonTextColor()
    if not isSimplifiedContentRecommendation() then
        m.gridContentElement.favouriteButtonTextColor = m.top.favouriteButtonTextColor
    end if
end function

function setTextColor()
    if isContentRecommendation() then    
        if not isSimplifiedContentRecommendation() then
            m.gridContentElement.textColor = m.top.textColor
        else
            m.gridContentSimplifiedElement.textColor = m.top.textColor
        end if
    else
        m.gridDiscoveryElement.textColor = m.top.textColor
    end if
end function

function focusView()
    if isContentRecommendation() then
        if not isSimplifiedContentRecommendation() then
            m.gridContentElement.focused = m.top.focused
        else
            m.gridContentSimplifiedElement.focused = m.top.focused
        end if
    else
        m.gridDiscoveryElement.focused = m.top.focused
    end if
end function

function setContentModel() as Void
    contentModel = m.top.contentModel
    if isContentRecommendation() then
        setContentRecommendationModel(contentModel)
    else
        setDiscoveryCenterModel(contentModel)
    end if 
    m.top.ObserveField("focused", "focusView")
    tryToCountImpression()
end function

function setContentRecommendationModel(contentModel)
    m.gridDiscoveryElement.visible = false
    if not isSimplifiedContentRecommendation() then
        m.gridContentSimplifiedElement.visible = false
        m.gridContentElement.visible = true
        m.gridContentElement.contentModel = contentModel
    else
        m.gridContentElement.visible = false
        m.gridContentSimplifiedElement.visible = true
        m.gridContentSimplifiedElement.contentModel = contentModel
    end if
end function

function setDiscoveryCenterModel(contentModel)
    m.gridContentElement.visible = false
    m.gridContentSimplifiedElement.visible = false
    m.gridDiscoveryElement.visible = true
    m.gridDiscoveryElement.contentModel = contentModel
end function

function isContentRecommendation()
    return m.top.parentNodeReference.dataModel.type = invalid or m.top.parentNodeReference.dataModel.type = "recommendation"
end function

function isSimplifiedContentRecommendation()
    return m.top.parentNodeReference.dataModel.format <> invalid and m.top.parentNodeReference.dataModel.format = "simple"
end function
