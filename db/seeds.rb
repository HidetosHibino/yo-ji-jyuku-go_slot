# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create!(
  email: 'user_for_seed@example.com',
  name: '管理人',
  password: 'password',
  password_confirmation: 'password'
)
basic_yojis = [
  { 'name' => '温故知新', 'sound' => 'おんこちしん', 'meaning' => '以前学んだことや、昔の事柄を今また調べなおしたり考えなおしたりして、新たに新しい道理や知識を探り当てること。' },
  { 'name' => '先憂後楽', 'sound' => 'せんゆうこうらく', 'meaning' => 'すぐれた為政者というものは、人々が心配し始める前に憂い、人々が楽しんだ後で自分も楽しむべきだということ。' },
  { 'name' => '千載一遇', 'sound' => 'せんさいいちぐう', 'meaning' => '千年に一度出会う、めったにないよい機会。' },
  { 'name' => '天衣無縫', 'sound' => 'てんいむほう', 'meaning' => '人柄が飾り気がなく、純真で無邪気なさま、天真爛漫らんまんなこと。' },
  { 'name' => '柳暗花明', 'sound' => 'りゅうあんかめい', 'meaning' => '春の野が花や緑に満ちて、美しい景色にあふれること' },
  { 'name' => '品行方正', 'sound' => 'ひんこうほうせい', 'meaning' => '行いがきちんとしていること。' },
  { 'name' => '立身出世', 'sound' => 'りっしんしゅっせ', 'meaning' => '世に出て認められること。' },
  { 'name' => '浅学非才', 'sound' => 'せんがくひさい', 'meaning' => '学識が足らないと、自分を謙遜して言う言葉。' },
  { 'name' => '鼓腹撃壌', 'sound' => 'こふくげきじょう', 'meaning' => '太平で安楽な生活を喜び楽しむさま。' },
  { 'name' => '酒池肉林', 'sound' => 'しゅちにくりん', 'meaning' => 'ぜいたくの限りを尽くした盛大な宴会。' },
  { 'name' => '悪逆無道', 'sound' => 'あくぎゃくむどう', 'meaning' => '人の道や道理に外れた、酷い悪事を行うこと。' },
  { 'name' => '自暴自棄', 'sound' => 'じぼうじき', 'meaning' => '自分の身を粗末に扱い、やけくそになること。' },
  { 'name' => '厚顔無恥', 'sound' => 'こうがんむち', 'meaning' => '厚かましい上に恥知らずなさま。' } ,
  { 'name' => '老少不定', 'sound' => 'ろうしょうふじょう', 'meaning' => '必ずしも老人が早く死に、若い者が後で死ぬとは定まってはいないという意味。' }
]

basic_yojis.each do |yoji|
  kanjis = yoji['name'].chars
  first_kanji = Kanji.find_or_create_by!(letter: kanjis[0])
  second_kanji = Kanji.find_or_create_by!(letter: kanjis[1])
  third_kanji = Kanji.find_or_create_by!(letter: kanjis[2])
  fourth_kanji = Kanji.find_or_create_by!(letter: kanjis[3])
  BasicYoji.create!(
    user: user,
    name: yoji['name'],
    sound: yoji['sound'],
    meaning: yoji['meaning'],
    first_kanji: first_kanji,
    second_kanji: second_kanji,
    third_kanji: third_kanji,
    fourth_kanji: fourth_kanji
  )
end

