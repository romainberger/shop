
# Helper functions

def name
  @name ||= Dir['*.gemspec'].first.split('.').first
end

def version
  line = File.read("lib/#{name}.rb")[/^\s*VERSION\s*=\s*.*/]
  line.match(/.*VERSION\s*=\s*['"](.*)['"]/)[1]
end

# Tasks

task :build do
  system "gem build #{name}.gemspec"
end

task :install do
  system "gem install #{name}-#{version}.gem"
end
