helm ls -n prod -q|xargs helm delete -n prod
helm ls -n staging -q|xargs helm delete -n staging
helm ls -n test -q|xargs helm delete -n test

