## fail2ban 
yum update -y
yum install epel-release -y
yum install fail2ban -y

systemctl start fail2ban
systemctl enable fail2ban

cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local

cat >> /etc/fail2ban/jail.local <<EOF
[DEFAULT]
ignoreip = 127.0.0.1/8
bantime  = 86400
findtime = 3600
maxretry = 3
backend = systemd
banaction = iptables-multiport


[sshd]
enabled = true
EOF

systemctl restart fail2ban
systemctl enable fail2ban
fail2ban-client status sshd
