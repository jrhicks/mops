---
to: scripts/flux_bootstrap.sh
---

# Prompt the user for input
read -p "GitHub Flux username: " GITHUB_USER
read -sp "GitHub Personal Access Token: " GITHUB_TOKEN
echo

# Export the variables as environment variables
export GITHUB_USER
export GITHUB_TOKEN

flux bootstrap github \
    --components-extra=image-reflector-controller,image-automation-controller \
    --owner=<%=github_owner%> \
    --repository=<%=github_repo_name%> \
    --private=false \
    --path=cluster