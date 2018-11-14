amount=$(df -h /dev/sda2 | grep sda2 | column -t | cut -d" " -f7)

echo $amount
echo ""

