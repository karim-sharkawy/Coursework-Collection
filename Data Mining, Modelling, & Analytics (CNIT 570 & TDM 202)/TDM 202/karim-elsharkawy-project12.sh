# Question 1
%%bash

for port in {1025..65535}; do
    python3 -c "import socket; s=socket.socket(socket.AF_INET, socket.SOCK_STREAM); result=s.connect_ex(('127.0.0.1', $port)); s.close(); exit(result)"
    if [ $? -ne 0 ]; then
        echo "port $port open"
        break
    fi
done

# Question 2
for i in $(env | awk -F= '/SLURM/ {print $1}'); do unset $i; done;

cp /anvil/projects/tdm/apps/qemu/images/builder.qcow2 $SCRATCH

module load qemu
# check the module loaded
module list

qemu-system-x86_64 -vnc none,ipv4=on -hda $SCRATCH/builder.qcow2 -m 8G -smp 4 -enable-kvm -net nic -net user,hostfwd=tcp::1025-:22 &

ssh -p 1025 tdm@localhost -o StrictHostKeyChecking=no

# Question 3
df -h

# Printing environment variables
printenv

# Listing files in current directory
ls -la

# Question 4
echo 'echo "There are $(ls | wc -l) files in the current directory."' > countFiles.sh

chmod +x countFiles.sh
./countFiles.sh

# Question 5
docker --version
docker pull ubuntu
docker run -it ubuntu bash
apt-get update && apt-get install -y cowsay
find . -name "cowsay"
./usr/games/cowsay "Hii!!! :)"
exit
docker ps -a
docker rm c2c9f44e0527
docker rm b9f09a51f7b1