
module FoodFinderMethods

  def call_in(restaurant, party_size)
    type("Well, let's hope that #{restaurant} is still taking orders...\n\n")
    type("riiiiiiiiiiiiiiiing...\n")
    sleep(1)
    type("riiiiiiiiiiiiiiiing...\n")
    sleep(1)
    type("riiiiiiiiiiiiiii")
    puts "--\*click\*"
    sleep(1.5)
    puts ""

    case restaurant
    when "Party Pizza"
      order = party_pizza(party_size)
    when "Burger Bash"
      order = burger_bash(party_size)
    when "Taco Town"
      order = taco_town(party_size)
    else
      type("ERROR!! You somehow got past the validation.")
    end
    order
  end

  def check_group_size_hash(group_size)
    group_size_hash = {two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9, ten: 10, eleven: 11, twelve: 12, thirteen: 13, fourteen: 14, fifteen: 15, sixteen: 16, seventeen: 17}
    if group_size_hash.include? group_size.to_sym
      group_size = group_size_hash.fetch(group_size.to_sym)
    else
      group_size = group_size.to_i
    end
  end


  def confirm_prefix
    ["OK", "Alright", "Gotcha", "Cool", "Mhmm", "Sure"].sample
  end

  def end_call(restaurant)
    case restaurant
    when "Party Pizza"
      type("Thanks for partying with Party Pizza!\n")
    when "Burger Bash"
      type("Thanks for bashing it out with Burger Bash!\n")
    when "Taco Town"
      type("Thanks for coming down to Taco Town!\n")
    else
      "ERROR!! You somehow got past the validation."
    end
    print "*click*\n\n"
    sleep(1)
  end

  def food_quantity(order_count, food)
    type("How many #{food} do you want? #{order_count} #{food}? And they're all going to be the same? Sure thing!\n\n")
    sleep(0.5)
  end

  def get_food
    type("Will this be for pickup or delivery?\n")
    obtain_food = nil
    # Code will loop until user selects how they will get their food.
    until obtain_food != nil
      # Get the user's input
      obtain_food = (gets.chomp.to_s.downcase)
      # If the user selects "delivery", display a confirmation message.
      if obtain_food == "delivery"
        type("#{confirm_prefix}, we have your address as the Wyncode Academy in Fort Lauderdale.\n\n")
      # If the user selects "pickup" or "carryout", display a confirmation message.
      elsif ["pickup", "carryout"].include? obtain_food
        type("#{confirm_prefix}, we'll hold it here for you to come get.\n\n")
      # If the user doesn't pick a valid option, reset their input and display an error message.
      else
        obtain_food = nil
        type("Can you say that again? I didn't catch if you wanted pickup or delivery.\n")
      end
    end
    obtain_food
  end

  def get_group(group_size)
    wyncode_class = ["Juan", "Serena", "David", "Kevin", "Daniel", "Deanna", "Don", "Deven", "Paul", "Deri", "Jaime", "Brian", "Timothy", "Bryan", "Gregory", "Jasmine"]
    wyncode_class.shuffle[0..(group_size - 2)]
  end

  def get_group_preferences(group_size, food)
    group = get_group(group_size)
    group_preferences = []
    group.length.times do |i|
      hash = {}
      hash[:name] = group[i]
      a = get_toppings_by_food(food.to_sym).shuffle
      hash[:likes] = a.first
      hash[:dislikes] = a.last
      group_preferences << hash
    end
    group_preferences
  end

  # This method will capture the number of people in the user's group.
  def get_group_size
    type("They're about to close! OK, executive decision: everyone's getting the same thing.\n\nHow many people are in your group (including you)?\n")
    # Initialize group_size as 'nil'
    group_size = nil
    # Keep looping until we have an acceptable value for group_size.
    until group_size != nil
      # Validate and sanitize the user's input against a simple text-to-int hash.
      group_size = check_group_size_hash(gets.chomp)
      # If there's less than two people in the group...
      if group_size < 2
        # ...reset group_size and prompt the user to enter another value.
        group_size = nil
        type("You've got to have at least one other person in a group with you!\n")
      # If group_size is larger than 16 people...
      elsif group_size > 16
        # ...reset group_size and prompt the user to enter another value.
        group_size = nil
        type("What? There's only 16 people in your class! Seriously, how many people are in your group, including you?\n")
      # Otherwise, accept the value and pass it back.
      else
        type("#{group_size} people, got it. ")
      end
    end
    group_size
  end

  def get_toppings(food)
    # Initialize method variables
    toppings_list = get_toppings_by_food(food)
    toppings = []
    topping_chosen = nil

    # Ask user for what toppings they want on their food, list allowable toppings, and prompt user that they're allowed up to 4 toppings.
    type("What toppings would you like on your #{food}? You can have up to 4 toppings.\n")
    type("Please choose a topping from "); trailing_and_or(toppings_list, "and"); type(".\nIf you don't want any, say 'no toppings'.\n")

    # Keep looping until "no topping" or "done" is input
    until ["no toppings", "done"].include? topping_chosen
      # Capture the user's topping choice
      topping_chosen = (gets.chomp.to_s.downcase)
      # If the user's topping choice is one of the available toppings...
      if ["no toppings", "done"].include? topping_chosen
        if toppings.length == 0
          type("Nothing? Well, our plain #{food} is what we're known for!\n\n")
        else
          type("#{confirm_prefix}, so you want "); trailing_and_or(toppings, "and"); type(" on these, right? Great!\n\n")
        end
      elsif toppings_list.include? topping_chosen
        if toppings.include? topping_chosen
          type("We're already putting that on your #{food}. Please type 'done', or select from "); trailing_and_or(toppings_list - toppings, "and"); type(".\n")
        else
          # ...we add it to their toppings.
          toppings << topping_chosen
          # If there are now 4 toppings, we notify the customer and set the topping to the sentinel to exit the loop.
          if toppings.length == 4
            type("#{confirm_prefix}, and with #{topping_chosen}, that makes 4 toppings!\n\n")
            topping_chosen = "done"
          # Otherwise, we ask for the next topping.
          else
            type("#{confirm_prefix}, we'll put #{topping_chosen} on your #{food}. What else?\n")
            type("Type 'done' to finish your #{food}, or select another topping.\n")#from "); trailing_and_or(toppings_list - toppings, "and"); type(".\n")
          end
        end
      # Otherwise, if the user's topping choice isn't one of the available toppings, we display an error message and ask for input again.
      else
        type("I'm sorry, but we don't carry that. Please choose a topping from our available menu, or say #{get_toppings_length(toppings)}:\n")
        type("We still have "); trailing_and_or(toppings_list - toppings, "and"); type(" available.\n")
      end
    end
    toppings
  end

  def get_toppings_by_food(food)
    all_toppings_list = {
      burgers: ["lettuce", "tomatoes", "onions", "mushrooms", "bacon", "jalapeno peppers", "pickles", "ketchup", "mustard", "mayonnaise"],
      pizzas: ["pepperoni", "mushrooms", "olives", "onions", "garlic", "bacon", "sausage", "green peppers", "extra cheese"],
      tacos: ["lettuce", "tomatoes", "onions", "sour cream", "guacamole", "queso", "olives", "jalapeno peppers", "bacon", "refried beans"]
    }
    all_toppings_list.fetch(food.to_sym)
  end

  def get_toppings_length(toppings)
    if toppings.length == 0
      "'no toppings'"
    else
      "'done'"
    end
  end

  def group_reaction(group_pref, food, food_toppings, food_acquisition)
    type("  .  .  .  .  .  .\n")
    if food_acquisition == "delivery"
      type("Thirty minutes on the dot. You're not sure how they did it, but your #{food} arrived right on time.\n")
    else
      type("Forget thirty minutes, you left the moment you got off the phone. As soon as your #{food} are ready, you hurry back to Wyncode to feed your group.\n")
    end
    type("You sink your teeth into your #{food}, enjoying every last morsel.\nNaturally, you ordered all of your favorite toppings: "); trailing_and_or(food_toppings, "and")
    type(".\nBut what about your group? You slowly turn to face them, anxiously awaiting their reaction...\n\n")
    group_pref.each do |group_pref|
      if (food_toppings.include? group_pref[:likes]) && (food_toppings.include? group_pref[:dislikes])
        type("...#{group_pref[:name]} is simultaneously overjoyed with the #{group_pref[:likes]} and disgusted by the #{group_pref[:dislikes]}! ")
        type("Confused and mouth agape, the #{(food[0...-1])} falls from their hands and mouth and onto the floor.\n")
      elsif food_toppings.include? group_pref[:likes]
        type("...#{group_pref[:name]} is estatic with the #{group_pref[:likes]} on the #{(food[0...-1])}!\n")
      elsif food_toppings.include? group_pref[:dislikes]
        type("...#{group_pref[:name]} is revolted by the #{group_pref[:dislikes]} on the #{(food[0...-1])}!\n")
      else
        type("...#{group_pref[:name]} ate the #{(food[0...-1])} appreciatively.\n")
      end
    end
  end

  def intro
    type("Time: Saturday night...\n")
    sleep(1)
    type("Location: Wyncode Academy...\n")
    sleep(1)
    puts ""
    type("You and your group have been coding up a storm! So much so that you didn't even realize it's almost midnight!\n")
    type("Everyone's hungry, but no one wants to stop working. You've been volun-told to get food for everyone.\n")
  end

  def order_confirmation(number_of_orders, food_acquisition, food_type, food_modifier, food_toppings)
    # Return to user their input: doneness of burger, toppings on burger, and method of obtaining burger.
    type("So, I've got #{number_of_orders} #{food_modifier} #{food_type} for #{food_acquisition} with ")
    if food_toppings.length == 0
      type("nothing")
    else
      trailing_and_or(food_toppings, "and")
    end
    type(" on them.\n")
    if food_acquisition == "delivery"
      type("We'll send your #{food_type} to the Wyncode Academy in about half an hour.\n")
    else
      type("Your #{food_type} will be ready for for pickup in about half an hour.\n")
    end
    [food_type, food_modifier, food_toppings, food_acquisition]
  end

  def restaurant_check(typed_choice)
    case typed_choice
    when "Pizza"
      typed_choice = "Party Pizza"
    when "Burger", "Burgers"
      typed_choice = "Burger Bash"
    when "Taco", "Tacos"
      typed_choice = "Taco Town"
    end
    typed_choice
  end

  def restaurant_choice
    restaurants = ["Party Pizza", "Burger Bash", "Taco Town"]
    type("Your choices are limited... Do you want to order from "); trailing_and_or(restaurants, "or"); type("?\n")
    food_choice = restaurant_check(gets.chomp.to_s.downcase.split(' ').collect! {|x| x.capitalize}.join(' '))
    until restaurants.include? food_choice
      type("#{food_choice} isn't open this late. The only places open at this hour are "); trailing_and_or(restaurants, "or"); type(".\n")
      food_choice = restaurant_check(gets.chomp.to_s.downcase.split(' ').collect! {|x| x.capitalize}.join(' '))
    end
    food_choice
  end

  # This will accept any array and return each element delimited by commas, except the last one, which will be preceeded by "and" and end with a period.
  def trailing_and_or(array, bool_op)
    array.each do |a|
      # If the array has only one or no elements, it will return just the one element (or nothing).
      if array.length < 2
        type("#{a}")
      # Otherwise, it runs as intended.
      elsif array.length > 2
        if a == array.last
          type("#{bool_op} #{a}")
        else
          type("#{a}, ")
        end
      else
        if a == array.last
          type("#{bool_op} #{a}")
        else
          type("#{a} ")
        end
      end
    end
  end

  # This method will accept a string input and will print it one character at a time, instead of all at once.
  # If punctuation is used, the method will slow down the text crawl appropirately, to mimic human speech.
  def type(text)
    text.to_s.each_char do |x|
      print x
      case x
      when ",", ";", ":"
        sleep(0.15)
      when ".", "!", "?"
        sleep(0.325)
      else
        sleep(0.0175)
      end
    end
  end

end