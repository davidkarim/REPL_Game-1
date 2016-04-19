
module TacoTownBashMethods

	def salsa_heat(spice, num)
		heat_level = nil
		# Ask the user how spicy they want their tacos.
		type("How spicy do you want your taco salsa? We have "); trailing_and_or(spice, "or"); type(".\n")
		# Code will loop until the user selects a valid spice.	
		until heat_level != nil
			heat_level = gets.chomp.to_s.downcase
			# If the user's input is not an acceptable spice level...the spiciness is reset and an error message is displayed, prompting the user to reenter the spiciness.
			if (spice.include? heat_level) == false
				heat_level = nil
				type("I'm sorry, but we don't serve our tacos that way. You can get them with "); trailing_and_or(spice, "or"); type(" salsa.\n")
			else
				type("#{confirm_prefix}, #{num} #{heat_level} tacos.\n\n")
			end
		end
		heat_level
	end

	def taco_town(number_of_orders)

		taco_heat = ["mild", "medium", "hot", "muy caliente"]
		
		type("Hola! Thank you for calling Taco Town, the best around! Go to town on our tacos!\n")
		
		obtain_tacos = get_food

		food_quantity(number_of_orders, "tacos")

		taco_spice = salsa_heat(taco_heat, number_of_orders)

		taco_toppings = get_toppings("tacos")

		order_confirmation(number_of_orders, obtain_tacos, "tacos", taco_spice, taco_toppings)

	end

end