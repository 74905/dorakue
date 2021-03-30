class Brave
 attr_reader :name, :offence, :defence
 attr_accessor :hp
 SPECIAL_ATTACK_CONSTANT = 1.5
    def initialize(**params)
    @name = params[:name]
    @hp =  params[:hp]
    @offence =  params[:offence]
    @defence =  params[:defence]
    end

    def attack(monster)
      puts "#{@name}の攻撃"
      attack_num = rand(4)
        if attack_num == 0
          puts "必殺攻撃"
          damage = calculate_special_attack - monster.defence
        else
          puts "通常攻撃"
          damage = @offence - monster.defence
        end
      monster.hp -= damage
      puts "#{monster.name}は#{damage}のダメージを受けた"
      puts "#{monster.name}の残りHPは#{monster.hp}だ"
    end

    def calculate_special_attack
      @offence * SPECIAL_ATTACK_CONSTANT
    end
end

class Monster
  attr_reader :offence, :defence
  attr_accessor :hp, :name
  SPECIAL_ATTACK_CONSTANT = 1.5
  CALC_HALF_HP = 0.5
  MONSTER_ATTACK = 1.5
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offence = params[:offence]
    @defence = params[:defence]
    @transform_flag = false
    @trigger_transform = params[:hp] * CALC_HALF_HP 
  end
  
  def attack(brave)
      if @transform_flag == false && @trigger_transform >= @hp
          @transform_flag = true
           transform
      end
      damage = @offence - brave.defence
      puts "#{@name}の攻撃"

      brave.hp -= damage

      puts "#{brave.name}は#{damage}のダメージを受けた"
      puts "テリーの残りHPは#{brave.hp}"
  end


  def calculate_special_attack
    @offence * SPECIAL_ATTACK_CONSTANT
  end
private
  def transform
    transform_name = "ドラゴン"
    puts "#{@name}は怒っている"
    puts "#{@name}は#{transform_name}に変化した"
    @name = transform_name
    @offence *= MONSTER_ATTACK
  end
end

brave = Brave.new(name:"テリー", hp:500, offence:150, defence:100)
monster = Monster.new(name: "スライム", hp: 250, offence: 200, defence: 100)

brave.attack(monster)
monster.attack(brave)