
module PartyPizzaMethods

	# This method is designed to sanitize the user's input for their pizza's size.
	# If they use recognized abbreviations, the method converts it to the appropriate word for validation and string statements.
	def pizza_size(typed_size)
		case typed_size
		when "s"
			typed_size = "small"
		when "m"
			typed_size = "medium"
		when "l"
			typed_size = "large"
		when "xl"
			typed_size = "extra large"
		end
		typed_size
	end

	def get_size(pizza_sizes, num)
		# Ask the user what size pizza they want to order.
		type("What size do you want? We make our pizzas "); trailing_and_or(pizza_sizes, "or"); type(".\n")
		size = nil
		# Code will loop until the user selects a valid size.
		until size != nil
			# User input converted to string and downcased, then run through sanitation & conversion method 'pizza_size'.
			size = pizza_size(gets.chomp.to_s.downcase)
			# If the user's input is not an acceptable size...the size is reset and an error message is displayed, prompting the user to reenter the size.
			if (pizza_sizes.include? size) == false
				size = nil
				type("I'm sorry, but that's not one of our sizes. We only make our pizzas "); trailing_and_or(pizza_sizes, "or"); type(".\n")
			else
				type("#{confirm_prefix}, #{num} #{size} pizzas.\n\n")
			end
		end
		size
	end

	def party_pizza(number_of_orders)
		# Variable initialization
		pizza_sizes_available = ["small", "medium", "large", "extra large"]
		# pizza_toppings_available = ["pepperoni", "mushrooms", "olives", "onions", "bacon", "sausage", "green peppers", "extra cheese"]

		type("Thanks for calling Party Pizza, where a party is only a pizza away!\n")
		
		obtain_pizzas = get_food

		food_quantity(number_of_orders, "pizzas")

		pizza_size = get_size(pizza_sizes_available, number_of_orders)

		# Ask user for what toppings they want on their pizza, list allowable toppings, and prompt user that they're allowed up to 4 toppings.
		pizza_toppings = get_toppings("pizzas")

		order_confirmation(number_of_orders, obtain_pizzas, "pizzas", pizza_size, pizza_toppings)

	end

end