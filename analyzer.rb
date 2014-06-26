query = ARGV[0]

if ( query =~ /^play video/ )
  file_query = query.scan(/^play video (.*)/)

  command = "ruby fuzzy_file_search.rb ~/Videos #{file_query}"
  filename = %x[ #{command} ]

  filename.strip!
  
  command = "i3-msg workspace 6; exec vlc \"#{filename}\""

  puts "running #{command}"

  %x[ #{command} ] 
end