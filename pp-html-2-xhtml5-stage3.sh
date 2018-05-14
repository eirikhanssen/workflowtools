#!/bin/sh
sed '/<html/ i\<!DOCTYPE html>' | \
sed 's/<meta http-equiv="Content-Type" content="text\/html; charset=UTF-8" \/>//' | \
sed -r '/^\s*$/d'
