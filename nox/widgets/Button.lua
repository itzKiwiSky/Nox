return function(_props, _uuid, _meta)
    local widget = loveframes.Create("button")
    widget.uuid = _uuid
    widget.tag = _props.tag or "frame_widget"
    widget:SetX(tonumber(_props.x) or 0)
    widget:SetY(tonumber(_props.y) or 0)
    widget:SetWidth(tonumber(_props.w) or 0)
    widget:SetHeight(tonumber(_props.h) or 0)
    widget:SetText(_props.text or "button")
    widget:SetClickable(_props.clickable or true)
    widget:SetEnabled(_props.enable or true)
    widget.OnClick = function(this)
        -- do run some events --
    end

    if _meta then
        if _meta.type == "children" then
            widget:SetParent(_meta.elementList[_meta.parentUUID])
        end
    end

    return widget
end