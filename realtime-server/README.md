# HackBoard (HB) Realtime server install

下載最新版本的 boot2docker :  https://github.com/boot2docker/osx-installer/releases/tag/v1.4.1 下載完後，按照步驟安裝。
> boot2docker 會偵測有沒有安裝過virtualbox , 沒有安裝的話會自動安裝

安裝完後開啟 iTerm ( Terminal ) 依序下以下指令
> 以下指令會下載docker的Image並且在Virtualbox新增一台虛擬機


	$ boot2docker init
	$ boot2docker up
    
boot2docker up 執行結束後會出現類似以下的內容：

	export DOCKER_HOST=tcp://192.168.xx.xx:xxxx
	export DOCKER_CERT_PATH=/Users/xxx/.boot2docker/certs/boot2docker-vm
	export DOCKER_TLS_VERIFY=1
    
直接在指令列上打上輸出的指令讓Docker 知道vm的ip與port

	$ export DOCKER_HOST=tcp://192.168.xx.xx:xxxx
	$ export DOCKER_CERT_PATH=/Users/xxx/.boot2docker/certs/boot2docker-vm
	$ export DOCKER_TLS_VERIFY=1
    
往後每次啟動boot2docker 虛擬機都需要打以上三行指令讓Terminal知道環境變數，如果覺得很麻煩可以將以上三行寫入 .bashrc or .zshrc or .profile 之中，如以下範例：


	# file: ~/.zshrc
	# .... .......................
	export DOCKER_HOST=tcp://192.168.xx.xx:xxxx
	export DOCKER_CERT_PATH=/Users/xxx/.boot2docker/certs/boot2docker-vm
	export DOCKER_TLS_VERIFY=1
    # .... .......................


進去realtime-server資料夾


	$ cd realtime-server
    
增加*.sh檔案的執行權限

	$ chmod +x *.sh

開始產生docker 映像檔 (需要一些時間，取決於網路速度)
	
    $ /bin/bash ./make.sh

用 VBashoxManage指令做port forwarding 將port轉出來，VBoxManage的 port forwarding 指令如下：

	VBoxManage modifyvm 'boot2docker-vm' --natpf<1-N> [<rulename>,tcp|udp,<hostip>,<hostport>,<guestip>,<guestport>]


需先將vm關機，做完port forwarding後再開機

>執行以下寫好的bash
     
	$ /bin/bash ./port-forwarding.sh 
     
>或是自己打以下指令 (不建議)
     
	$ boot2docker poweroff 
	$ VBoxManage modifyvm 'boot2docker-vm' --natpf1 "tcp-port-16379,tcp,,16379,,16379"
	$ VBoxManage modifyvm 'boot2docker-vm' --natpf1 "tcp-port-33555,tcp,,33555,,33555"
	$ boot2docker up
    
    
> 以上用指令所設定的nat port forwarding也可以使用GUI設定，設定方式如下

> 1. 開啟virtualbox，對boot2docker-vm按右鍵->設定值
> 2. 選到網路頁籤，按下進階展開進階選項，按下連接埠轉送
> 3. 設定連接埠轉送如下


	名稱               協定   主機IP  主機連接埠  客體IP  客體連接埠
	tcp-port-33555    tcp           33555             33555
	tcp-port-16379    tcp           16379             16379


開完機後，可以將剛剛make後的 image run起來

	$ /bin/bash ./run.sh