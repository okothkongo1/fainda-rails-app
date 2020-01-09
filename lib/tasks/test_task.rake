namespace :test_task do
  task :linting_and_test =>
  [:rspec, :cucumber, :rubocop] do 
    puts "\e[32m Everything is ok now you can push your work"
  end
 task :rspec do 
  puts "\e[33m rspec is now running"
     sh "rspec"
    end
 
    task :rubocop do 
    puts "\e[33m rubocop is now running"
     sh "rubocop --lint"
    end
    task :cucumber do 
       puts "\e[33m cucumber is now running"
     sh "cucumber"
    end


end
