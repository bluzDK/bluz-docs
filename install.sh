virtualenv env
source env/bin/activate

sudo apt-get update
sudo apt-get install -y python-pip
sudo apt-get install -y python-dev
pip install jinja2==2.8
pip install mkdocs