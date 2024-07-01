# My 1337 Slurm scripts, I run this as part of my .bashrc startup file so they're always available
# These assume everything is getting saved in the format "logs/output-<jobcode>"

alias myjobs='sacct -u lip21jaf -X -S2023-09-15-10:30 -o JobID,JobName,State,Start,Elapsed'
alias runningjobid='sacct -u lip21jaf --noheader -s r -o JobID -X'
alias tailjob='tail -f $(ls logs/*$(lastjobid))'
alias lastjobid='sacct -u lip21jaf --noheader -o JobID,JobName -X -P | grep -v "bash" | tail -1 |cut -d "|" -f 1'
alias lastlogs='less $(ls logs/*$(lastjobid))'

# I run this script as part of .bashrc