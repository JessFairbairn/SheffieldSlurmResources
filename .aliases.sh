# My leet Slurm scripts, I run this as part of my .bashrc startup file so they're always available

# This one just displays your job history. Quick way to see the state of your latest job. 
alias myjobs='sacct -u $(whoami) -X -S2024-06-01-00:00 -o JobID,JobName%20,State,Start,Elapsed'

alias runningjobid='sacct -u $(whoami) --noheader -s r -o JobID -X'

# This one will generally pick up the last one. All that grepping is so it only picks up batch jobs. Includes every status except pending.
alias lastjobid='sacct -u $(whoami) --noheader -o JobID,JobName -X -P --state=R,CD,F,CA,OOM,TO,NF,S,RS,BF,RV -S2025-07-01-10:30 --endtime=now \
  | grep -v -e "bash" -e "\[" \
  | tail -1 \
  |cut -d "|" -f 1'


# Display the logs of the currently running job as it runs:
alias tailjob='tail -f $(ls ~/logs/*$(runningjob))'
alias lastjobout='less $(ls ~/logs/*$(lastjobid))'

# I can never remember these. Time limit to avoid hogging resources (or being penalised for overuse)
alias int_session='srun --mem=16G --time=2:00:00 --pty bash -i'

# Same but with a GPU. If you need to use this one, you're having a bad day.
alias gpu_session='srun --mem=16G --qos=gpu --partition=gpu --gpus-per-node=1 --time=2:00:00 --pty bash -i'
