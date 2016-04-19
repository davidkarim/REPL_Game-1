
require "./food_finder_module.rb"
include FoodFinderMethods
require "./party_pizza_module.rb"
include PartyPizzaMethods
require "./burger_bash_module.rb"
include BurgerBashMethods
require "./taco_town_module.rb"
include TacoTownBashMethods

intro

food_choice = restaurant_choice

group_size = get_group_size

order = call_in(food_choice, group_size)

end_call(food_choice)

group_preferences = get_group_preferences(group_size, order[0])

group_reaction(group_preferences, order[0], order[2], order[3])