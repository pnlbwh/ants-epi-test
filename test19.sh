#!/bin/bash -eu
source SetUpData.sh
pre=ants19_
epiwarp=epiwarp19.nii.gz
out=bse-epi19.nrrd
$ANTSPATH_19/ANTS 3 -m CC[$fixed,$moving,1,5] -i 50x20x10 -r Gauss[3,0] -t SyN[1] -o $pre --Restrict-Deformation 0x1x0 --do-rigid 
$ANTSPATH/ComposeMultiTransform 3 "$epiwarp" -R "$fixed" "${pre}Warp.nii.gz" "${pre}Affine.txt" || true
$ANTSPATH/WarpImageMultiTransform 3 "$moving" "$out" -R "$fixed" "$epiwarp"
