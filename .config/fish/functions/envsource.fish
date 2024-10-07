function envsource
	set lines (cat $argv | string split -n '\n' | string match -vre '^#')
	for line in $lines
		set var (string split -n -m 1 '=' $line)
		if test (count $var) -ne 2
			continue
		end
		set -gx $var[1] $var[2]
	end
end
