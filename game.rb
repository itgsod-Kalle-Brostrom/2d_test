require 'chingu'

class Game < Chingu::Window

	def initialize
		super # Anropar metoden med samma namn i superklassen
		self.input = {esc: :exit}
		Player.create
	end
end

class Player < Chingu::GameObject

	def setup
		@x = 400
		@y = 300
		@image = Gosu::Image["Ship.png"]
		self.input = {
			holding_left: :left,
			holding_right: :right,
			holding_up: :up,
			holding_down: :down
		}
	end

	def left
		@x -= 5
	end

	def right
		@x += 5
	end
	
	def up
		@y -= 5
	end

	def down
		@y += 5
	end


end

Game.new.show
