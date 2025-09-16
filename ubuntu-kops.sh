#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc


#! /bin/bash
apt update -y && apt install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws configure
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
wget https://github.com/kubernetes/kops/releases/download/v1.33.0/kops-linux-amd64
chmod +x kops-linux-amd64 kubectl
mv kubectl /usr/local/bin/kubectl
mv kops-linux-amd64 /usr/local/bin/kops

aws s3api create-bucket --bucket deploysscloudanddevopsbyraham007899123mnbvcxz.k8s.local --region us-east-1
aws s3api put-bucket-versioning --bucket deploysscloudanddevopsbyraham007899123mnbvcxz.k8s.local --region us-east-1 --versioning-configuration Status=Enabled
export KOPS_STATE_STORE=s3://deploysscloudanddevopsbyraham007899123mnbvcxz.k8s.local
kops create cluster --name rahamss.k8s.local --zones us-east-1a --control-plane-image ami-0360c520857e3138f --control-plane-count=1 --control-plane-size t2.large --image ami-0360c520857e3138f --node-count=2 --node-size t2.medium
kops update cluster --name rahams.k8s.local --yes --admin
