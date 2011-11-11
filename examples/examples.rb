DIR = File.dirname(__FILE__)
EXFILE = File.expand_path(__FILE__)
Dir.chdir(DIR) do
  Dir["*.rb"].each do |f|
    next if File.expand_path(f) == EXFILE
    puts "Running #{f}..."
    system "bundle exec ruby #{f}"
    puts
  end
end
