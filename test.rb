#include the tuple class
load 'tuple.rb'
require 'date'

#an array that stores tuples that contain information for git commits
$log = Array.new
#a hash that maps a file to tuple that store a commit's information
$map = Hash.new
#the longest word in maps
$longest = 0

#parse the git log command by extracting datetime, SHA1 ID & author
def parse(commits)
  lines = commits.split("\n")
  info = Tuple.new

  #split the string into each line and according to the first word
  #push the respective values into a tuple (commit, author, date)
  lines.each do |w|
    first = w.split.first
    words = w.split.drop(1)
    
    if !words.last.nil? && (words.last.include? "<") 
      words = words.take(words.length - 1)
    end
    next_value = words.join(' ') 

    if first.eql? "commit"
      info.changeCommit(next_value[0..5])
    elsif first.eql? 'Author:'
      info.changeAuthor(next_value)
    elsif first.eql? 'Date:'
      #when there is a time value, push the tuple to the array of commits
      #and make info a new tuple
      info.changeDate(DateTime.parse(next_value))
      $log.push(info)
      info = Tuple.new
    end
  end

  $log.reverse!
end

#traverse through the latest commit and add files into map
#if and only if the file is not already in the list
def add_commit
  $log.each do |update|
    commit = `git show --name-only #{update.getCommit}`
    files = commit.split("\n").drop(6)

    files.each do |f|
      if !$map.has_key?(f)
        if f.length > $longest
          $longest = f.length
        end

        $map.store(f, update)
      end
    end

  end
end

#print hash
def print_hash
  for i in 0..$map.length
    key = $map.keys[i]
    value = $map.values[i]

    if(!(key.nil? || value.nil?))
      puts "#{value.getDate} [#{value.getCommit}]: #{key}" +
            " " * ($longest - key.length) +
            "(#{value.getAuthor})"
    end
  end
end

#def traverse(start)
#  Dir.foreach(start) do |x|
#    path = File.join(start, x)

#    if(x == '.' || x == '..')
#      next
#    elsif File.file?(path)

#    else
#      traverse(path)
#    end
#  end
#end

if(ARGV.length > 1)
  puts "There can only be one directory"
  exit 1
else
  target_path = ARGV.empty? ? Dir.pwd : ARGV[0]
  Dir.chdir(target_path)

  commits = `git log`
  parse(commits)
  add_commit
  puts $length
  print_hash
end
