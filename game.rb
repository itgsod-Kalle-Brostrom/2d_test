require 'chingu'

class Game < Chingu::Window

	def initialize
		super # Anropar metoden med samma namn i superklassen
		self.input = {esc: :exit}
		@player = Player.create
		Background.create
		5.times {Asteroid.create}
	end

	def update
		super
		Laser.each_bounding_circle_collision(Asteroid) do |laser, target|
      		laser.destroy
      		target.hide
      		Asteroid.create(x: rand($window.width), y: rand($window.height))
    	end
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
			holding_down: :down,
			space: :fire
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

	def fire
		Laser.create(x: @x, y: @y)
	end
end

class Laser < Chingu::GameObject
	has_traits :velocity, :collision_detection, :bounding_circle, :timer

	has_traits :velocity, :timer

	def setup
		@image = Gosu::Image["Laser.png"]
		self.velocity_y = -10
		Gosu::Sound["Laser.wav"].play
		after(5000) {self.destroy}
	end
end

class Background < Chingu::GameObject

	def setup
		@x, @y = 110,230
		@image = Gosu::Image["lala.png"]
		@zorder = 0
	end

end

class Asteroid < Chingu::GameObject
	has_traits :collision_detection, :bounding_circle, :velocity, :timer

	def setup
		@x = rand(800)
		@y = 100
		@rotation = rand()
		@velocity_y = rand()
		@velocity_x = rand()
		@image = Gosu::Image["Asteroid.png"]
	end

	def hide
		@x = -300
		@y = -300
		after(1000) do
			@x = rand(400) + 100
			@y = rand(300) + 100
		end
	end
end
Game.new.show
