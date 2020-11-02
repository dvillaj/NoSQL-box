  sudo useradd -m -s /bin/bash  learner
  echo learner:learner | sudo chpasswd
  sudo usermod -aG sudo learner
  sudo usermod -aG docker learner

  sudo cp -r resources/learner /home
  sudo chmod +x /home/learner/*.sh
  sudo mv /home/learner/start-jupyter.sh /usr/local/bin

  sudo su - learner -c "mkdir ~/.ssh; chmod 700 ~/.ssh"
  sudo cp .ssh/authorized_keys /home/learner/.ssh

  sudo chown -R learner:learner /home/learner

  sudo su - learner -c "cd; jupyter lab --generate-config"
  sudo sed -i "s/#c.NotebookApp.ip = 'localhost'/c.NotebookApp.ip = '0.0.0.0'/" /home/learner/.jupyter/jupyter_notebook_config.py
  sudo sed -i "s/#c.NotebookApp.token = '<generated>'/c.NotebookApp.token = ''/" /home/learner/.jupyter/jupyter_notebook_config.py
  sudo sed -i "s/#c.NotebookApp.password = u''/c.NotebookApp.password = u''/" /home/learner/.jupyter/jupyter_notebook_config.py
  echo "c.NotebookApp.nbserver_extensions.append('ipyparallel.nbextension')" | sudo tee -a /home/learner/.jupyter/jupyter_notebook_config.py
  
  sudo cp resources/jupyter.service /etc/systemd/system/
  sudo systemctl enable jupyter.service
  sudo systemctl daemon-reload
  sudo systemctl start jupyter.service

  sudo mkdir -p /opt/compose
  sudo chown learner:learner /opt/compose

  sudo su - learner -c "cd; mkdir notebooks; touch notebooks/.install"

  echo "source ~/.environment" | sudo tee -a /home/learner/.bashrc
  
  rm -rf resources