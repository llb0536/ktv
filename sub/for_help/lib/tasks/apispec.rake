if defined?(RSpec)
	require 'rspec/core'
	require 'rspec/core/rake_task'

	desc "Run all specs in apispec directory (excluding plugin specs)"
	RSpec::Core::RakeTask.new(:apispec) do |t|
	  t.rcov = false
	  t.rspec_path = 'rspec'
	  t.pattern = "./apispec/**/*_spec.rb"
	end
end
