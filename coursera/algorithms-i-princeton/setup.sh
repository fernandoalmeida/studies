#!/bin/bash -e

# create custom dir
cd /usr/local
sudo mkdir algs4
sudo chmod 755 algs4
cd algs4

# textbook libraries
sudo curl -O "https://algs4.cs.princeton.edu/code/algs4.jar"
sudo curl -O "https://algs4.cs.princeton.edu/linux/{javac,java}-{algs4,cos226,coursera}"
sudo chmod 755 {javac,java}-{algs4,cos226,coursera}
sudo mv {javac,java}-{algs4,cos226,coursera} /usr/local/bin/

# drjava - a lightweight development environment for writing Java programs
sudo curl -O "https://algs4.cs.princeton.edu/linux/drjava.jar"
sudo curl -O "https://algs4.cs.princeton.edu/linux/drjava"
sudo chmod 755 drjava
sudo mv drjava /usr/local/bin/
sudo curl -O "https://algs4.cs.princeton.edu/linux/.drjava"
sudo mv .drjava ~/

# findbugs - static analysis to look for bugs in Java code
sudo curl -O "https://algs4.cs.princeton.edu/linux/findbugs.{zip,xml}"
sudo curl -O "https://algs4.cs.princeton.edu/linux/findbugs-{algs4,cos226,coursera}"
sudo unzip findbugs.zip
sudo chmod 755 findbugs-{algs4,cos226,coursera}
sudo mv findbugs-{algs4,cos226,coursera} /usr/local/bin/

# pmd - scans source code and looks for potential problems
sudo curl -O "https://algs4.cs.princeton.edu/linux/pmd.{zip,xml}"
sudo curl -O "https://algs4.cs.princeton.edu/linux/pmd-{algs4,cos226,coursera}"
sudo unzip pmd.zip
sudo chmod 755 pmd-{algs4,cos226,coursera}
sudo mv pmd-{algs4,cos226,coursera} /usr/local/bin/

# checkstyle - help write Java code that adheres to a coding standard
sudo curl -O "https://algs4.cs.princeton.edu/linux/checkstyle.zip"
sudo curl -O "https://algs4.cs.princeton.edu/linux/checkstyle-suppressions.xml"
sudo curl -O "https://algs4.cs.princeton.edu/linux/checkstyle-{algs4,cos226,coursera}.xml"
sudo curl -O "https://algs4.cs.princeton.edu/linux/checkstyle-{algs4,cos226,coursera}"
sudo unzip checkstyle.zip
sudo chmod 755 checkstyle-{algs4,cos226,coursera}
sudo mv checkstyle-{algs4,cos226,coursera} /usr/local/bin/
