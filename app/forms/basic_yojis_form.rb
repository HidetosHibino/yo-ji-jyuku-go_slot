class BasicYojisForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_reader :basic_yoji

  attribute :name, :string
  attribute :sound, :string
  attribute :meaning, :string
  attribute :first_kanji_letter, :string
  attribute :second_kanji_letter, :string
  attribute :third_kanji_letter, :string
  attribute :fourth_kanji_letter, :string

  with_options presence: true do
    validates :name, format: { with: BasicYoji::VALID_NAME_STRING, message: :not_kanji_letter }, length: { is: BasicYoji::MOJI_NUM_LENGTH }
    validates :sound, format: { with: BasicYoji::VALID_SOUND_CHAR, message: :not_sound_hiragana }, allow_blank: true
    # name へのvalidationで十分かつ、画面上につらつら出てしまうので消去
    # validates :first_kanji_letter, format: { with: Kanji::VALID_LETTER_REGEX, message: :not_kanji_letter }, length: { is: 1 }
    # validates :second_kanji_letter, format: { with: Kanji::VALID_LETTER_REGEX, message: :not_kanji_letter }, length: { is: 1 }
    # validates :third_kanji_letter, format: { with: Kanji::VALID_LETTER_REGEX, message: :not_kanji_letter }, length: { is: 1 }
    # validates :fourth_kanji_letter, format: { with: Kanji::VALID_LETTER_REGEX, message: :not_kanji_letter }, length: { is: 1 }
  end

  # form で使う際に、BasicFromは常にnewしているため、method = postとなりupdateできない
  # persisted? メソッドをbasic_yojiに以上して、basic_yojiがあるかどうかでformのmethodを変えるようにする
  delegate :persisted?, to: :basic_yoji

  # 更新時に画面上でname,sound,meaningを出したいため、basic_yojiから移す
  # paramsの適用はsaveアクションで行う（上記をやると、super(params) を上書きしてしまうので）
  def initialize(basic_yoji)
    super()
    @basic_yoji = basic_yoji
    self.name = basic_yoji.name
    self.sound = basic_yoji.sound
    self.meaning = basic_yoji.meaning
  end

  def save(params)
    assign_attributes(params)
    kanjis = name.chars
    @basic_yoji.name = name
    @basic_yoji.sound = sound
    @basic_yoji.meaning = meaning
    # nameが4文字以下だとエラーになるので、一旦ここで弾く 一応4文字以上 or 漢字でないものが含まれている場合はここで止めれるはず
    return false unless valid?

    ActiveRecord::Base.transaction do
      first_kanji = Kanji.find_or_create_by(letter: kanjis[0])
      second_kanji = Kanji.find_or_create_by(letter: kanjis[1])
      third_kanji = Kanji.find_or_create_by(letter: kanjis[2])
      fourth_kanji = Kanji.find_or_create_by(letter: kanjis[3])

      return false unless valid?

      @basic_yoji.first_kanji = first_kanji
      @basic_yoji.second_kanji = second_kanji
      @basic_yoji.third_kanji = third_kanji
      @basic_yoji.fourth_kanji = fourth_kanji
      @basic_yoji.save!
    end
    true
  rescue StandardError => e
    Rails.logger.debug(e)
    false
  end
end
