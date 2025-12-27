#enable timer

sudo systemctl daemon-reload
sudo systemctl enable --now gitea-dump.timer

#test timer

systemctl is-enabled gitea-dump.timer
systemctl status gitea-dump.timer

#see schedule

systemctl list-timers --all
