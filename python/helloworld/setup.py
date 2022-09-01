#!/usr/bin/env python
# Example from https://docs.python.org/3.8/distutils/setupscript.html

from distutils.core import setup

setup(name='Distutils',
      version='1.0',
      description='Test package',
      author='FlorianG',
      author_email='',
      url='https://www.python.org/sigs/distutils-sig/',
      packages=['distutils', 'distutils.command'],
     )