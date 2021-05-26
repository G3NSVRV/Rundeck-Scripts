ARG IMAGE
FROM ${IMAGE}

CMD echo "The Process Has Been Started!" && for i in `seq 90`; do cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10000 | head -n 1; sleep 1m; done && echo "The Process Has Finished"