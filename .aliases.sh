# My leet Slurm scripts, I run this as part of my .bashrc startup file so they're always available
# These assume everything is getting saved in the format "logs/output-<jobcode>"

# This one just displays your job history. Quick way to see the state of your latest job.
alias myjobs='sacct -u lip21jaf -X -S2024-06-01-00:00 -o JobID,JobName,State,Start,Elapsed'

alias runningjobid='sacct -u lip21jaf --noheader -s r -o JobID -X'
alias lastjobid='sacct -u lip21jaf --noheader -o JobID,JobName -X -P | grep -v "bash" | tail -1 |cut -d "|" -f 1'

# Display the logs of the currently running job as it runs:
alias tailjob='tail -f $(ls logs/*$(lastjobid))'
alias lastjobout='less $(ls logs/*$(lastjobid))'

# I can never remember these. Time limit to avoid hogging resources (or being penalised for overuse)
alias int_session='srun --mem=16G --time=2:00:00 --pty bash -i'
alias gpu_session='srun --mem=16G --qos=gpu --partition=gpu --gpus-per-node=1 --time=2:00:00 --pty bash -i'
