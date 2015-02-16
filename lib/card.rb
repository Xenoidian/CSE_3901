class Card
	#the config class is so we can have all the options at our finger tips
	#this can also be used when we are getting the user input to check against
	class Config

		@@numbers =	['one', 	'two', 		'three']
		@@symbols = 	['diamond', 	'squiggle', 	'oval']
		@@shadings = 	['solid', 	'striped', 	'open']
		@@colors =   	['red', 	'green', 	'purple']


		def self.numbers; @@numbers; end
		def self.symbols; @@symbols; end
		def self.shadings; @@shadings; end
		def self.colors; @@colors; end
	end

	attr_reader :number
	attr_reader :symbol
	attr_reader :shading
	attr_reader :color

	def number=(number)
		raise ArgumentError, "The number is not in the config" unless Card::Config.numbers.include? number
		@number = number
	end

	def symbol=(symbol)
		raise ArgumentError, "The symbol is not in the config" unless Card::Config.symbols.include? symbol
		@symbol = symbol
	end

	def shading=(shading)
		raise ArgumentError, "The shading is not in the config" unless Card::Config.shadings.include? shading
		@shading = shading
	end

	def color=(color)
		raise ArgumentError, "The color is not in the config" unless Card::Config.colors.include? color
		@color = color
	end

	def state
		self.instance_variables.map { |variable| self.instance_variable_get variable }
	end

	#class member method
	def self.create_with_attributes (number, symbol, shading, color)
		new_card = Card.new
		
		new_card.number = number
		new_card.symbol = symbol
		new_card.shading = shading
		new_card.color = color
		
		new_card
	end

	#this funciton is used for equality of two cards
	def ==(o)
		o.class == self.class && o.state == self.state
	end

	#this function is used to convert the object
	#to a hash.
	def to_h
		{
			:number => @number,
			:symbol => @symbol,
			:shading => @shading,
			:color => @color
		}
	end
end

if __FILE__ == $0
	#Instanciating a new instance
	my_card = Card.new
	
	#Setting the variables and getting the instance variables
	my_card.number = "one"
	puts my_card.number

	# or a better way would be
	my_card.number = Card::Config.numbers[0] # this will assign "one" to it

	#You can do the same for all other intance variables
	my_card.symbol = Card::Config.symbols[0] # this will assign "diamond" to it
	my_card.shading = Card::Config.shadings[0] # this will assign "solid" to it
	my_card.color = Card::Config.colors[0] # this will assign "red" to it


	#creating a deck of cards
	deck_of_cards = []
	Card::Config.numbers.each do |number|
		Card::Config.symbols.each do |symbol|
			Card::Config.shadings.each do |shading|
				Card::Config.colors.each do |color|
					#insert the newly created card into the deck of cards
					deck_of_cards << Card.create_with_attributes(number, symbol, shading, color)
				end
			end
		end
	end

	#printing the cards on the screen
	
	#printing the header
	puts ["Number".ljust(10), "Symbol".ljust(10), "Shading".ljust(10), "Color".ljust(10)].join(" ")
	puts '-'*45

	#printing the body of the table	
	deck_of_cards.each do |card|
		#this is going to print a bunch of stuff but you get the idea
		puts [card.number.ljust(10), card.symbol.ljust(10), card.shading.ljust(10), card.color.ljust(10)].join(" ")
	end

	my_card.state
	another_card = Card.create_with_attributes("one", "diamond", "solid", "red")

	puts my_card == another_card
end
