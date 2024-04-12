return function(_props, _uuid, _meta)
    local widget = loveframes.Create("frame")
    widget.uuid = _uuid
    widget.tag = _props.tag or "frame_widget"
    widget:SetX(tonumber(_props.x) or 0)
    widget:SetY(tonumber(_props.y) or 0)
    widget:SetWidth(tonumber(_props.w) or 0)
    widget:SetHeight(tonumber(_props.h) or 0)
    widget:SetName(_props.title or "default")
    widget:SetIcon(_props.icon or nil)
    widget:SetDraggable(_props.draggable or true)
    widget:ShowCloseButton(_props.showclosebutton or true)
    widget:SetDockable(_props.dockable or true)

    if _meta then
        if _meta.type == "children" then
            local i = lume.find(_meta.elementList, _meta.parentUUID)
            lume.trace(i)
        end
    end

    return widget
end