#!/bin/bash
while IFS=' ' read -r repo dir; do
	git clone --depth 1 --no-checkout https://gerrit.wikimedia.org/r/$repo.git $repo
done < ../repository-lists/all.txt
