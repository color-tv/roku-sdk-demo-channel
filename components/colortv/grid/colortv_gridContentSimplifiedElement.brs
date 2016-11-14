sub init()
    initViews()

    m.top.ObserveField("contentModel", "setContentModel")
    m.top.ObserveField("textColor", "setTextColor")
end sub

function initViews()
    m.playButton = m.top.findNode("playButton")

    m.backgroundImage = m.top.findNode("backgroundImage")
    m.backgroundOverlay = m.top.findNode("backgroundOverlay")
    m.tagsContainer = m.top.findNode("tagsContainer")
    m.titleLabel = m.top.findNode("title")
    m.durationLabel = m.top.findNode("duration")
    m.clockImage = m.top.findNode("clockImage")
end function

function setTextColor()
    textColor = m.top.textColor[m.top.textColor.count() - 1]
    m.playButton.blendColor = textColor
    m.titleLabel.color = textColor
    m.durationLabel.color = textColor
    m.clockImage.blendColor = textColor
    reversedColors = m.top.textColor
    reversedColors.reverse()
    for i = 0 to m.tags.count() - 1
        m.tags[i].colors = reversedColors
    end for
end function

function focusView()
    for i = 0 to m.tags.count() - 1
        m.tags[i].visible = not m.top.focused
    end for
    m.playButton.visible = not m.top.focused
    m.backgroundOverlay.visible = not m.top.focused
end function

function setContentModel() as Void
    setContentRecommendationModel(m.top.contentModel)
    m.top.ObserveField("focused", "focusView")
    focusView()
end function

function setContentRecommendationModel(contentModel)
    setGenres(contentModel.genres)
    if contentModel.thumbnailUrl <> invalid then
        m.backgroundImage.uri = contentModel.thumbnailUrl
    end if
    m.durationLabel.text = getDurationString(contentModel.durationInMinutes)
    m.titleLabel.text = box(contentModel.title).trim()
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

    m.spaceBetweenGenres = 12
    
    if genres.count() > 1 then
        totalViewWidth = 330
        translationX = (totalViewWidth - calculateTotalGenresWidth(genres)) / 2
    else
        totalViewWidth = 300
        translationX = (totalViewWidth - calculateTotalGenresWidth(genres))
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
        translationX += calculateGenreViewWidth(genres[i].toStr())
        translationX += m.spaceBetweenGenres
    end for
end sub

function calculateTotalGenresWidth(genres as Object)
    totalWidth = 0
    for i = 0 to genres.count() - 1
        totalWidth += calculateGenreViewWidth(genres[i])
    end for
    totalWidth += (genres.count() - 1) * m.spaceBetweenGenres
    return totalWidth
end function

function calculateGenreViewWidth(genre as String) as Integer
    approximateCharacterWidth = 7
    paddingX = 3
    roundedEgdesWidth = 30
    retValue = approximateCharacterWidth * genre.len() + paddingX + roundedEgdesWidth
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
