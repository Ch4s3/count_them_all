require "rubygems"
require "csv"

def count_them_all
  votes_array = []
  csv_path = Dir.glob("*csv").first
  no_csv_warning = "There is no csv!"
  if csv_path.nil?
    puts no_csv_warning
    return nil
  end

  CSV.foreach(csv_path, headers: true, encoding: "ISO-8859-1") do |row|
    if row[2].downcase == "i did not submit a project"
      votes_array << row[3]
    elsif row[2] == row[3]
      puts "OH NO! someone voted for their own team! Vote tossed!"
    else
      puts "A vote for #{row[3]}"
      votes_array << row[3]
    end
  end
  print_winner(votes_array)
end

def find_winner(votes_array)
  sorted = votes_array.group_by(&:itself).values.sort_by(&:size).reverse
  p "Sorted Totals: " + sorted.to_s
  if sorted[0].count == sorted[1].count
    if sorted[1].count == sorted[2].count
      return "MANUAL RECOUNT"
    else
      return "Tie between " + sorted[0][0] + " and " + sorted[1][0]
    end
  else
    return sorted.first[0]
  end
end

def print_winner(votes_array)
  winner = find_winner(votes_array)

  print "The WINNER of the Participant Favorite is"
  10.times do
    sleep(0.3)
    puts "..."
  end
  puts " #{winner}"
end

count_them_all
