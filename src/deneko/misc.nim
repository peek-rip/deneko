import httpclient
import packedjson

var client = newHttpClient()

proc checkUsername*(username: string): string =
    let url: string = "https://api.lixqa.de/v2/discord/pomelo-lookup/?username="

    let lookupUrl = client.getContent(url & username)
    let jsonResponse = parseJson(lookupUrl)

    let usernameStatus: string = jsonResponse["message"].getStr()
    
    echo "username > " & username

    if usernameStatus == "Available":
        echo "available > true"
    else:
        echo "available > false"