#!/bin/bash
set -e

exec > >(tee /var/log/startup-script.log|logger -t startup-script -s 2>/dev/console) 2>&1

curl -sLo /tmp/gcp-meta.tgz https://github.com/methridge/gcp-meta/releases/download/v${app_ver}/gcp-meta_${app_ver}_linux_amd64.tar.gz

tar -zxf /tmp/gcp-meta.tgz --directory /usr/local/bin
chown root:root /usr/local/bin/gcp-meta
chmod 755 /usr/local/bin/gcp-meta

cat > "/tmp/meta.service" <<EOF
[Unit]
Description="GCP Metadata App"
Requires=network-online.target
After=network-online.target

[Service]
ExecStart=/usr/local/bin/gcp-meta
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

mv /tmp/meta.service /usr/lib/systemd/system/meta.service
chown root:root /usr/lib/systemd/system/meta.service
chmod 644 /usr/lib/systemd/system/meta.service
systemctl daemon-reload
systemctl start meta
