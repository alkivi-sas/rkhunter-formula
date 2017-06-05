{%- from "rkhunter/map.jinja" import rkhunter with context -%}

{{ rkhunter.pkg }}:
  pkg.installed

# Update and propupd
rkhunter-update:
  cmd.run:
    - name : 'rkhunter --update && rkhunter --propupd'
    - creates: /var/lib/rkhunter/db/rkhunter.dat
    - requires:
      - pkg: {{ rkhunter.pkg }}
