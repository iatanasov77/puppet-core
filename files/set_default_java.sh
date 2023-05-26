#!/bin/bash

JAVA_DEFAULT=$(alternatives --display java | grep "family java-$1-openjdk" | cut -d' ' -f1)
#echo $JAVA_DEFAULT
alternatives --set java $JAVA_DEFAULT


