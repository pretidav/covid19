#!/bin/bash
#DP

python analysis.py > data.dat

if [ -f fit.log ] ; then
    rm fit.log
fi

gnuplot fitter.gpl 

A=$(grep "a               =" fit.log | cut -d'=' -f2| awk '{print $1}')
dA=$(grep "a               =" fit.log | cut -d'=' -f2| awk '{print $3}')
B=$(grep "b               =" fit.log | cut -d'=' -f2| awk '{print $1}')
dB=$(grep "b               =" fit.log | cut -d'=' -f2| awk '{print $3}')
C=$(grep "c               =" fit.log | cut -d'=' -f2| awk '{print $1}')
dC=$(grep "c               =" fit.log | cut -d'=' -f2| awk '{print $1}')
dAB=$(grep "b              " fit.log | tail -1 | awk '{print $2}')
dAC=$(grep "c              " fit.log | tail -1 | awk '{print $2}')
dBC=$(grep "c              " fit.log | tail -1 | awk '{print $3}')

echo "$A $B $C"
echo "$dA $dB $dC"
echo "$dAB $dBC $dAC"

sed "s/@A/${A}/g;
s/@sigmaA/${dA}/g;
s/@B/${B}/g;
s/@sigmaB/${dB}/g;
s/@C/${C}/g;
s/@sigmaC/${dC}/g;
s/@rhoAB/${dAB}/g;
s/@rhoAC/${dAC}/g;
s/@rhoBC/${dBC}/g;
" plotter.gpl_TEMPLATE > plotter.gpl

gnuplot plotter.gpl