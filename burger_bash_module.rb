
module BurgerBashMethods

	def cook_burgers(doneness, num)
		burger_doneness = nil
		# Ask the user how done they want their burger.
		type("How done do you want your burgers to be cooked? We serve our burgers "); trailing_and_or(doneness, "or"); type(".\n")
		# Code will loop until the user selects a valid doneness.	
		until burger_doneness != nil
			burger_doneness = gets.chomp.to_s.downcase
			# If the user's input is not an acceptable doneness...the doneness is reset and an error message is displayed, prompting the user to reenter the doneness.
			if (doneness.include? burger_doneness) == false
				burger_doneness = nil
				type("I'm sorry, but we don't serve our burgers that way. You can get them cooked "); trailing_and_or(doneness, "or"); type(".\n")
			else
				type("#{confirm_prefix}, #{num} #{burger_doneness} burgers.\n\n")
			end
		end
		burger_doneness
	end

	def get_cheese(cheese_types, burger_toppings)
		type("What kind of cheese do you want on your burgers? You can choose from "); trailing_and_or(cheese_types, "or"); type(", or say 'no cheese'.\n")
		cheese = nil
		until cheese != nil
			cheese = gets.chomp.to_s.capitalize!
			if cheese == "No cheese"
				type("Well, *I* think that's a mistake, but OK...\n")
			elsif (cheese_types.include? cheese) == false
				cheese = nil
				type("Sorry, we don't have that kind of cheese. Please say either 'no cheese' or pick from "); trailing_and_or(cheese_types, "or"); type(".\n")
			else
				type("#{confirm_prefix}, #{cheese}, got it!\n\n")
			end
		end
		if cheese == "No cheese"
			return
		else
			burger_toppings << "#{cheese} cheese"
		end
	end

	def burger_bash(number_of_orders)

		cooked_burgers = ["medium rare", "medium", "medium well", "well done"]
		cheeses_available = ["American", "Swiss", "Cheddar", "Bleu"]
		
		type("Thanks for calling Burger Bash! Your bash will be a smash with our burgers!\n")
		
		obtain_burgers = get_food

		food_quantity(number_of_orders, "burgers")

		burger_doneness = cook_burgers(cooked_burgers, number_of_orders)

		burger_toppings = get_toppings("burgers")

		get_cheese(cheeses_available, burger_toppings)

		order_confirmation(number_of_orders, obtain_burgers, "burgers", burger_doneness, burger_toppings)

	end

end