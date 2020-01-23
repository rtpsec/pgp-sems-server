!#/bin/bash
# Install VMware-Tools
mkdir /mnt/cdrom
mount /dev/cdrom /mnt/cdrom
mkdir /temp-vmware-tools
cd /mnt/cdrom
cp VMwareTools-10.3.10-12406962.tar.gz /temp-vmware-tools/
cd /temp-vmware-tools/
tar zxpf /mnt/cdrom/VMwareTools-10.3.10-12406962.tar.gz 
cd vmware-tools-distrib/
./vmware-install.pl
