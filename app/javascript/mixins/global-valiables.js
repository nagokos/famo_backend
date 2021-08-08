export default {
  methods: {
    leagueNameEigo(leagueName) {
      let eigo = ""
      switch (leagueName) {
      case "プレミアリーグ":
        eigo = "premier"
        break
      case "プリンスリーグ":
        eigo =  "prince"
        break
      case "ルーキーリーグ":
        eigo =  "rookie"
        break
      case "北海道":
        eigo = "hokkaido"
        break
      case "青森":
        eigo = "aomori"
        break
      case "岩手":
        eigo =  "iwate"
        break
      case "宮城":
        eigo =  "miyagi"
        break
      case "秋田":
        eigo = "akita"
        break
      case "山形":
        eigo = "yamagata"
        break
      case "福島":
        eigo = "fukushima"
        break
      case "茨城":
        eigo =  "ibaraki"
        break
      case "栃木":
        eigo =  "tochigi"
        break
      case "群馬":
        eigo = "gunma"
        break
      case "埼玉":
        eigo = "saitama"
        break
      case "千葉":
        eigo =  "chiba"
        break
      case "東京":
        eigo =  "tokyo"
        break
      case "神奈川":
        eigo = "kanagawa"
        break
      case "新潟":
        eigo = "niigata"
        break
      case "富山":
        eigo =  "toyama"
        break
      case "石川":
        eigo =  "ishikawa"
        break
      case "福井":
        eigo = "fukui"
        break
      case "山梨":
        eigo = "yamanashi"
        break
      case "長野":
        eigo =  "nagano"
        break
      case "岐阜":
        eigo =  "gifu"
        break
      case "静岡":
        eigo = "shizuoka"
        break
      case "愛知":
        eigo = "aichi"
        break
      case "三重":
        eigo =  "mie"
        break
      case "滋賀":
        eigo =  "shiga"
        break
      case "京都":
        eigo = "kyoto"
        break
      case "大阪":
        eigo = "osaka"
        break
      case "兵庫":
        eigo =  "hyogo"
        break
      case "奈良":
        eigo =  "nara"
        break
      case "和歌山":
        eigo = "wakayama"
        break
      case "鳥取":
        eigo = "tottori"
        break
      case "島根":
        eigo =  "shimane"
        break
      case "岡山":
        eigo =  "okayama"
        break
      case "広島":
        eigo = "hiroshima"
        break
      case "山口":
        eigo =  "yamaguchi"
        break
      case "徳島":
        eigo =  "tokushima"
        break
      case "香川":
        eigo = "kagawa"
        break
      case "愛媛":
        eigo = "ehime"
        break
      case "高知":
        eigo =  "kochi"
        break
      case "福岡":
        eigo =  "fukuoka"
        break
      case "佐賀":
        eigo = "saga"
        break
      case "長崎":
        eigo =  "nagasaki"
        break
      case "熊本":
        eigo =  "kumamoto"
        break
      case "大分":
        eigo = "oita"
        break
      case "宮崎":
        eigo = "miyazaki"
        break
      case "鹿児島":
        eigo =  "kagoshima"
        break
      case "沖縄":
        eigo =  "okinawa"
        break
      }
      return eigo
    },
    getLeagueId(leagueEigo) {
      let id = ""
      switch (leagueEigo) {
      case "premier":
        id = 1
        break
      case "prince":
        id = 2
        break
      case "rookie":
        id = 3
        break
      case "hokkaido":
        id = 4
        break
      case "aomori":
        id = 5
        break
      case "iwate":
        id = 6
        break
      case "miyagi":
        id = 7
        break
      case "akita":
        id = 8
        break
      case "yamagata":
        id = 9
        break
      case "fukushima":
        id = 10
        break
      case "ibaraki":
        id = 11
        break
      case "tochigi":
        id = 12
        break
      case "gunma":
        id = 13
        break
      case "saitama":
        id = 14
        break
      case "chiba":
        id = 15
        break
      case "tokyo":
        id = 16
        break
      case "kanagawa":
        id = 17
        break
      case "niigata":
        id = 18
        break
      case "toyama":
        id = 19
        break
      case "ishikawa":
        id = 20
        break
      case "fukui":
        id = 21
        break
      case "yamanashi":
        id = 22
        break
      case "nagano":
        id = 23
        break
      case "gifu":
        id = 24
        break
      case "shizuoka":
        id = 25
        break
      case "aichi":
        id = 26
        break
      case "mie":
        id = 27
        break
      case "shiga":
        id = 28
        break
      case "kyoto":
        id = 29
        break
      case "osaka":
        id = 30
        break
      case "hyogo":
        id = 31
        break
      case "nara":
        id = 32
        break
      case "wakayama":
        id = 33
        break
      case "tottori":
        id = 34
        break
      case "shimane":
        id = 35
        break
      case "okayama":
        id = 36
        break
      case "hiroshima":
        id = 37
        break
      case "yamaguchi":
        id = 38
        break
      case "tokushima":
        id = 39
        break
      case "kagawa":
        id = 40
        break
      case "ehime":
        id = 41
        break
      case "kochi":
        id = 42
        break
      case "fukuoka":
        id = 43
        break
      case "saga":
        id = 44
        break
      case "nagasaki":
        id = 45
        break
      case "kumamoto":
        id = 46
        break
      case "oita":
        id = 47
        break
      case "miyazaki":
        id = 48
        break
      case "kagoshima":
        id = 49
        break
      case "okinawa":
        id = 50
        break
      }
      return id
    }
  }
}