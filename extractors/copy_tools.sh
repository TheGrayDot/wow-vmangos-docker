#!/bin/bash


files=(
    ExtractResources.sh
    MoveMapGen
    MoveMapGen.sh
    ad
    offmesh.txt
    vmap_assembler
    vmap_extractor
)
for f in "${files[@]}"
do
    sudo docker cp cmangos-classic-extractors:/mangos-classic/_install/bin/tools/$f ./tools/
done
