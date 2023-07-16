#!/bin/bash


files=(
    MoveMapGen
    ad
    vmap_assembler
    vmap_extractor
)
for f in "${files[@]}"
do
    sudo docker cp cmangos-classic-extractors:/mangos-classic/_install/bin/tools/$f ./tools/
done
