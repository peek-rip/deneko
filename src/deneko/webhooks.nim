import httpclient

proc sendMessage*(webhookUrl: string, message: string, username: string = "", avatarUrl: string = ""): string =
    var messageData = newMultipartData()
    var client = newHttpClient()

    if username != "":
        messageData["username"] = username
    if avatarUrl != "":
        messageData["avatar_url"] = avatarUrl

    messageData["content"] = message

    discard client.postContent(webhookUrl, multipart=messageData)

proc deleteWebhook*(webhookUrl: string): string =
    var client = newHttpClient()

    discard delete(client, webhookUrl)