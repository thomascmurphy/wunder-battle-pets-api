# This will do some example battles between already provisioned pets
task :battle_demo => :environment do |t, args|
  start_time = Time.now.utc
  puts "Starting the battle demo..."

  @ghost = {id: "c83a7893-6916-4a68-89fd-527565ca68c2", name: "Ghost", strength: 15, speed: 20, intelligence: 25, integrity: 100}
  @shaggydog = {id: "082abec6-e4c4-4bb9-b66f-6d89ffc1e8d3", name: "Shaggydog", strength: 20, speed: 15, intelligence: 10, integrity: 80}
  @discipline_turn_based =  Discipline.find_by(name: "turn_based")
  @discipline_pure_stats =  Discipline.find_by(name: "pure_stats")

  @temp_contest = Contest.create(pet_1_id: @ghost[:id], pet_2_id: @shaggydog[:id], discipline_id: @discipline_turn_based.id)
  @temp_contest.sync_pets(@ghost, @shaggydog)
  @turn_based_results = @temp_contest.battle

  @contest_pets = @turn_based_results[:pets]
  @contest_pets_string = @contest_pets.map{|p| "#{p[:name]}: (strength: #{p[:strength]}, speed: #{p[:speed]}, intelligence: #{p[:intelligence]}, integrity: #{p[:integrity]})"}.join(" and ") if @contest_pets.present?

  puts "Turn-based battle between #{@contest_pets_string}:"
  puts @discipline_turn_based.description
  @turn_based_results[:play_by_play].each do |play|
    puts play
  end


  @temp_contest.discipline_id = @discipline_pure_stats.id
  @pure_stats_results = @temp_contest.battle
  puts "Pure stats showoff between #{@contest_pets_string}:"
  puts @discipline_pure_stats.description
  @pure_stats_results[:play_by_play].each do |play|
    puts play
  end


  puts "Finished the battle demo...apparently Rickon should have spent more time training his direwolf and less time whining"
end