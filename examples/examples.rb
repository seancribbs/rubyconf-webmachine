(Dir["*.rb"].sort - [__FILE__]).each do |f|
  puts "Running #{f}..."
  system "bundle exec ruby #{f}"
  puts
end
