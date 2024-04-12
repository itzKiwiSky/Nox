return function(_props, _uuid, _meta)
    local widget = loveframes.Create("text")
    widget.uuid = _uuid
    widget.tag = _props.tag or "frame_widget"
    widget:SetX(tonumber(_props.x) or 0)
    widget:SetY(tonumber(_props.y) or 0)
    widget:SetText(_props.text)
    if _meta then
        if _meta.type == "children" then
            widget:SetParent(_meta.elementList[_meta.parentUUID])
        end
    end

    return widget
end