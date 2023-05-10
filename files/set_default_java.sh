#!/bin/bash

JAVA_11=$(alternatives --display java | grep 'family java-11-openjdk' | cut -d' ' -f1)
#echo $JAVA_11
alternatives --set java $JAVA_11


