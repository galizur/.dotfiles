function ssh_gen
	if string length -q -- $argv[1]
		ssh-keygen -t ed25519 -C $EMAIL -f $XDG_DATA_HOME/ssh/keys/$argv[1]
	else
		echo You must provide a file name.
	end
end
