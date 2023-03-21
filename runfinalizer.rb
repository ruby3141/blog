begin
	require "./_submodules/finalizer/finalizer.rb"
rescue LoadError
	puts "It seems submodule is not cloned correctly."
	puts "Try \"git pull --recurse-submodule\"."
end