INCIDENT:
Nginx unavailable

SYMPTOM:
curl localhost failed

EVIDENCE:
systemctl status nginx showed inactive

ROOT CAUSE:
Service stopped

FIX:
systemctl start nginx

VERIFICATION:
curl localhost returned HTTP 200

-------------------------------------------------------

INCIDENT:
Nginx wasn't starting

SYMPTOM:
curl localhost failed
service is not NOT running


EVIDENCE:
systemctl status nginx showed inactive
journalctl -u nginx showed some error
ss -lnt showed port is not listening

ROOT CAUSE:
nging configuration error

FIX:
Resttored nginx config. 
systemctl start nginx

VERIFICATION:
curl localhost returned HTTP 200

-------------------------------------------------------

INCIDENT:
Nginx wasn't starting

SYMPTOM:
curl localhost failed
service is not NOT running
nging -t failed
potrt conflict


EVIDENCE:
nging -t showed duplicate files in the folder
journalctl -u nginx showed some error
ss -lnt showed port is not listening

ROOT CAUSE:
Duplicate file in configuration folder
sudo nginx -t
nginx: [emerg] a duplicate default server for 0.0.0.0:80 in /etc/nginx/sites-enabled/default_corrupted:22
nginx: configuration file /etc/nginx/nginx.conf test failed

FIX:
Resttored duplicate file /etc/nginx/nginx.conf

VERIFICATION:
curl localhost returned HTTP 200


Ground rule
SYMPTOM
   ↓
WHAT STILL WORKS?
   ↓
WHICH LAYER?
   ↓
COLLECT EVIDENCE
   ↓
HYPOTHESIS
   ↓
FIX
   ↓
VERIFY