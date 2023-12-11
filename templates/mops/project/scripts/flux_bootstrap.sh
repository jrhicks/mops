---
to: scripts/flux_bootstrap.sh
---

flux bootstrap github \
    --components-extra=image-reflector-controller,image-automation-controller \
    --owner=<%=github_owner%> \
    --repository=<%=github_repo_name%> \
    --private=false \
    --path=cluster