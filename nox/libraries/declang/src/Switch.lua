-- This component is part of the Nox Framework, copyright 2024 (c) Gabriella Schultz--

switch = function(var, case_table)
    local case = case_table[var]
    if case then 
        return case() 
    end
    local def = case_table['default']
    return def and def() or nil
end

return switch