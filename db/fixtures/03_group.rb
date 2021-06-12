require './db/support/category_find'

groups = [
  # 青森3部
  { id: find_category_id('青森', '3部'), name: %w[EAST WEST] },
  # 岩手2部、3部
  { id: find_category_id('岩手', 'D2'), name: %w[A B] },
  { id: find_category_id('岩手', 'D3'), name: %w[中部 北部 南部 サテライト] },
  # 宮城3部
  { id: find_category_id('宮城', 'M3'), name: %w[A B C D] },
  # 秋田3部
  { id: find_category_id('秋田', '3部'), name: %w[A B] },
  # 山形2部、3部
  { id: find_category_id('山形', '2部'), name: %w[A B] },
  { id: find_category_id('山形', '3部'), name: %w[A B C D E] },
  # 福島3部
  { id: find_category_id('福島', 'F3'), name: %w[県北 県南 会津 相双 いわき] },
  # 茨城3部、4部
  { id: find_category_id('茨城', '3部'), name: %w[A B] },
  { id: find_category_id('茨城', '4部'), name: %w[EAST WEST_A WEST_B SOUTH_A SOUTH_B SOUTH_C NORTH_A NORTH_B CENTRAL_A CENTRAL_B CENTRAL_C] },
  # 栃木2部、3部
  { id: find_category_id('栃木', '2部'), name: %w[A B] },
  { id: find_category_id('栃木', '3部'), name: %w[A B C D E F] },
  # 群馬2部、3部
  { id: find_category_id('群馬', '2部'), name: %w[A B] },
  { id: find_category_id('群馬', '3部'), name: %w[A B C D E F] },
  # 埼玉2部、支部
  { id: find_category_id('埼玉', 'S2'), name: %w[A B] },
  { id: find_category_id('埼玉', '東部支部SE2'), name: %w[A B] },
  { id: find_category_id('埼玉', '東部支部SE3'), name: %w[A B C] },
  { id: find_category_id('埼玉', '西部支部2W'), name: %w[A B] },
  { id: find_category_id('埼玉', '西部支部3W'), name: %w[A B C] },
  { id: find_category_id('埼玉', '南部支部SS2'), name: %w[A B] },
  { id: find_category_id('埼玉', '南部支部SS3'), name: %w[A B] },
  # 千葉2部、3部、4部、5部
  { id: find_category_id('千葉', '2部'), name: %w[A B] },
  { id: find_category_id('千葉', '3部'), name: %w[A B C] },
  { id: find_category_id('千葉', '4部'), name: ('A'..'K').to_a },
  { id: find_category_id('千葉', '5部'), name: (1..20).to_a },
  # 東京3部、4部
  { id: find_category_id('東京', 'T3'), name: %w[A B] },
  { id: find_category_id('東京', 'T4'), name: %w[A B] },
  # 神奈川3部、4部
  { id: find_category_id('神奈川', 'K3'), name: %w[A B C D] },
  { id: find_category_id('神奈川', 'K4'), name: ('A'..'Z').to_a.push('α', 'β') },
  # 新潟2部、3部、4部
  { id: find_category_id('新潟', '2部'), name: %w[A B] },
  { id: find_category_id('新潟', '3部'), name: %w[A B] },
  { id: find_category_id('新潟', '4部'), name: %w[A B C D] },
  # 富山3部、4部
  { id: find_category_id('富山', 'T3'), name: %w[A B] },
  { id: find_category_id('富山', 'T4'), name: %w[A B] },
  # 石川3部、4部
  { id: find_category_id('石川', '3部'), name: %w[A B] },
  { id: find_category_id('石川', '4部'), name: %w[A B] },
  # 長野2部、3部、4部
  { id: find_category_id('長野', '2部'), name: %w[A B] },
  { id: find_category_id('長野', '3部'), name: %w[A B C] },
  { id: find_category_id('長野', '4部'), name: %w[北信地区A 北信地区B 東信地区 中信地区A 中信地区B 中信地区C 南信地区A 南信地区B] },
  # 岐阜3部
  { id: find_category_id('岐阜', 'G3'), name: ('A'..'H').to_a },
  # 愛知3部、4部、地区
  { id: find_category_id('愛知', '3部'), name: %w[A B] },
  { id: find_category_id('愛知', '4部'), name: %w[A B] },
  { id: find_category_id('愛知', '西尾張2部'), name: %w[A B] },
  { id: find_category_id('愛知', '東尾張2部'), name: %w[A B] },
  { id: find_category_id('愛知', '名古屋1部'), name: %w[A B] },
  { id: find_category_id('愛知', '名古屋2部'), name: %w[A B] },
  { id: find_category_id('愛知', '西三河3部'), name: %w[A B] },
  # 三重2部、3部
  { id: find_category_id('三重', '2部'), name: %w[A B] },
  { id: find_category_id('三重', '3部'), name: %w[A B C D] },
  # 滋賀3部
  { id: find_category_id('滋賀', '3部'), name: %w[A B C D] },
  # 京都2部、3部
  { id: find_category_id('京都', '3部'), name: %w[A B] },
  { id: find_category_id('京都', '3部'), name: ('A'..'L').to_a },
  # 大阪2部、3部、4部
  { id: find_category_id('大阪', '2部'), name: %w[A B] },
  { id: find_category_id('大阪', '3部'), name: %w[A B C D] },
  { id: find_category_id('大阪', '4部'), name: %w[豊能・三島A 豊能・三島B 豊能・三島C 豊能・三島D 中河内・南河内A 中河内・南河内B 中河内・南河内C 中河内・南河内D 中河内・南河内E
                                                  北河内・大阪市A 北河内・大阪市B 北河内・大阪市C 北河内・大阪市D 北河内・大阪市E 南大阪A 南大阪B 南大阪C 南大阪D 南大阪E] },
  # 兵庫地区リーグ
  { id: find_category_id('兵庫', '神戸3部'), name: %w[A B] },
  { id: find_category_id('兵庫', '東播2部'), name: %w[A B] },
  # 奈良3部
  { id: find_category_id('奈良', '3部'), name: %w[A B C] },
  # 鳥取3部
  { id: find_category_id('鳥取', '3部'), name: %w[EAST WEST] },
  # 島根3部
  { id: find_category_id('島根', '3部'), name: %w[東部A 東部B 東部C] },
  # 広島3部、4部、5部
  { id: find_category_id('広島', '3部'), name: %w[A B C] },
  { id: find_category_id('広島', '4部'), name: %w[A B C D] },
  { id: find_category_id('広島', '5部'), name: %w[A B C D E F] },
  # 山口4部
  { id: find_category_id('山口', '4部'), name: %w[EAST WEST] },
  # 徳島3部
  { id: find_category_id('徳島', 'T3'), name: %w[S C W] },
  # 香川3部
  { id: find_category_id('香川', '3部'), name: %w[A B C] },
  # 愛媛2部、3部
  { id: find_category_id('愛媛', 'E2'), name: %w[A B] },
  { id: find_category_id('愛媛', 'E3'), name: %w[東予A 東予B 中予A 中予B 南予] },
  # 高知3部
  { id: find_category_id('高知', '3部'), name: %w[A B C D] },
  # 福岡2部、3部
  { id: find_category_id('福岡', '2部'), name: %w[A B] },
  { id: find_category_id('福岡', '3部'), name: ('A'..'I').to_a },
  # 佐賀2部、3部
  { id: find_category_id('佐賀', '2部'), name: %w[A B] },
  { id: find_category_id('佐賀', '3部'), name: %w[A B] },
  # 長崎2部
  { id: find_category_id('長崎', '2部'), name: %w[A B] },
  # 熊本3部
  { id: find_category_id('熊本', '3部'), name: ('A'..'H').to_a },
  # 大分3部
  { id: find_category_id('大分', '3部'), name: %w[A B C] },
  # 宮崎U-16
  { id: find_category_id('宮崎', 'U-16'), name: %w[A B] },
  # 沖縄3部
  { id: find_category_id('沖縄', '3部'), name: %w[A B] },
]

# グループのあるカテゴリのID
ids = groups.map { |group| group[:id] }

Category.count.times do |index|
  num = index + 1
  if !ids.include?(num)
    Group.seed(
      category_id: num
    )
  else
    group = groups.find { |group| group[:id] == num }
    group[:name].each do |name|
      Group.seed(
        category_id: group[:id],
        name: name
      )
    end
  end
end

