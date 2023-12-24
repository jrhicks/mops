---
inject: true
to: ./Makefile
after: APP COMMANDS
skip_if: <%=app_name%>-gh-keys
---

# <%=app_name%>

<%=app_name%>-gh-keys: cc # Create Access Keys for <%=app_name%> (to add to Github Secrets)
	aws iam create-access-key --user-name <%=repo_dasherized%>-gh-user --profile <%=platform_name%>

<%=app_name%>-s3-keys: cc # Create Access Keys for <%=app_name%> (to add to Github Secrets)
	aws iam create-access-key --user-name <%=platform_name%>-<%=app_name%>-bucket-user --profile <%=platform_name%>

<%=app_name%>-key-list: cc # List AWS Access Keys (usefull for deleting)
	aws iam list-access-keys --user-name <%=repo_dasherized%>-gh-user --profile <%=platform_name%> && \
	aws iam list-access-keys --user-name <%=platform_name%>-<%=app_name%>-bucket-user --profile <%=platform_name%> && \
	echo "TO DELETE: aws iam delete-access-key --user-name "<%=repo_dasherized%>-gh-user" --profile <%=platform_name%>" --access-key-id "REPLACE-ME" && \
	echo "TO DELETE: aws iam delete-access-key --user-name "<%=platform_name%>-<%=app_name%>-bucket-user" --profile <%=platform_name%>" --access-key-id "REPLACE-ME" && \

<%=app_name%>-rails-master-key-secret: cc # Deploy K8s SECRET rails_master_key for <%=app_name%>
	read -p "rails_master_key: " rails_master_key && \
	kubectl create secret generic <%=app_name%>-rails-master-key --from-literal=RAILS_MASTER_KEY=$$rails_master_key
