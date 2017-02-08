sub init()
    initViews()

    initAnimations()

    m.top.ObserveField("contentModel", "setContentModel")
    m.top.ObserveField("backgroundColor", "setBackgroundColor")
    m.top.ObserveField("textColor", "setTextColor")
end sub

function initViews()
    m.separator1 = m.top.findNode("separator1")
    m.separator2 = m.top.findNode("separator2")
    m.gridActionButton = m.top.findNode("gridActionButton")

    m.metaDataContainer = m.top.findNode("metaDataContainer")
    m.iconImage = m.top.findNode("iconImage")
    m.backgroundImage = m.top.findNode("backgroundImage")
    m.priceLabel = m.top.findNode("price")
    m.titleLabel = m.top.findNode("title")
    m.descriptionLabel = m.top.findNode("description")
    m.reviewsImage = m.top.findNode("reviewsImage")
    m.dataContainer = m.top.findNode("dataContainer")
    m.starImage = m.top.findNode("starImage")
    m.ratingsLabel = m.top.findNode("ratings")
    m.reviewsCountLabel = m.top.findNode("reviewsCount")
end function

function initAnimations()
    m.backgroundFocusedAnimation = m.top.findNode("backgroundFocusedAnimation")
    m.backgroundUnfocusedAnimation = m.top.findNode("backgroundUnfocusedAnimation")
    m.priceFocusedAnimation = m.top.findNode("priceFocusedAnimation")
    m.priceUnfocusedAnimation = m.top.findNode("priceUnfocusedAnimation")
    m.starImageFocusedAnimation = m.top.findNode("starImageFocusedAnimation")
    m.starImageUnfocusedAnimation = m.top.findNode("starImageUnfocusedAnimation")
    m.ratingsFocusedAnimation = m.top.findNode("ratingsFocusedAnimation")
    m.ratingsUnfocusedAnimation = m.top.findNode("ratingsUnfocusedAnimation")
    m.reviewsImageFocusedAnimation = m.top.findNode("reviewsImageFocusedAnimation")
    m.reviewsImageUnfocusedAnimation = m.top.findNode("reviewsImageUnfocusedAnimation")
    m.reviewsCountFocusedAnimation = m.top.findNode("reviewsCountFocusedAnimation")
    m.reviewsCountUnfocusedAnimation = m.top.findNode("reviewsCountUnfocusedAnimation")
    m.titleFocusedAnimation = m.top.findNode("titleFocusedAnimation")
    m.titleUnfocusedAnimation = m.top.findNode("titleUnfocusedAnimation")
    m.descriptionFocusedAnimation = m.top.findNode("descriptionFocusedAnimation")
    m.descriptionUnfocusedAnimation = m.top.findNode("descriptionUnfocusedAnimation")
end function

function setBackgroundColor()
    reversedColors = m.top.backgroundColor
    reversedColors.reverse()
    m.backgroundFocusedAnimation.getChild(0).keyValue = m.top.backgroundColor
    m.backgroundUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.gridActionButton.colors = m.top.backgroundColor
    m.dataContainer.color = m.top.backgroundColor[0]
end function

function setTextColor()
    reversedColors = m.top.textColor
    reversedColors.reverse()
    m.backgroundFocusedAnimation.getChild(0).keyValue = m.top.textColor
    m.backgroundFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.priceUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.priceUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.starImageFocusedAnimation.getChild(0).keyValue = m.top.textColor
    m.starImageFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.starImageUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.starImageUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.ratingsFocusedAnimation.getChild(0).keyValue = m.top.textColor
    m.ratingsFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.ratingsUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.ratingsUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.reviewsImageFocusedAnimation.getChild(0).keyValue = m.top.textColor
    m.reviewsImageFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.reviewsImageUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.reviewsImageUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.reviewsCountFocusedAnimation.getChild(0).keyValue = m.top.textColor
    m.reviewsCountFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.reviewsCountUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.reviewsCountUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.titleFocusedAnimation.getChild(0).keyValue = m.top.textColor
    m.titleFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.titleUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.titleUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.descriptionFocusedAnimation.getChild(0).keyValue = m.top.textColor
    m.descriptionFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.descriptionUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.descriptionUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    for i = 0 to m.tags.count() - 1
        m.tags[i].colors = m.top.textColor
    end for
    if m.separator1 <> invalid then
        m.separator1.colors = m.top.textColor
    end if
    if m.separator2 <> invalid then
        m.separator2.colors = m.top.textColor
    end if
end function

function focusView()
    setChildViewsFocus()
    if m.top.focused then
        m.backgroundFocusedAnimation.control = "start"
        m.priceFocusedAnimation.control = "start"
        m.starImageFocusedAnimation.control = "start"
        m.ratingsFocusedAnimation.control = "start"
        m.reviewsImageFocusedAnimation.control = "start"
        m.reviewsCountFocusedAnimation.control = "start"
        m.titleFocusedAnimation.control = "start"
        m.descriptionFocusedAnimation.control = "start"
    else
        m.backgroundUnfocusedAnimation.control = "start"
        m.priceUnfocusedAnimation.control = "start"
        m.starImageUnfocusedAnimation.control = "start"
        m.ratingsUnfocusedAnimation.control = "start"
        m.reviewsImageUnfocusedAnimation.control = "start"
        m.reviewsCountUnfocusedAnimation.control = "start"
        m.titleUnfocusedAnimation.control = "start"
        m.descriptionUnfocusedAnimation.control = "start"
    end if
end function

function setChildViewsFocus()
    for i = 0 to m.tags.count() - 1
        m.tags[i].focused = m.top.focused
    end for
    if m.separator1 <> invalid then
        m.separator1.focused = m.top.focused
    end if
    if m.separator2 <> invalid then
        m.separator2.focused = m.top.focused
    end if
    m.gridActionButton.focused = m.top.focused
end function

function setContentModel() as Void
    setDiscoveryCenterModel(m.top.contentModel)
    m.top.ObserveField("focused", "focusView")
    if m.top.focused then
        focusView()
    else
        setChildViewsFocus()
    end if
end function

function setDiscoveryCenterModel(contentModel)
    setGenres(contentModel.genres)
    m.gridActionButton.contentModel = contentModel.actionButton
    m.iconImage.uri = contentModel.iconUrl
    m.backgroundImage.uri = contentModel.backgroundUrl
    m.priceLabel.text = contentModel.price
    m.titleLabel.text = contentModel.title
    m.descriptionLabel.text = contentModel.description
    if contentModel.rating = invalid then
        hideSeparators()
        m.starImage.visible = false
        m.ratingsLabel.visible = false
    else
        showSeparators()
        m.starImage.visible = true
        m.ratingsLabel.visible = true
        m.ratingsLabel.text = getRatingsString(contentModel.rating.toStr())
    end if
    if contentModel.reviews = invalid then
        hideSeparators()
        m.reviewsCountLabel.visible = false
    else
        showSeparators()
        m.reviewsCountLabel.visible = true
        m.reviewsCountLabel.text = contentModel.reviews
    end if
end function

function hideSeparators()
    m.separator1.visible = false
    m.separator2.visible = false
end function

function showSeparators()
    m.separator1.visible = true
    m.separator2.visible = true
end function

function getRatingsString(rating as String) as String
    returnValue = rating
    if rating.len() = 1 then
        returnValue += ".0"
    end if
    return returnValue
end function

sub setGenres(genres)
    container = m.top.findNode("tagsContainer")
    if m.tags <> invalid and m.tags.count() > 0 then
        for i = 0 to m.tags.count() - 1
            container.removeChild(m.tags[i])
        end for
    end if

    m.tags = []

    if genres = invalid then
        return
    end if

    if genres.count() > 3 then
        for i = 3 to genres.count() - 1
            genres.delete(genres.count() - 1)
        end for
    end if

    m.spaceBetweenGenresDimension = 12
    
    if genres.count() > 1 then
        totalViewWidthDimension = 330
        translationX = (totalViewWidthDimension - calculateTotalGenresWidth(genres)) / 2
    else
        totalViewWidthDimension = 300
        translationX = (totalViewWidthDimension - calculateTotalGenresWidth(genres))
    end if

    if translationX < 0 then
        translationX = 0
    end if

    for i = 0 to genres.count() - 1
        tag = createObject("RoSGNode","colortv_contentTag")
        m.tags.push(tag)
        tag.id = "genre" + i.toStr()
        container.appendChild(tag)
        tag.translation = [translationX, 0]
        tag.text = genres[i]
        tag.colors = m.top.textColor
        translationX += calculateGenreViewWidth(genres[i].toStr())
        translationX += m.spaceBetweenGenresDimension
    end for
end sub

function calculateTotalGenresWidth(genres as Object)
    totalWidth = 0
    for i = 0 to genres.count() - 1
        totalWidth += calculateGenreViewWidth(genres[i])
    end for
    totalWidth += (genres.count() - 1) * m.spaceBetweenGenresDimension
    return totalWidth
end function

function calculateGenreViewWidth(genre as String) as Integer
    approximateCharacterWidthDimension = 7
    paddingXDimension = 3
    roundedEgdesWidthDimension = 30
    retValue = approximateCharacterWidthDimension * genre.len() + paddingXDimension + roundedEgdesWidthDimension
    return retValue
end function

function getDurationString(duration as Integer) as String
    if duration < 60 then
        return duration.toStr() + "m"
    else
        hours = 0
        minutes = duration
        while minutes > 60
            minutes -= 60
            hours++
        end while
        return hours.toStr() + "h " + minutes.toStr() + "m"
    end if
end function
