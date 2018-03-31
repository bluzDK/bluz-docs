source env/bin/activate

mkdocs build
sudo rm -r docs
rm mkdocs.yml
rm README.md
rm *.sh
sudo rm -r .circleci
cp -R site/* .
sudo rm -r site