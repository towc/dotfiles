data=$(upower -i $(upower -e | grep BAT))

state=$(echo $data | grep "state" | column -t | cut -d" " -f3)
percentage=$(echo $data | grep "percentage" | column -t | cut -d" " -f3)

case $state in
  discharging)
    echo "- $percentage"
    echo ""
    if [[ $percentage =~ "(0|1).%" ]]
    then
      echo "#FF0000";
    fi
    ;;
  charging)
    echo "+ $percentage"
    ;;
  fully-charged)
    echo "= $percentage"
    ;;
  **)
    echo $state $percentage
    ;;
esac
