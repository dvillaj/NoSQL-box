echo "Adding learning user ..."
useradd -m -s /bin/bash  learner
echo learner:learner | chpasswd
usermod -aG sudo learner
usermod -aG docker learner

cp -r resources/learner /home
chmod +x /home/learner/*.sh
mv /home/learner/start-jupyter.sh /usr/local/bin

su - learner -c "mkdir ~/.ssh; chmod 700 ~/.ssh"
cp .ssh/authorized_keys /home/learner/.ssh

chown -R learner:learner /home/learner

su - learner -c "cd; jupyter lab --generate-config"
cat /home/vagrant/resources/python/jupyter.config >> /home/learner/.jupyter/jupyter_notebook_config.py

sudo cp resources/jupyter.service /etc/systemd/system/
sudo systemctl enable jupyter.service
sudo systemctl daemon-reload
sudo systemctl start jupyter.service

sudo mkdir -p /opt/compose
sudo chown learner:learner /opt/compose

sudo su - learner -c "cd; mkdir notebooks; touch notebooks/.install"

echo "source ~/.environment" | sudo tee -a /home/learner/.bashrc