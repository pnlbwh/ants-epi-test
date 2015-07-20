#!/bin/bash -eu
source SetUpData.sh
pre=ants_
epiwarp=epiwarp.nii.gz
out=bse-epi.nrrd
$ANTSPATH/ANTS 3 -m CC[$fixed,$moving,1,5] -i 50x20x10 -r Gauss[3,0] -t SyN[0.25] -o $pre --Restrict-Deformation 0x1x0 --do-rigid 
$ANTSPATH/ComposeMultiTransform 3 "$epiwarp" -R "$fixed" "${pre}Warp.nii.gz" "${pre}Affine.txt" || true
$ANTSPATH/WarpImageMultiTransform 3 "$moving" "$out" -R "$fixed" "$epiwarp"
