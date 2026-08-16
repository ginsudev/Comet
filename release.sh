#!/bin/sh
make clean
make package FINALPACKAGE=1

make clean
make package ROOTLESS=1 FINALPACKAGE=1
