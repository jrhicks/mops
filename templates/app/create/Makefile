---
inject: true
to: ./Makefile
append: true
---

<%=app_name%>-gh-keys: cc # Create Access Keys for <%=app_name%> (to add to Github Secrets)
	aws iam create-access-key --user-name <%=repo_dasherized%>-gh-user --profile <%=platform_name%>-<%=environment%>

<%=app_name%>-gh-keys-list: cc # List AWS Access Keys (usefull for deleting)
	aws iam list-access-keys --user-name <%=repo_dasherized%>-gh-user --profile <%=platform_name%>-<%=environment%>
	echo "TO DELETE: aws iam delete-access-key --user-name "<%=repo_dasherized%>-gh-user" --profile <%=platform_name%>-<%=environment%>" --access-key-id "REPLACE-ME"