import httpclient

var client = newHttpClient()

proc sendMessage*(webhookUrl: string, message: string, username: string = "", avatarUrl: string = ""): string =
    var messageData = newMultipartData()

    if username != "":
        messageData["username"] = username
    if avatarUrl != "":
        messageData["avatar_url"] = avatarUrl

    messageData["content"] = message

    discard client.postContent(webhookUrl, multipart=messageData)

proc deleteWebhook*(webhookUrl: string): string =
    discard delete(client, webhookUrl)