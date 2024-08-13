from setuptools import setup, find_packages
from os import path

working_directory = path.abspath(path.dirname(__file__))

with open(path.join(working_directory, 'README.md'), encoding='utf-8') as f:
    long_description = f.read()
    

setup(
    name='django_setup', 
    version='0.1.0', 
    description='Easy Django Setup',
    long_description=long_description,
    long_description_content_type='text/markdown',  
    author='Oluoch Ian',
    author_email='morvinian@gmail.com',
    url='https://github.com/Morvin-Ian/django-setup-automation',  
    packages=find_packages(),  
    install_requires=[],
    python_requires='>=3.6'
)