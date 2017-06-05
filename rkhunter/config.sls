{% from "rkhunter/map.jinja" import rkhunter with context %}
{% from "rkhunter/map.jinja" import config with context %}

include:
  - rkhunter

# Config
{{ rkhunter.config }}:
  file.managed:
    - source: salt://rkhunter/templates/rkhunter.conf.jinja
    - template: jinja
    - mode: 644


rkhunter-cron:
  cron.present:
    - name: /usr/bin/rkhunter --cronjob --update --quiet --report-warnings-only --nomow | /usr/bin/mail -E -s "[rkhunter] Warnings found for {{ salt['grains.get']('id') }}" {{ config.get('mail_on_warning', 'root@localhost') }}
    - identifier: Rkhunter daily job
    - user: root
    - hour: 4
    - minute: random
