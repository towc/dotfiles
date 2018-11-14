data=$(mpstat 2 1 | awk '$12 ~ /[0-9.]+/ { print 100 - $12"%" }')

echo cpu: $data
echo ""
#if ! [[ $data =~ "^.\." ]]
#then
#  echo "#FF0000";
#fi
