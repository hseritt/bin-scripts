#!/usr/bin/env bash

echo "Project name: "
read PROJECT_NAME

echo ""
echo "We'll try to do our best to make sure you can get the correct Python version."
echo "This script will use try to use pyenv to install it."
echo "Python version: "
read PYTHON_VERSION

pyv_count=$(which pyenv|grep pyenv|wc -l)
if [ "$pyv_count" -gt 0 ]
then
  echo "Installing Python version (if not already installed) ..."
  pyenv install -s $PYTHON_VERSION
fi

git clone git@github.com:hseritt/django-project-starter2.git
mv django-project-starter2 $PROJECT_NAME
cd $PROJECT_NAME

if [ "$pyv_count" -gt 0 ]
  then echo "python-${PYTHON_VERSION}" > runtime.txt
fi

chmod +x change-project.sh
./change-project.sh $PROJECT_NAME

cd $PROJECT_NAME
./manage.py makemigrations
./manage.py migrate
echo "Creating an admin superuser ..."
./manage.py createsuperuser

cd ..
rm -rf change-project.sh
echo "# ${PROJECT_NAME}" > README.md
git init

echo "Done. Enjoy."
