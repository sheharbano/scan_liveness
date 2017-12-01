This folder contains scripts to run zmap in block-wise fashion. We did the scans on 3 machines, so that structure is reflected here.

For each scan machine [zeus, chelmer, parrhesia]

- Put run_zmap in /home/bano/scripts/
  * suitably adjust path

- Put scan_config in /usr/share

- Add the lines in to crontab.txt to crontab (under sudo)