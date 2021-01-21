#!/bin/bash

thisUser="$(whoami)"
echo "Deleting the following folders for $thisUser"
echo "Downloads"
echo "Trash"
rm -rdf ~/.Trash/*
rm -rdf /users/$thisUser/Downloads/*