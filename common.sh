
UBUNTU_KERNEL_PATH=/usr/src/linux-headers-3.2.0-29-generic
S3C6410_KERNEL_PATH=/home/kain/Tiny210/linux/linux-3.0.8
EMULATOR_KERNEL_PATH=/root/kernel/goldfish

OK6410_ANDROID_SRC_PATH=/home/kain/Tiny210/android-4.0.3_r1
S3C6410_ANDROID_SRC_PATH=/home/kain/Tiny210/android-4.0.3_r1


export PATH=$PATH:/opt/FriendlyARM/toolschain/4.5.1/bin

selected_device=""  #  "":�L�i��Android�]��
selected_target=1  #  ��ܥؼ�,  1: ubuntu linux  2: Android�]��

function select_target()
{
    echo "1�GUbuntu Linux"
    echo "2�GS3C6410�}�o�O"
    echo "3�GAndroid������"
    read -p "�п�ܭn�b�����]�ƤW�B��]1�^" selected_target
    if [ "$selected_target" == "" ]; then
       selected_target=1
    fi
}
function select_target_noemulator()
{
    echo "1�GUbuntu Linux"
    echo "2�GS3C6410�}�o�O"
    read -p "�п�ܭn�b�����]�ƤW�B��]1�^" selected_target
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
	    echo "�L�i��Android�]��"
	else
            selected_device=$value   # ���]�u��1�ӳ]��
	    value=$(echo $device_list | cut -d' ' -f7)

	    #  �h�ӳ]��
	    if [ "$value" != "" ]; then
	       i=5
	       index=1
	       value="~~~"
	       echo "�i�γ]�ƦC��"
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
	       read -p "�z�Q��ܭ���Android�]�ơH�п�J�Ǹ�(1)�G" number
	       if [ "$number" == "" ]; then
		   number=1
	       fi
	       let "number=3 + $number * 2"
	       selected_device=$(echo $device_list | cut -d' ' -f$number)
	    fi
	fi
}


