local htmlEntities = {}

local entity_map = {
    quot = '"',
    apos = "'",
    lt = "<",
    gt = ">",
    amp = "&",
    nbsp = " ",
    ['cent'] = "¢",
    ['pound'] = "£",
    yen = "¥",
    euro = "€",
    copy = "©",
    reg = "®",
    deg = "°",
    mdash = "—",
    ndash = "–",
    rsquo = "’",
    ldquo = "“",
    rdquo = "”",
    lsquo = "‘",
    trade = "™",
    hellip = "…",
    br = "\n"
}

function htmlEntities.decode(text)
    return text:gsub("&(#?)(%w+);", function(is_numeric, entity)
        if is_numeric == "#" then
            local num = tonumber(entity)
            if num then
                return utf8.char(num)
            end
        else
            local replacement = entity_map[entity]
            if replacement then
                return replacement
            end
        end
        return "&" .. entity .. ";"
    end)
end

return htmlEntities
