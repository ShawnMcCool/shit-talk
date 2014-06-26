require 'fuzzystringmatch'
require 'find'
require 'pathname'

dir = ARGV[0]
query = ARGV[1]

query = query.downcase
matcher = FuzzyStringMatch::JaroWinkler.create(:native)

files = []

Find.find(dir) { |e| files.push(e) if ! File.directory?(e) }

abort "no files found in path" if files.empty? 

scored_files = Hash.new

files.each do |fullpath|
	filename = Pathname.new(fullpath).sub_ext('').basename.to_s#basename.to_s
	filename = filename.downcase.gsub(/[^[[:word:]]\s]/, ' ')
	filename = filename.gsub(/\d/, '')
	filename.strip!
	
	next if filename.empty?

	score = matcher.getDistance(filename, query)
	scored_files[fullpath] = score;
end

# sort by score
scored_files = scored_files.sort_by {|k,v| v}.reverse

path, score = scored_files.first

puts path