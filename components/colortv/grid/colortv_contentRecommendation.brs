sub init()
    m.top.ObserveField("dataModel", "setContentModel")
End sub

function setContentModel() as Void
    if m.top.dataModel.recommendations = invalid or m.top.dataModel.recommendations.count() = 0 then
        return
    end if    

    updateViewWithData(m.top.dataModel.recommendations)
end function

function showAddedToFavouritesToast()
    favouriteOverlay = createObject("RoSGNode","colortv_favouriteOverlay")
    favouriteOverlay.parentNodeReference = m.top
    m.top.appendChild(favouriteOverlay)
end function
