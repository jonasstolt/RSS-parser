local http = require("socket.http")
local ltn12 = require("ltn12")

local uri = arg[1]        -- URI of RSS Feed
local lines = tonumber(arg[2])      -- Number of headlines
local titlenum = tonumber(arg[3])   -- Number of extra titles

-- Function to fetch the RSS feed and return the content
function fetch_rss(uri)
    local response = {}
    local _, code, _, _ = http.request{
        url = uri,
        sink = ltn12.sink.table(response),
        method = "GET",
        headers = {["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3"}
    }

    if code ~= 200 then
        error("Failed to fetch RSS feed, HTTP response code: " .. code)
    end

    return table.concat(response)
end

-- Try to decode HTML entities
function decode_html_entities(input)
    local entities = {
        quot = '"',
        apos = "'",
        lt = "<",
        gt = ">",
        amp = "&",
        ['#x201C'] = '"',  -- Hexadecimal encoding for left double quotation mark
        ['#x201D'] = '"',  -- Hexadecimal encoding for right double quotation mark
        ['#8220'] = '"',   -- Decimal encoding for left double quotation mark
        ['#8221'] = '"',   -- Decimal encoding for right double quotation mark
    }

    return input:gsub("&(%a+);", entities)
end


if uri == nil or uri == "" then
    io.stderr:write("You need to specify a URI\n")
else
    if lines == nil then lines = 5 end
    if titlenum == nil then titlenum = 2 end

    local rss_content = fetch_rss(uri)
    local titles = {}

    for title in rss_content:gmatch("<title>(.-)</title>") do
        title = decode_html_entities(title)
        table.insert(titles, title)
    end

    for i = titlenum + 1, titlenum + lines do
        if titles[i] then
            io.write(titles[i] .. "\n")
        end
    end
end
