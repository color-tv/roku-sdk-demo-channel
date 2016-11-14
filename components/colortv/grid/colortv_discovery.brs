sub init()
    m.top.ObserveField("dataModel", "setAdModel")
End sub

function setAdModel() as Void
    if m.top.dataModel.ads = invalid or m.top.dataModel.ads.count() = 0 then
        return
    end if

    updateViewWithData(m.top.dataModel.ads)
end function
