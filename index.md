4.15.txt
----------

> В ядре 4.15 реализована защита от уязвимостей Spectre и Meltdown.
> Для процессоров архитетуры x86_64 по умолчанию включена поддержка механизма Page Table Isolation (защита от Spectre). За    щита от Meltdown обеспечиваетcя за счёт поддержки retpoline (см. также интересные разъяснения здесь).

> К сожалению, эти защитные механизмы сильно снижают производительность. Именно поэтому в ядре 4.15 предусмотрена возможность их отключения: достаточно указать параметры загрузки: **pti=off** и **spectre_v2=off**.

78312a-AC.txt
----------

>pass: **285913348**


AltGr.txt
----------

>Option "XkbOptions" "lv3:ralt_switch" is set by default in xorg.conf.
>This can be manually commented out or you can run *sudo dpkg-reconfigure xserver-xorg* and disable the option from in there

>this works (for X):

>*xmodmap -e 'clear mod5'*
>*xmodmap -e "keycode 108 = Alt_L"*


apt-daily.txt
----------

>*sudo systemctl disable apt-daily.service*

>*sudo systemctl disable apt-daily.timer*

arduino.txt
----------

>stty -F /dev/ttyUSB0 cs8 9600 ignbrk -brkint -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts

screen /dev/ttyUSB0 9600

cat </dev/ttyUSB0

stty -a < /dev/ttyUSB0

//
I solved my problem by messing around with choosing different boards from the menu choices (Tools > Board > ATmega328P  -- and Tools > Board > ATmega328P (Old Bootloader), and a few other menu options, and opening and closing different sketches and magically it started working again with ATmega328 menu choice.

I think my problem re-occurred because I used a different Nano that must not need the Old Bootloader where the previous Nano I had plugged in did need it. With Nano #2 the IDE finally started working with the ATmega328P choice... not the 'Old Bootloader' choice. But it took a bunch of poking around.
//

atk-bridge.txt
----------

# apt-get install libatk-adaptor

bind.txt
----------


bind -P


boot.txt
----------

systemd-analyze blame
sudo journalctl --boot > boot.log

bulk_rename.txt
----------

# Use awk to change the file extension for a group of files. For example to change all .htm files to .php: 

ls *htm | awk -F. '{print "mv "$0" "$1".php"}' | sh



bzlib.h.txt
----------

sudo apt-get install libbz2-dev

checkdisk.txt
----------

sudo tune2fs -c 50 /dev/insert_disk_here

This would set it to check every 50 times that disk is mounted. However, if the filesystem reports an error the it'l  still trigger fsck next boot.

не работает

colors2.txt
----------

#in command promt:
for code in {30..37}; do \
echo -en "\e[${code}m"'\\e['"$code"'m'"\e[0m"; \
echo -en "  \e[$code;1m"'\\e['"$code"';1m'"\e[0m"; \
echo -en "  \e[$code;3m"'\\e['"$code"';3m'"\e[0m"; \
echo -en "  \e[$code;4m"'\\e['"$code"';4m'"\e[0m"; \
echo -e "  \e[$((code+60))m"'\\e['"$((code+60))"'m'"\e[0m"; \
done
#will produce different colors

colors.txt
----------


for code in {0..255}; do echo -e "\e[38;05;${code}m $code: Test"; done


console.txt
----------

sudo dpkg-reconfigure console-setup
exit 0

\\or add these lines to your ~/.profile:
\\#load larger font on tty
\\if [ "$TERM" == "linux" ]; then 
\\ #sleep 1 # add this if you have problems
\\ /usr/local/bin/fontset
\\fi

sudo apt-get install fonts-ubuntu-font-family-console 

Создайте скрипт /usr/local/bin/fontset:

#!/bin/sh
setfont /usr/share/consolefonts/Uni3-Terminus20x10.psf.gz

(выберите нужный шрифт из папки /usr/share/consolefonts/ )

Вы можете каждый раз называть fontset на консоли после использования Ctrl + Alt + F1

или добавьте эти строки в ваш файл ~/.profile :

#load larger font on tty
if [ "$TERM" == "linux" ]; then
#sleep 1 # add this if you have problems
/usr/local/bin/fontset
fi 

Это запустит ваш скрипт, только если вы находитесь на консоли tty. 
cp_longfilename.txt
----------

cp ReallyLongFileNameYouDontWantToTypeTwice{,.orig}

CreatePartitions-BIOS.txt
----------

rem == CreatePartitions-BIOS.txt == 
rem == These commands are used with DiskPart to 
rem    create three partitions 
rem    for a BIOS/MBR-based computer. 
rem    Adjust the partition sizes to fill the drive 
rem    as necessary. == 
select disk 0 
clean 
rem == 1. System partition ====================== 
create partition primary size=100 
format quick fs=ntfs label="System" 
assign letter="S" 
active 
rem == 2. Windows partition ===================== 
rem ==    a. Create the Windows partition ======= 
create partition primary 
rem ==    b. Create space for the recovery tools   
shrink minimum=500 
rem       ** NOTE: Update this size to match the 
rem                size of the recovery tools  
rem                (winre.wim)                 ** 
rem ==    c. Prepare the Windows partition ======  
format quick fs=ntfs label="Windows" 
assign letter="W" 
rem == 3. Recovery tools partition ============== 
create partition primary 
format quick fs=ntfs label="Recovery" 
assign letter="R" 
set id=27 
list volume 
exit

ctrl-z.txt
----------

Job identifiers
Notation    Meaning
%N  Job number [N]
%S  Invocation (command-line) of job begins with string S
%?S Invocation (command-line) of job contains within it string S
%%  "current" job (last job stopped in foreground or started in background)
%+  "current" job (last job stopped in foreground or started in background)
%-  Last job
$!  Last background process


DEP-11.txt
----------


Looks like it is defined in /etc/apt/apt.conf.d/50appstream

Can be disabled with:

sudo mv /etc/apt/apt.conf.d/50appstream{,.disabled}

That stopped it on mine, still visible in updates as:

    N: Ignoring file '50appstream.disable' in directory '/etc/apt/apt.conf.d/' as it has an invalid filename extension

Edit:

If you want, you can just move the file outside of that directory, it will no longer show up. No more notices. eg:sudo mv /etc/apt/apt.conf.d/50appstream /etc/apt/50appstream


diff_dirs.txt
----------

 diff -u <(ls -c1 dir_1) <(ls -c1 dir_2) 

Will show you a diff of files in the root of dir_1 and dir_2

du.txt
----------

du -sk ./* | sort -n | awk 'BEGIN{ pref[1]="K"; pref[2]="M"; pref[3]="G";} { total = total + $1; x = $1; y = 1; while( x > 1024 ) { x = (x + 1023)/1024; y++; } printf("%g%s\t%s\n",int(x*10)/10,pref[y],$2); } END { y = 1; while( total > 1024 ) { total = (total + 1023)/1024; y++; } printf("Total: %g%s\n",int(total*10)/10,pref[y]); }'

ff_aurora.txt
----------

sudo add-apt-repository ppa:ubuntu-mozilla-daily/firefox-aurora
sudo apt-get update
sudo apt-get install firefox
#beta
sudo add-apt-repository ppa:mozillateam/firefox-next
sudo apt update && sudo apt install firefox
#Firefox Nightly
#You can run Firefox Nightly alongside a stable version of Firefox, making perfect for testing
sudo add-apt-repository ppa:ubuntu-mozilla-daily/ppa
sudo apt update && sudo apt install firefox-trunk

first_par.txt
----------

#!/bin/bash
# usage-message.sh

: ${1?"Usage: $0 ARGUMENT"}
#  Script exits here if command-line parameter absent,
#+ with following error message.
#    usage-message.sh: 1: Usage: usage-message.sh ARGUMENT

fonts.txt
----------

There is an old trick to make fonts smoother on Ubuntu (and pretty much every distro running Gnome):

Open up .fonts.conf under your home directory (~/.fonts.conf) and paste this in:

<?xml version="1.0" ?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
   <fontconfig>
      <match target="font">
         <edit name="autohint" mode="assign">
            <bool>true</bool>
         </edit>
      </match>
</fontconfig>


fstrim.txt
----------

systemctl status fstrim.timer



TRIM is enabled by default in 18.04.

It is managed via systemctl (not CRON) and is set to run weekly by default.

View fstrim.timer status:

$ systemctl status fstrim.timer
● fstrim.timer - Discard unused blocks once a week
   Loaded: loaded (/lib/systemd/system/fstrim.timer; enabled; vendor preset: enabled)
   Active: active (waiting) since Thu 2018-07-05 05:45:11 BST; 4h 42min ago
  Trigger: Mon 2018-07-09 00:00:00 BST; 3 days left
     Docs: man:fstrim

Start/Stop/Restart fstrim.timer:
(immediate activate/deactivate/reactivate, does not change startup status)

$ sudo systemctl [start/stop/restart] fstrim.timer

Enable/Disable fstrim.timer:
(add to/remove from startup, does not change immediate active status)

$ sudo systemctl [enable/disable] fstrim.timer

View fstrim.timer configuration:

$ systemctl cat fstrim.timer
# /lib/systemd/system/fstrim.timer
[Unit]
Description=Discard unused blocks once a week
Documentation=man:fstrim

[Timer]
OnCalendar=weekly
AccuracySec=1h
Persistent=true

[Install]
WantedBy=timers.target

View fstrim.service configuration:

$ systemctl cat fstrim.service
# /lib/systemd/system/fstrim.service
[Unit]
Description=Discard unused blocks

[Service]
Type=oneshot
ExecStart=/sbin/fstrim -av

View related systemd journal entries:

$ journalctl -u fstrim.timer
Jul 04 14:18:41 user-laptop systemd[1]: Started Discard unused blocks once a week.
Jul 04 21:59:26 user-laptop systemd[1]: Stopped Discard unused blocks once a week.
etc...

$ journalctl -u fstrim.service
Jun 25 10:59:44 user-laptop systemd[1]: Starting Discard unused blocks...
Jun 25 10:59:48 user-laptop fstrim[955]: /: 92.5 GiB (99335237632 bytes) trimmed
Jun 25 10:59:48 user-laptop systemd[1]: Started Discard unused blocks.
-- Reboot --
Jul 02 04:27:41 user-laptop systemd[1]: Starting Discard unused blocks...
Jul 02 04:27:46 user-laptop fstrim[1032]: /: 92.3 GiB (99150807040 bytes) trimmed
Jul 02 04:27:46 user-laptop systemd[1]: Started Discard unused blocks.
etc...


gedit.txt
----------

gsettings set org.gnome.gedit.preferences.encodings candidate-encodings "['UTF-8', 'WINDOWS-1251', 'KOI8-R', 'CURRENT', 'ISO-8859-15', 'UTF-16']"

git.txt
----------

sudo apt-get install git-core git-svn gitweb -y

git config --global user.name "git"
git config --global user.email "git@k52f.local"

Отобразить настройки глобальной конфигурации:

ekzorchik@srv-mon:~$ git config -l

sudo nano /etc/apache2/apache2.conf

ServerName srv-mon

ekzorchik@srv-mon:~$ sudo a2enmod dav

ekzorchik@srv-mon:~$ sudo a2enmod dav_fs

ekzorchik@srv-mon:~$ sudo a2enmod rewrite

ekzorchik@srv-mon:~$ sudo a2enmod env

Создаем виртуальный хост, на котором будут находиться наши репозитарии и заодно создаем пустой репозитарий:

ekzorchik@srv-mon:~$ sudo mkdir -p /git.srv-mon/main.git

На заметку: на созданную директорию где находятся все проекты настроим работу от пользователя git и работы с веб-сервером группы www-data

ekzorchik@srv-mon:~$ sudo adduser --system --shell /bin/bash --gecos 'git versions control' --group --disabled-password --home /home/git git

ekzorchik@srv-mon:~$ sudo chown -R git:www-data /git.srv-mon/

ekzorchik@srv-mon:~$ sudo su git -c "chmod -R a+w /home/git/."

ekzorchik@srv-mon:~$ sudo su - git

git@srv-mon:~$ cd /git.srv-mon/

git@srv-mon:/git.srv-mon$ git init

На заметку: В папке /git.srv-mon находятся все проекты. Чтобы создать новый проект в этой директории нужно создать ещё одну директорию, и инициализировать репозитарий командой git init.

git@srv-mon:/git.srv-mon$ git update-server-info

git@srv-mon:/git.srv-mon$ exit

ekzorchik@srv-mon:~$ sudo nano /etc/apache2/sites-available/git.conf

<VirtualHost *:80>

ServerAdmin admin@srv-mon

ServerName srv-mon

DocumentRoot /git.srv-mon

Alias /git «/git.srv-mon/main.git»

DAVMinTimeout 1000

<Location /git>

DAV on

AuthType Basic

AuthName «Git»

AuthUserFile /git.srv-mon/passwd.git

Require valid-user

</Location>

</virtualhost>

Активируем созданный сайт:

ekzorchik@srv-mon:~$ sudo a2ensite git.conf

Enabling site git.conf.

To activate the new configuration, you need to run:

service apache2 reload

Проверяем созданный конфиг на предмет каких либо ошибок:

ekzorchik@srv-mon:~$ sudo apache2ctl -S


gnome-control-center.txt
----------

env XDG_CURRENT_DESKTOP=GNOME gnome-control-center


grub_GRUB_DISABLE_OS_PROBER.txt
----------

 Re: how to make update-grub (grub2) ignore other partions/distros ? 

Add this to /etc/default/grub:
GRUB_DISABLE_OS_PROBER=true

then sudo update-grub

grub_menu_timeout.txt
----------



    Сделайте резервную копию ...

    cp /etc/default/grub ~/grub.original

    Редактировать Grub с помощью текстового редактора.

    sudo nano /etc/default/grub

    Измените (или добавьте) следующий параметр, как показано ...

    GRUB_TIMEOUT=10

    Измените (или добавьте) следующий параметр, как показано ...

    GRUB_TIMEOUT_STYLE=menu

    Если они присутствуют, закомментируйте следующее (потому что они устарели) ...

    # GRUB_HIDDEN_TIMEOUT=<???>
    # GRUB_HIDDEN_TIMEOUT_QUIET=<???>

    Сохраните файл и выйдите из текстового редактора.

    Обновить Grub ...

    sudo update-grub

    Reboot.


grub_part_exclude.txt
----------

So for anyone coming here from Google, as I did, all you need to do is modify your '30_os-prober' file
For me it is located at '/etc/grub.d/30_os-prober'

So open it with a text editor (I used nano)
then go to line 139, which should look like this

for OS in ${OSPROBED} ; do
  DEVICE="`echo ${OS} | cut -d ':' -f 1`"
  LONGNAME="`echo ${OS} | cut -d ':' -f 2 | tr '^' ' '`"
  LABEL="`echo ${OS} | cut -d ':' -f 3 | tr '^' ' '`"
  BOOT="`echo ${OS} | cut -d ':' -f 4`"
  #### ::: Line 139 ::: ####
  if [ -z "${LONGNAME}" ] ; then
    LONGNAME="${LABEL}"
  fi


then modify it to add the following lines, that are highlighted red.


for OS in ${OSPROBED} ; do
  DEVICE="`echo ${OS} | cut -d ':' -f 1`"
  LONGNAME="`echo ${OS} | cut -d ':' -f 2 | tr '^' ' '`"
  LABEL="`echo ${OS} | cut -d ':' -f 3 | tr '^' ' '`"
  BOOT="`echo ${OS} | cut -d ':' -f 4`"

  # Patch to prevent some partitions being autodetected
  SKIP_THESE_DEVICES="sda7 sda1"

  PARTITIONNAME="`echo ${DEVICE} | cut -c 6- 2> /dev/null`"
  if [ "`echo ${SKIP_THESE_DEVICES} | grep -e ${PARTITIONNAME} 2> /dev/null`" ] ; then
    continue
  fi
  # End of patch

  if [ -z "${LONGNAME}" ] ; then
    LONGNAME="${LABEL}"
  fi

hddtemp.txt
----------

sudo chmod u+s /usr/sbin/hddtemp

here_str_doc.txt
----------



Why is the command md5sum <<< 'ddd' (output: d6d88f2e50080b9602da53dac1102762  -) right, and md5sum << 'ddd' not?

What does <<< mean?



The <<< starts a “here string”: The string is expanded and fed to the program’s stdin. (In your case, there is not much of expansion happening.) It is equivalent to this:

echo ddd | md5sum

On the other hand, << starts a here document. All the following lines up to one containing the marker ddd will comprise the input of the program. (You should use a marker that is not likely to appear in your data.) You could achieve the same effect as above like this:

md5sum <<END
ddd
END

There is one difference between <<END and <<'END': Without the quotes, any variables, escape sequences etc. in the here document will be expanded as usual.


history.txt
----------

HISTTIMEFORMAT="%d/%m/%y %T "

Or, to make the change permanent for the current user:

echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> ~/.bashrc
source ~/.bashrc

icon-caches.txt
----------

#!/bin/sh

#You need to:
#
#    Update the timestamp on the top-level icon directory
#    Run gtk-update-icon-cache
#
#Note: hicolor is the default theme which app developers should use. if you're making an icon theme, refresh your icon theme's folder instead.

sudo touch /usr/share/icons/hicolor && touch ~/.local/share/icons/hicolor && sudo gtk-update-icon-cache

intel_radeon_draphics.txt
----------

#GRUB_CMDLINE_LINUX_DEFAULT="quiet splash modeset=1 hybridopts=ON,IGD,OFF"
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash hybridopts=ON,IGD,OFF"

#radeon
DRI_PRIME=1 glxinfo
or/and DRI_PRIME=1 glxheads

#intel
DRI_PRIME=0 glxinfo
or/and
DRI_PRIME=0 glxheads

iprables.txt
----------

So, for instance, you would run

sudo iptables-save | sudo tee /etc/iptables.conf

to save your current iptables rules to /etc/iptables.conf and then insert these lines in /etc/rc.local:

# Load iptables rules from this file
iptables-restore < /etc/iptables.conf




A Quick Update to this as you might be using 12.04 now and things are better.

The iptables-persistent package now solves this issue. To install,

sudo apt-get install iptables-persistent

The rules defined when the package is installed are saved and used on each subsequent boots. New rules loaded are discarded at reboot.

The config file if you do need to change them (once iptables-persistent is installed) is /etc/iptables/rules.v4 or /etc/iptables/rules.v6 for ipv4 and ipv6 iptables respectively.


ipv6.txt
----------

Disable IPv6 on Ubuntu Altogether

If you want to completely disable IPv6 on your Ubuntu Linux system, then you need to make some changes to Linux kernel parameter.

Edit the 99-sysctl.conf file.

sudo nano /etc/sysctl.d/99-sysctl.conf

Copy and paste the following 3 lines at the bottom of the file.

net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1

Save and close the file. Then execute the following command to load the above changes.

sudo sysctl -p

Now run the following command. You should see 1, which means IPv6 has been successfully disabled.

cat /proc/sys/net/ipv6/conf/all/disable_ipv6

or/and

Look for

GRUB_CMDLINE_LINUX="xxxxx" and add the following line to the end <ipv6.disable=1> so it looks like below.


Code:

GRUB_CMDLINE_LINUX="xxxxx ipv6.disable=1"



kernel_time.txt
----------



You can trim down the initramfs to speed up boot by editing /etc/initramfs-tools/initramfs.conf and setting MODULES=dep.

Then run the following to update the initramfs to hopefully make a smaller one:

sudo update-initramfs -u


keyboard.txt
----------

sudo dpkg-reconfigure keyboard-configuration

kill X.txt
----------


killX.txt
----------

sudo dpkg-reconfigure keyboard-configuration

or keyboard shortcut:
echo 123 | sudo -S /etc/init.d/lightdm restart

livepatch.txt
----------

sudo snap install canonical-livepatch
sudo canonical-livepatch enable c34e12694bbc4477a0490ef3e90f3201

ls_dirs.txt
----------

ls -d */ 2>/dev/null


lua53.txt
----------

sudo update-alternatives --install /usr/bin/lua lua-interpreter \
/usr/bin/lua5.3 130 --slave /usr/share/man/man1/lua.1.gz \
lua-manual /usr/share/man/man1/lua5.3.1.gz

sudo update-alternatives --install /usr/bin/luac lua-compiler \
/usr/bin/luac5.3 130 --slave /usr/share/man/man1/luac.1.gz \
lua-compiler-manual /usr/share/man/man1/luac5.3.1.gz


man2pdf.txt
----------


man -t manpage | ps2pdf - filename.pdf


MediaKeys.txt
----------



play/pause:

xdotool key XF86AudioPlay

previous/next:

xdotool key XF86AudioPrev
xdotool key XF86AudioNext

volume down/up:

xdotool key XF86AudioLowerVolume
xdotool key XF86AudioRaiseVolume

mute:

xdotool key XF86AudioMute

with ssh do export DISPLAY=:0 end it will work as needed

mount_vhd.txt
----------

Так как эта тема находится при поиске по запросу "mount vhd ubuntu", приведу решение, которое мне помогло. VirtualBox не нужен, а нужен qemu, точнее qemu-nbd. Команды таковы:
Код: [Выделить]

sudo modprobe nbd
sudo qemu-nbd -c /dev/nbd0 <файл vdi/vhd>

В /dev появятся устройства вида nbd0p[X], где X - номер раздела. Например, /dev/nbd0p1. Дальше можно монтировать /dev/nbd0p1 как обычно:
Код: [Выделить]

sudo mount /dev/nbd0p1 /mnt

После работы отмонтируйте /mnt и выполните
Код: [Выделить]

sudo qemu-nbd -d /dev/nbd0


Очень полезно при восстановлении отдельных файлов из резервных копий Windows Image Backup.

Исходник решения тут:
http://bethesignal.org/blog/2011/01/05/how-to-mount-virtualbox-vdi-image/

network_is_empty.txt
----------

gvfs-backends: userspace virtual filesystem - backends


ntp.txt
----------

sudo apt-get install ntp

If you've configured the firewall as specified in the prerequisites, you must allow UDP traffic on port 123 in order to communicate with the NTP pool:

sudo ufw allow 123/udp


server 1.ee.pool.ntp.org
server 3.europe.pool.ntp.org
server 0.europe.pool.ntp.org

numlock.txt
----------

    You can edit this file to turn numlock off
    Code:

    /usr/share/lightdm/lightdm.conf.d/50-xubuntu-numlock.conf

    Change it to =off

    Edit:

    obviously you could also remove it ... 

    Last edited by flocculant; March 24th, 2018 at 01:53 PM. 

old cores.txt
----------


OpenWeatherMap.txt
----------

API keys:
c2117d4e7dd2db7227786361725590ba

pdf_printer.txt
----------

apt-get install printer-driver-cups-pdf

pdf_security.txt
----------

Remove security from PDF document using this very simple command on Linux and OSX. You need ghostscript for this baby to work.


gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=OUTPUT.pdf -c .setpdfwrite -f INPUT.pdf


pip.txt
----------

pip install --download <DIR> -r requirements.txt

pip install --no-index --find-links=[file://]<DIR> -r requirements.txt

//

python -m pip install --upgrade --user pip setuptools wheel


>>pypy

On recent Debian and Ubuntu (16.04 onwards), this is the command to install all build-time dependencies:

apt-get install gcc make libffi-dev pkg-config zlib1g-dev libbz2-dev \
libsqlite3-dev libncurses5-dev libexpat1-dev libssl-dev libgdbm-dev \
tk-dev libgc-dev python-cffi \
liblzma-dev libncursesw5-dev     # these two only needed on PyPy3


power scheme to High performance.txt
----------


PrepareMyPartitions.txt
----------

select disk 0 
clean 
rem == 1. System partition ====================== 
create partition primary size=100 
format quick fs=ntfs label="System" 
assign letter="S" 
active 
rem == 2. Utility partition ===================== 
create partition primary size=100 
format quick fs=ntfs label="Utility1" 
assign letter="U" 
set id=27 
rem == 3. Utility partition ===================== 
create partition primary size=200 
format quick fs=ntfs label="Utility2" 
assign letter="V" 
set id=27 
rem == 4. Extended partition ==================== 
create partition extended 
rem == 4a. Windows partition ==================== 
rem ==    a. Create the Windows partition ======= 
create partition logical 
rem ==    b. Create space for the recovery tools   
shrink minimum=500 
rem       ** NOTE: Update this size to match the 
rem                size of the recovery tools  
rem                (winre.wim)                 ** 
rem ==    c. Prepare the Windows partition ======  
format quick fs=ntfs label="Windows" 
assign letter="C" 
rem == 4b. Recovery tools partition ============== 
create partition logical 
format quick fs=ntfs label="Recovery" 
assign letter="R" 
set id=27 
list volume 
exit

processes_tree.txt
----------


ps awwfux | less -S


public share.txt
----------


pypy.txt
----------

sudo add-apt-repository ppa:pypy/ppa
sudo apt-get update

python_smb.txt
----------

import tempfile
import smb
import shutil

from smb.SMBConnection import SMBConnection

share_name          = "my_share"
user_name           = "edwards"
password            = "######"             # secret :-)
local_machine_name  = "laptop"             # arbitrary
server_machine_name = "edwards-Yocto"      # MUST match correctly
server_IP           = "192.162.2.1"        # as must this            

# create and establish connection
conn = SMBConnection(user_name, password, local_machine_name, server_machine_name, use_ntlm_v2 = True)

assert conn.connect(server_IP, 139)

# print list of files at the root of the share
files = conn.listPath(share_name, "/") 
for item in files:
    print item.filename

# check if the file we want is there
sf = conn.getAttributes(share_name, "rti_license.dat")
print sf.file_size
print sf.filename

# create a temporary file for the transfer
file_obj = tempfile.NamedTemporaryFile(mode='w+t', delete=False)
file_name = file_obj.name
file_attributes, copysize = conn.retrieveFile(share_name, "rti_license.dat", file_obj)
print copysize
file_obj.close()

# copy temporary file 
shutil.copy(file_name, "rti_license.dat")

# close connection
conn.close()

python-virtualenv.txt
----------

sudo pip3 install virtualenv virtualenvwrapper
В ~/.bashrc дописываем:
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/bin/virtualenvwrapper.sh

Создаем новое окружение:
mkvirtualenv env-name

Смотрим список окружений:
workon

Меняем окружение:
workon env-name

Выходим из окружения:
deactivate

даляем окружение:
rmvirtualenv env-name

Находясь в одном из окружений, можно ставить пакеты через pip, как обычно:
pip3 install flask

Список зависимостей проекта, насколько я смог разобраться, принято сохранять в файл с именем requirements.txt:
pip3 freeze > requirements.txt

Этот подход позволяет одной командой установить все зависимости, необходимые проекту:
pip3 install -r requirements.txt



qemu.img.txt
----------

Step#1: Convert QEMU image to raw image.

Starting with the file WindowsServer1-compressed.img (size: 5,172,887,552)

Convert the QEMU image to a raw/dd image using the qemu-img utility.

1> qemu-img convert  WindowsServer1-compressed.img  -O raw  WindowsServer1.raw

I now have the file WindowsServer1.raw (size: 21,474,836,480)

Step#2: Convert the RAW image into a VDI image using the VBoxManage tool.

2> VBoxManage convertfromraw WindowsServer1.raw --format vdi  WindowsServer1.vdi

Converting from raw image file="WindowsServer1.raw" to file="WindowsServer1.vdi"...
Creating dynamic image with size 21474836480 bytes (20480MB)...

This takes a few minutes, but finally I have the file WindowsServer1.vdi (size: 14,591,983,616)
Step#3: Compact the image

Smaller images a better! It is likely the image is already compact; however this also doubles as an integrity check.

3> VBoxManage modifyhd WindowsServer1.vdi --compact
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%

Sure enough the file is the same size as when we started (size: 14,591,983,616). Upside is the compact operation went through the entire image without any errors.

Step#4: Cleanup and make a working copy.

Now MAKE A COPY of that converted file and use that for testing. Set the original as immutable [chattr +i] to prevent that being used on accident. I do not want to waste time converting the original image again.

Throw away the intermediate raw image and compress the image we started with for archive purposes.

rm WindowsServer1.raw 
cp WindowsServer1.vdi WindowsServer1.SCRATCH.vdi 
sudo chattr +i WindowsServer1.vdi
bzip2 -9 WindowsServer1-compressed.img 

The files at the end:
File 	Size
WindowsServer1-compressed.img.bz2 	5,102,043,940
WindowsServer1.SCRATCH.vdi 	14,591,983,616
WindowsServer1.vdi 	14,591,983,616

Step#5

Generate a new UUID for the scratch image. This is necessary anytime a disk image is duplicated. Otherwise you risk errors like "Cannot register the hard disk '/archive/WindowsServer1.SCRATCH.vdi' {6ac7b91f-51b6-4e61-aa25-8815703fb4d7} because a hard disk '/archive/WindowsServer1.vdi' with UUID {6ac7b91f-51b6-4e61-aa25-8815703fb4d7} already exists" as you move images around.

5(opt)> VBoxManage internalcommands sethduuid WindowsServer1.SCRATCH.vdi
UUID changed to: ab9aa5e0-45e9-43eb-b235-218b6341aca9

Generating a unique UUID guarantees that VirtualBox is aware that these are distinct disk images.

Versions: VirtualBox 5.1.12, QEMU Tools 2.6.2. On openSUSE LEAP 42.2 the qemu-img utility is provided by the qemu-img package.

or

Convert VDI to raw image, be sure to have enough room on disk:
vboxmanage clonehd disk.vdi disk.raw --format RAW

To write  the raw image to the physical disk
sudo dd if=disk.raw of=/dev/sdx bs=8MB

To monitor what dd  is doing we can type from another terminal:
watch -n2 'sudo kill -USR1 $(pgrep ^dd)'


radeon.txt
----------


In order to blacklist radeon you have to add it to the conf file and then issue the command:

sudo update-initramfs -u


random_file.txt
----------

base64 /dev/urandom | head -c 10000000 > file.txt
remove_duplicates.txt
----------

awk '!x[$0]++' <file> > <new>

rename_file.txt
----------


mv filename.{old,new}


rename.txt
----------


#А мне вот тут потребовалось переименовать 150 картинок с именами типа Изображение 001.jpg
#Заменил русские буквы на цифру 1 

for a in *.jpg; do mv "$a" ${a//Изображение /1}; done

repeat.txt
----------

Running a second command with the same arguments as the previous command, use '!*' to repeat all arguments or '!:2' to use the second argument. '!$' uses the final argument. 

$ cd /home/user/foo

cd: /home/user/foo: No such file or directory

$ mkdir !*

mkdir /home/user/foo

rpc.txt
----------


net rpc shutdown -I ipAddressOfWindowsPC -U username%password
Shutdown a Windows machine from Linux

This will issue a shutdown command to the Windows machine. username must be an administrator on the Windows machine. Requires samba-common package installed. Other relevant commands are:

net rpc shutdown -r : reboot the Windows machine

net rpc abortshutdown : abort shutdown of the Windows machine

Type:

net rpc

to show all relevant commands


rst_files.txt
----------

rst2html README.rst > readme.html

pip install Sphinx
RTFM.txt
----------


rtfm() { help $@ || man $@ || $BROWSER "http://www.google.com/search?q=$@"; }


samba-w10.txt
----------

Windows 10 will try to negotiate SMB3_11, which Samba4 doesn't yet support
except in the current 4.3 release candidate. I suspect for now disabling
SMB2/3 on the Windows 10 client is your best, if not ideal, option.
Which I have also heard isn't entirely correct as Windows 10 should have auto-negotiate capabilities, and should auto-negotiate back down to SMB 3. However, if this is the case then why do samba authentication requests only work with SMB 3 and 2 forcefully disabled?

Commands used to disable SMB 3 and 2 within Windows 10:

Code:

sc.exe config lanmanworkstation depend= bowser/mrxsmb10/nsi 
sc.exe config mrxsmb20 start= disabled



show_desktop.txt
----------

Install xdotool using the following command

    sudo apt-get install xdotool

Once you install this tool you can use the following command to show desktop

    xdotool key ctrl+alt+d

skype.txt
----------


For the new 2017 version of skype that's impudent enough to add itself to autostart each time it's started (seriously? Never installing it on my own machine) it's enough to create a folder with the same name as a file it's trying to create:

rm ~/.config/autostart/skypeforlinux.desktop
mkdir ~/.config/autostart/skypeforlinux.desktop



snap.txt
----------

sudo apt purge snapd ubuntu-core-launcher squashfs-tools

speed_up.txt
----------

n computing terms ‘Preloading’ is the practice of keeping necessary files in RAM. This is many times faster than placing files on the hard drive.

The Preload daemon works by running in the background and monitoring which applications you use most frequently. This gives your system a better picture of programs you’re likely to need and ensures that they’re the first to load on login, which reduces your start-up time significantly.

sudo apt-get install preload

In Ubuntu 18.04 you can list any services launched at startup by opening Terminal and running the command:

service --status-all

To empty the temporary cache used by ‘apt-get’, run the command:

sudo apt-get clean

check:

systemd-analyze blame
sudo journalctl --boot > boot.log

ssh-copy-id.txt
----------


ssh-copy-id username@hostname

or

cat ~/.ssh/id_rsa.pub | ssh user@machine "mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys"


STVWIFI_4C0D.txt
----------

qHu6tvmTGI
sudo1.txt
----------

#!/bin/bash
case $EUID in
   0) : cool we are already root - fall through ;;
   *) # not root, become root for the rest of this session
      # (and ask for the sudo password only once)
      sudo $0 "$@" ;;
esac
# now the present process is effective-UID  (root)
# so there's no need to put sudo in front of commands

sudo2.txt
----------

#!/bin/bash
[ `whoami` = root ] || { sudo "$0" "$@"; exit $?; }

sudo_compl.txt
----------

$ cat /etc/bash_completion.d/sudo-alias.bashcomp

_comp_sudo_alias() { from="$2"; COMPREPLY=()
  if [[ $COMP_CWORD == 1 ]]; then
    COMPREPLY=( "$( alias -p | grep "^ *alias $from=" | sed -r "s/^ *alias [^=]+='(.*)'$/\1/" )" )
    return 0
  fi
  return 1
}
complete -o bashdefault -o default -F _comp_sudo_alias sudo

sudo.txt
----------

echo <password> | sudo -S <command>
echo myPassWordZ0r | sudo -S clear

suspend.txt
----------


^Z $bg $disown


You're running a script, command, whatever.. You don't expect it to take long, now 5pm has rolled around and you're ready to go home... Wait, it's still running... You forgot to nohup it before running it... Suspend it, send it to the background, then disown it... The ouput wont go anywhere, but at least the command will still run...


synaptic.txt
----------

username ALL=(ALL) NOPASSWD: ALL
max ALL=(root) NOPASSWD: /usr/sbin/synaptic
sync_datetime.txt
----------


date --set="$(ssh user@server date)"


synch_datetime.txt
----------


date --set="$(ssh user@server date)"


syslog.txt
----------

journalctl --vacuum-time=5d

thunar.txt
----------

Property    Value Type  Description
/misc-always-show-tabs  bool    If the view tabs should always be visible.
/misc-case-sensitive    bool    Determines whether the sorting should be done in a case-sensitive manner. The default is false.
/misc-full-path-in-title    bool    Show the full directory path in the window title, instead of only the directory name.
/misc-horizontal-wheel-navigates    bool    Controls whether the horizontal mouse wheel is used to navigate back and forth within a Thunar view, or whether it should be used for horizontal scrolling.
/misc-image-size-in-statusbar   bool    Show the image size in the statusbar when a single image file is selected in the view. This is disabled by default because it causes relatively high I/O when changing the selection quickly.
/misc-remember-geometry     bool    Whether Thunar should remember the size of windows and apply that size to new windows. If true the width and height are saved to last-window-width and last-window-height. If false the user may specify the start size in 'last-window-width and 'last-window-height. This option is enabled by default.
/misc-small-toolbar-icons   bool    Use small icons on the toolbar instead of the default toolbar size.
/misc-tab-close-middle-click    bool    Whether to close tabs when the tab label is clicked with the 2nd/middle-mouse-button.
/misc-exec-shell-scripts-by-default     bool    Whether shell scripts should be executed or opened by default. The default action is to open them; setting this to TRUE will allow executing them.

xfconf-query --channel thunar --property /property-name --create --type value-type --set new-value
xfconf-query --channel thunar --property /misc-image-size-in-statusbar --create --type bool --set true

gsettings set org.gtk.Settings.Debug enable-inspector-keybinding true
And launch it pressing on the keyboard Control-Shift-I or Control-Shift-D. 



TPM.txt
----------


#tpm_tis.interrupts=0


translate.txt
----------


translate(){ wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1\n/'; }



Usage:
translate <phrase> <source-language> <output-language>

Example:
translate hello en es

See this for a list of language codes:

http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes


trash.txt
----------

inst trash-cli

trash-empty

ufw.txt
----------

inst gufw
ukuu.txt
----------

sudo add-apt-repository ppa:teejee2008/ppa
sudo apt-get update
sudo apt-get install ukuu

unalias.txt
----------

Use the \unalias -a command to unalias any existing aliases.

usb_reject.txt
----------

for i in /sys/bus/pci/drivers/[uoex]hci_hcd/*:*; do
  echo "${i##*/}" > "${i%/*}/unbind"
  echo "${i##*/}" > "${i%/*}/bind"
done

usb.txt
----------

    Create a new partition table on sdc, type msdos
    Create a NTFS partition, set the boot flag on it
    Extract the iso (can be done with 7z x windows10.iso)

    Copy the content (via cp, rsync, a GUI, whatever) to the mounted NTFS partition (certainly /dev/sdc1)

    The last, critical step, taken from this post : https://superuser.com/a/817656/248812 is :

    sudo ms-sys -7 /dev/sdc.

    ms-sys is available in a ppa : https://launchpad.net/~lenski/+archive/ubuntu/ms-sys

Without ms-sys, blinking cursor on boot when the USB key is inserted.

With it, windows logo shows up.

user_add2group.txt
----------

sudo usermod -a -G groupName userName

user_add_del2group.txt
----------


sudo usermod -a -G groupName userName



Adding a user to a group:

sudo adduser user group

Removing a user from a group:

sudo deluser user group



vb_clone.txt
----------

hdd -> vb image
VBoxManage convertfromraw /dev/sda MyImage.vdi --format VDI

and vv
VBoxManage internalcommands converttoraw your-virtualbox-disk.vdi /dev/sdX


vlc.txt
----------

sudo add-apt-repository ppa:videolan/master-daily
sudo apt-get update
sudo apt-get install vlc

weather.txt
----------

curl wttr.in/tallinn

wifi_pm.txt
----------

sudo nano /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf

By default there is

    wifi.powersave = 3

Just change it to a value of 2.

The change will be active upon the next reboot.
or
sudo service network-manager restart

The values for the powersave field are:

NM_SETTING_WIRELESS_POWERSAVE_DEFAULT (0): use the default value
NM_SETTING_WIRELESS_POWERSAVE_IGNORE (1): don't touch existing setting
NM_SETTING_WIRELESS_POWERSAVE_DISABLE (2): disable powersave
NM_SETTING_WIRELESS_POWERSAVE_ENABLE (3): enable powersave



wmctrl.txt
----------

Example use:

    wmctrl -xa firefox → switch to the window class name that contains “firefox”. (use this to switch apps.
    wmctrl -a firefox → switch to the window whose name contains “firefox”
    wmctrl -c firefox → Close a window whose name contains “firefox”
    wmctrl -l → list all windows


x11vnc.txt
----------

sudo apt-get install x11vnc
sudo x11vnc -storepasswd /home/max/.vnc/passwd
В автозагрузку
x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth /home/max/.vnc/passwd -rfbport 5900 -shared
for dual mon
-clip xinerama0
enables only one screen

x86.txt
----------


getconf LONG_BIT


XF86_keys.txt
----------

XF86AddFavorite
XF86ApplicationLeft
XF86ApplicationRight
XF86AudioMedia
XF86AudioMute
XF86AudioNext
XF86AudioPause
XF86AudioPlay
XF86AudioPrev
XF86AudioLowerVolume
XF86AudioRaiseVolume
XF86AudioRecord
XF86AudioRewind
XF86AudioStop
XF86Away
XF86Back
XF86Book
XF86BrightnessAdjust
XF86CD
XF86Calculator
XF86Calendar
XF86Clear
XF86ClearGrab
XF86Close
XF86Community
XF86ContrastAdjust
XF86Copy
XF86Cut
XF86DOS
XF86Display
XF86Documents
XF86Eject
XF86Excel
XF86Explorer
XF86Favorites
XF86Finance
XF86Forward
XF86Game
XF86Go
XF86History
XF86HomePage
XF86HotLinks
XF86Launch0
XF86Launch1
XF86Launch2
XF86Launch3
XF86Launch4
XF86Launch5
XF86Launch6
XF86Launch7
XF86Launch8
XF86Launch9
XF86LaunchA
XF86LaunchB
XF86LaunchC
XF86LaunchD
XF86LaunchE
XF86LaunchF
XF86LightBulb
XF86LogOff
XF86Mail
XF86MailForward
XF86Market
XF86Meeting
XF86Memo
XF86MenuKB
XF86MenuPB
XF86Messenger
XF86MonBrightnessUp
XF86MonBrightnessDown
XF86Music
XF86MyComputer
XF86MySites
XF86New
XF86News
XF86Next_VMode
XF86Prev_VMode
XF86OfficeHome
XF86Open
XF86OpenURL
XF86Option
XF86Paste
XF86Phone
XF86Pictures
XF86PowerDown
XF86PowerOff
XF86Next_VMode
XF86Prev_VMode
XF86Q
XF86Refresh
XF86Reload
XF86Reply
XF86RockerDown
XF86RockerEnter
XF86RockerUp
XF86RotateWindows
XF86RotationKB
XF86RotationPB
XF86Save
XF86ScreenSaver
XF86ScrollClick
XF86ScrollDown
XF86ScrollUp
XF86Search
XF86Send
XF86Shop
XF86Sleep
XF86Spell
XF86SplitScreen
XF86Standby
XF86Start
XF86Stop
XF86Support
XF86Switch_VT_1
XF86Switch_VT_10
XF86Switch_VT_11
XF86Switch_VT_12
XF86Switch_VT_2
XF86Switch_VT_3
XF86Switch_VT_4
XF86Switch_VT_5
XF86Switch_VT_6
XF86Switch_VT_7
XF86Switch_VT_8
XF86Switch_VT_9
XF86TaskPane
XF86Terminal
XF86ToDoList
XF86Tools
XF86Travel
XF86Ungrab
XF86User1KB
XF86User2KB
XF86UserPB
XF86VendorHome
XF86Video
XF86WWW
XF86WakeUp
XF86WebCam
XF86WheelButton
XF86Word
XF86XF86BackForward
XF86Xfer
XF86ZoomIn
XF86ZoomOut
XF86iTouch 

XFCE_reset.txt
----------

How do I reset all my xfce desktop (xfwm?) settings?

Post by xenopeek » Thu Jan 10, 2013 4:09 am
Open a terminal, back up your current configuration:

Code: Select all

mv ~/.config/xfce4  ~/.config/xfce4.bak

Then either leave it like that, which will reset to a default Xfce desktop (no Linux Mint customizations), or copy the skeleton files with the following command, which will reset to a default Linux Mint Xfce desktop:

Code: Select all

cp -r /etc/xdg/xfce4 ~/.config

Then log out and log in again to effectuate the new configuration.

xrdp.txt
----------

sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config

xterm.txt
----------

If you don't already have one, create a file in your home directory named .Xresources to store your preferences for various X programs. Append a line to the file such as

xterm*font:     *-fixed-*-*-*-18-*
xterm*geometry: 100x33

current(22.06.18):
xterm*faceName: DejaVu Sans Mono
xterm*faceSize: 12
xterm*renderFont: true
xterm*geometry: 100x27
XTerm.vt100.translations: #override \n\
  Ctrl <Key> minus: smaller-vt-font() \n\
  Ctrl <Key> plus: larger-vt-font()

run xrdb -merge ~/.Xresources

c.sh
----------

#!/bin/bash
rm -f index.md
for i in *{.txt,.sh}; do
    echo $i >> index.md
    echo "----------" >> index.md
    echo >> index.md
    cat $i >> index.md
    echo >> index.md
done
pandoc index.md -t html -s -o index.html 2>/dev/null
exo-open index.html

get-acpi-info.sh
----------

#!/bin/sh
# Author: Lekensteyn <lekensteyn@gmail.com>
# This script is released into public domain, do whatever you want with it
# Version history:
# 2012-01-08: Initial release
# 2012-01-08 21:42 UTC: Update bug reporting URL
err=false
if ! dmidecode -V >/dev/null; then
	echo "Please install dmidecode"
	err=true
fi
if ! acpidump -h >/dev/null; then
	echo "Please install acpidump"
	err=true
fi
if ! sudo -V >/dev/null; then
	sudo() {
		echo "Running command as root: $*"
		su -c "$*"
	}
fi
$err && exit

cd "$(mktemp -d)"

echo "Dumping ACPI tables..."
sudo acpidump > acpidump.txt
acpixtract acpidump.txt
# everything can be retrieved from the dump, iasl is not mandatory
iasl -h >/dev/null && for i in *.dat; do iasl -d "$i"; done
# clear the file

echo "Gathering computer model and BIOS version..."
: > dmidecode.txt
info="system-manufacturer system-product-name system-version"
info="$info baseboard-manufacturer baseboard-product-name baseboard-version"
info="$info bios-vendor bios-version bios-release-date"
for key in $info;do printf "%-22s: %s\n" $key "$(sudo dmidecode -s $key)" >>dmidecode.txt;done

echo "Dumping PCI information..."
lspci -vvvnn > lspci.txt
name="$(head -2 dmidecode.txt | sed 's/ *$//;s/^[^:]*: *//;s/[^A-Za-z0-9.,-]/_/g' | tr '\n' - | sed 's/-$//')"
mkdir -p "$name" && cp *.dsl *.txt "$name"

tar czf "$name.tar.gz" "$name"

echo "Please submit the below file on https://bugs.launchpad.net/lpbugreporter/+bug/752542/+addcomment"
ls -l "$PWD/$name.tar.gz"

index.rename.sh
----------

#!/bin/bash
rm -f index.txt
for i in *.txt; do echo $(basename $i) >> index.txt; done


md1.sh
----------

for i in *.txt
do
markdown $i > $i.html
done

rename.sh
----------

#!/bin/bash
for i in *.txt; do echo $(basename -s .txt $i).{txt,md}|xargs cp; done


