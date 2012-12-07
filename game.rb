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



	end


end

Game.new.show
