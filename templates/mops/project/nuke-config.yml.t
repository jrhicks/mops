---
./nuke-config.yml
---

regions:
  - <%=aws_region%>

account-blocklist: [] # MUST BE MANUALLY ADDED

accounts:
  "<%=aws_account_id%>": {} 

