-- This component is part of the Nox Framework, copyright 2024 (c) Gabriella Schultz--

function string.split(inputstr, sep)
    sep = sep or "%s"
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

return string.split