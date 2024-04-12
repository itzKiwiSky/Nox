return function(_props, _uuid, _meta)
    local widget = loveframes.Create("image")
    widget.uuid = _uuid
    widget.tag = _props.tag or "frame_widget"
    widget:SetX(tonumber(_props.x) or 0)
    widget:SetY(tonumber(_props.y) or 0)
    widget:SetScaleX(tonumber(_props.scalex) or 1)
    widget:SetScaleY(tonumber(_props.scalex) or 1)
    widget:SetOffsetX(tonumber(_props.offsetx) or 0)
    widget:SetOffsetY(tonumber(_props.offsety) or 0)
    widget:SetImage(_props.drawable)
    widget:SetColor(tonumber(_props.r) or 1, tonumber(_props.g) or 1, tonumber(_props.b) or 1)

    if _meta then
        if _meta.type == "children" then
            widget:SetParent(_meta.elementList[_meta.parentUUID])
        end
    end

    return widget
end