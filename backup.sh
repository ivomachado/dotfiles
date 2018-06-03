#!/bin/bash

git add --all
date=`date`
git commit -m "$date"
git push
