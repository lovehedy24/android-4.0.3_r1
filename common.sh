
UBUNTU_KERNEL_PATH=/usr/src/linux-headers-3.2.0-29-generic
S3C6410_KERNEL_PATH=/home/kain/Tiny210/linux/linux-3.0.8
EMULATOR_KERNEL_PATH=/root/kernel/goldfish

OK6410_ANDROID_SRC_PATH=/home/kain/Tiny210/android-4.0.3_r1
S3C6410_ANDROID_SRC_PATH=/home/kain/Tiny210/android-4.0.3_r1


export PATH=$PATH:/opt/FriendlyARM/toolschain/4.5.1/bin

selected_device=""  #  "":無可用Android設備
selected_target=1  #  選擇目標,  1: ubuntu linux  2: Android設備

function select_target()
{
    echo "1：Ubuntu Linux"
    echo "2：S3C6410開發板"
    echo "3：Android模擬器"
    read -p "請選擇要在那類設備上運行（1）" selected_target
    if [ "$selected_target" == "" ]; then
       selected_target=1
    fi
}
function select_target_noemulator()
{
    echo "1：Ubuntu Linux"
    echo "2：S3C6410開發板"
    read -p "請選擇要在那類設備上運行（1）" selected_target
    if [ "$selected_target" == "" ]; then
       selected_target=1
    fi
}
function find_devices()
{
	device_list=$(adb devices)
        
        if [ "${device_list:0:4}" != "List" ]; then
	    device_list=$(adb devices)
	    if [ "${device_list:0:4}" != "List" ]; then
		exit
            fi
        fi
	value=$(echo $device_list | cut -d' ' -f5)
	if [ "$value" == "" ]; then
	    echo "無可用Android設備"
	else
            selected_device=$value   # 假設只有1個設備
	    value=$(echo $device_list | cut -d' ' -f7)

	    #  多個設備
	    if [ "$value" != "" ]; then
	       i=5
	       index=1
	       value="~~~"
	       echo "可用設備列表"
	       while [ "" == "" ]
	       do          
		  value=$(echo $device_list | cut -d' ' -f$i)
		  let "i=$i+2"
		  if [ "$value" == "" ]; then
		      break;
		  fi
		  echo "$index: $value"
		  let "index=$index+1"
	       done       
	       read -p "您想選擇哪個Android設備？請輸入序號(1)：" number
	       if [ "$number" == "" ]; then
		   number=1
	       fi
	       let "number=3 + $number * 2"
	       selected_device=$(echo $device_list | cut -d' ' -f$number)
	    fi
	fi
}


