import base64
import httpclient
import packedjson
import re

const
    # discord api urls
    usersUrl = "https://discord.com/api/v9/users/@me"

    # discord urls
    avatarUrl = "https://cdn.discordapp.com/avatars/"
    bannerUrl = "https://cdn.discordapp.com/banners/"

    userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/113.0"
    contentType = "application/json"

proc getFirst*(userId: string): string =
    # get the first part (before the first dot) of a discord token
    encode(userId)

var client = newHttpClient()

proc loginToken*(token: string): JsonNode =
  # login using a token, not usefull on its own
  let headers = newHttpHeaders({
      "User-Agent": userAgent,
      "Authorization": token,
      "Content-Type": contentType
  })

  client.headers = headers
  let response = client.getContent(usersUrl)
  client.close()

  let jsonResponse = parseJson(response)

  result = jsonResponse

proc verifyToken*(token: string): string =
  try:
    let jsonResponse = loginToken(token)

    let username: string = jsonResponse["username"].getStr()
    let discriminator: string = jsonResponse["discriminator"].getStr()
    let globalUsername: string = jsonResponse["global_name"].getStr()
    let userId: string = jsonResponse["id"].getStr()
    let avatarsUrl: string = avatarUrl & $userId & "/" & jsonResponse["avatar"].getStr()
    let accentColor: int = jsonResponse["accent_color"].getInt()
    let bannersUrl: string = bannerUrl & $userId & "/" & jsonResponse["banner"].getStr()
    let bannerColor: string = jsonResponse["banner_color"].getStr()
    let bio: string = jsonResponse["bio"].getStr()

    let email: string = jsonResponse["email"].getStr()
    let phone: string = jsonResponse["phone"].getStr()
    let locale: string = jsonResponse["locale"].getStr()
    let premiumStatus: int = jsonResponse["premium_type"].getInt() # 0 = none; 1 = nitro classic; 2 = nitro; 3 = nitro basic
    let verifiedStatus: bool = jsonResponse["verified"].getBool()
    let publicFlags: int = jsonResponse["public_flags"].getInt()
    let flags: int = jsonResponse["flags"].getInt()
    let mfaStatus: bool = jsonResponse["mfa_enabled"].getBool()
    let nsfwStatus: bool = jsonResponse["nsfw_allowed"].getBool()

    echo "username > ", username
    echo "discriminator > ", discriminator
    echo "nickname > ", globalUsername
    echo "userid > ", userId
    echo "avatar > ", avatarsUrl
    echo "accent color > ", accentColor
    echo "banner > ", bannersUrl
    echo "banner color > ", bannerColor
    echo "bio > ", bio
    echo "\n"
    echo "email > ", email
    echo "phone > ", phone
    echo "locale > ", locale
    echo "nitro > ", premiumStatus # todo: convert the returned number to its nitro status
    echo "verified > ", verifiedStatus
    echo "public flags > ", publicFlags # todo: convert the returned number to its public flags
    echo "flags > ", flags # todo: convert the returned number to its flags
    echo "mfa > ", mfaStatus
    echo "nsfw > ", nsfwStatus

    result = $jsonResponse
  except CatchableError:
    # todo: finish this part
    let pattern = re"^[^.]*"
    let matches = findAll(token, pattern)

    for match in matches:
      let decodedUserId = decode(match)
      
      let lookupUrl: string = "https://discordlookup.mesavirep.xyz/v1/user/" & decodedUserId
      let response: string = client.getContent(lookupUrl)
      let parsedLookup = parseJson(response)

      echo "tag > ", parsedLookup["tag"].getStr()
      echo "userid > ", parsedLookup["id"].getStr()
      echo "created > ", parsedLookup["created_at"].getStr()
      