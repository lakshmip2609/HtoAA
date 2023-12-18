#!/bin/bash

rm parameters.txt

echo "CONFIGFILE,FILELIST" > parameters.txt

#File lists for 2017 legacy data:
for i in B C D E F
do
    echo creating file list for data sample SingleMuon_Run2017${i}
    ls /pnfs/desy.de/cms/tier2/store/user/lsreelat/NTuples/2017/HtoAA/SingleMuon/SingleMuon-Run2017${i}-UL2017/*root > SingleMuon_Run2017${i}
    cp SingleMuon_Run2017${i} SingleMuon_Run2017${i}_SameSign
    ./split_filelist.sh analysisMacro_ztt.conf SingleMuon_Run2017${i} 40
    ./split_filelist.sh analysisMacro_ztt.conf SingleMuon_Run2017${i}_SameSign 40    
done

# TTSemileptonic sample should be split (long list for ls command)
echo "Creating file list for sample TTToSemiLeptonic"
    ls /pnfs/desy.de/cms/tier2/store/user/acardini/ntuples/Oktoberfest21/2017/mc/TTToSemiLeptonic/*0.root > TTToSemiLeptonic
for index in {1..9}
do
    ls /pnfs/desy.de/cms/tier2/store/user/acardini/ntuples/Oktoberfest21/2017/mc/TTToSemiLeptonic/*${index}.root >> TTToSemiLeptonic
done
cp TTToSemiLeptonic TTToSemiLeptonic_SameSign
./split_filelist.sh analysisMacro_ztt.conf TTToSemiLeptonic 20
./split_filelist.sh analysisMacro_ztt.conf TTToSemiLeptonic_SameSign 20


# WJetsToLNu sample should be split (long list for ls command)
echo "Creating file list for sample WJetsToLNu"
    ls /pnfs/desy.de/cms/tier2/store/user/acardini/ntuples/Oktoberfest21/2017/mc/WJetsToLNu/*0.root > WJetsToLNu
for index in {1..9}
do
    ls /pnfs/desy.de/cms/tier2/store/user/acardini/ntuples/Oktoberfest21/2017/mc/WJetsToLNu/*${index}.root >> WJetsToLNu
done
cp WJetsToLNu WJetsToLNu_SameSign
./split_filelist.sh analysisMacro_ztt.conf WJetsToLNu 40
./split_filelist.sh analysisMacro_ztt.conf WJetsToLNu_SameSign 40


#File lists for VV background MC samples
samples_VV=(WW_TuneCP5_13TeV-pythia8
WZ_TuneCP5_13TeV-pythia8
ZZ_TuneCP5_13TeV-pythia8
)

names_VV=(WW_13TeV-pythia8
WZ_13TeV-pythia8
ZZ_13TeV-pythia8
)

#File lists for background MC samples
samples=(DYJetsToLL_M-10to50
DYJetsToLL_M-50
ST_t-channel_antitop_4f
ST_t-channel_top_4f
ST_tW_top_5f_inclusiveDecays
ST_tW_antitop_5f_inclusiveDecays
TTTo2L2Nu
TTToHadronic
)

names=(DYJetsToLL_M-10to50
DYJetsToLL_M-50
ST_t-channel_top
ST_t-channel_antitop
ST_tW_top
ST_tW_antitop
TTTo2L2Nu
TTToHadronic
)

i=0
while [ $i -lt ${#samples[@]} ] 
do
    echo "Creating file list for sample" ${samples[$i]} 

    ls /pnfs/desy.de/cms/tier2/store/user/acardini/ntuples/Oktoberfest21/2017/mc/${samples[$i]}*/*root > ${names[$i]}

    cp ${names[$i]} ${names[$i]}_SameSign
    ./split_filelist.sh analysisMacro_ztt.conf ${names[$i]} 30
    ./split_filelist.sh analysisMacro_ztt.conf ${names[$i]}_SameSign 30
      
    i=`expr $i + 1` 
done
cp DYJetsToLL_M-50 DYJetsToTT_M-50
./split_filelist.sh analysisMacro_ztt.conf DYJetsToTT_M-50 30

k=0
while [ $k -lt ${#samples_VV[@]} ] 
do
    echo "Creating file list for sample" ${samples_VV[$k]} 

    ls /pnfs/desy.de/cms/tier2/store/user/lsreelat/NTuples/2017/HtoAA/VV_inclusive/${samples_VV[$k]}*/*root > ${names_VV[$k]}
    cp ${names_VV[$k]} ${names_VV[$k]}_SameSign
    ./split_filelist.sh analysisMacro_ztt.conf ${names_VV[$k]} 30
    ./split_filelist.sh analysisMacro_ztt.conf ${names_VV[$k]}_SameSign 30
      
    k=`expr $k + 1` 
done
