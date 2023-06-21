# deneko: discord utilities
making discord tokens and webhooks optimized and easier to manage

### todo:
- convert returned coded numbers to their premium type (0 = no nitro, 1 = nitro basic, etc...)
- convert public flags and flags to their flags (i dont understand what these do)
- better handling of when token login does not work (currently only displays the username, discriminator, userid and date created)
- webhook embeds

## optimized compiling

### optimized compilation flags for nim:
nim c -r -d:ssl --opt:size --threads:on --app:console -d:release "{NIM FILE PATH}"

### optimized upx flags for the executable
upx -9 --best -f --lzma --brute --ultra-brute --overlay=strip --8086 --8-bit --no-align --strip-relocs=1 {EXE FILE PATH}

## examples:
### - webhooks:
```nim
import deneko/webhooks

# sending a message using a webhook

let webhookUrl: string = "https://discord.webhook.url"
let message: string = "Hello, World!"
let username: string = "Nim Man" # optional!
let avatarUrl: string = "https://some.random.picture.png" # optional!

discard sendMessage(webhookUrl, message, username, avatarUrl) # you can remove username and avatarUrl if you don't want it!
```
&
```nim
import deneko/webhooks

# delete a webhook (even if you don't own it)

let webhookUrl: string = "https://discord.webhook.url"

discard deleteWebhook(webhookUrl)
```
### - tokens:
```nim
import deneko/tokens

# get the first part of a token using only the userid

let userId: string = "discord.userid"

discard getFirst(userId)
```
&
```nim
import deneko/tokens

# verify a token by extracting the info when logging in

let token: string = "discord.token"

discard verifyToken(token)
```