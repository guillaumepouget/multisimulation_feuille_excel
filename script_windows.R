rm(list=ls())

#rep_multisimu="D:/Home/gpouget/Documents/Stics/fonction feuille excel/multisimulation"
#rep_multisimu="D:/Home/gpouget/Documents/Stics/conversion plan exp vers feuille excel/multisimulation_crau"
#rep_multisimu="D:/Home/gpouget/Documents/Stics/conversion plan exp vers feuille excel/multisimulation_crau_safran"
#rep_multisimu="D:/Home/gpouget/Documents/Stics/test_multisimulation_simspat"
rep_multisimu="D:/Home/gpouget/Documents/Stics/test_multisimulation_simspat/v10/environnement_v10"

stics_version="V10.0"
#stics_version="V9.1"
#stics_version="V8.5"
javastics_path=  "D:/Home/gpouget/Documents/Stics/Stics_v8.5_v9.1_originales/JavaSTICS-1.5.1-STICS-10.0.0"
#javastics_path=  "D:/Home/gpouget/Documents/Stics/Stics_v8.5_v9.1_originales/JavaSTICS-1.41-stics-9.1"
var_names=c("masec_n","mafruit")
#var_names=c("HR_1","HR_2","HR_3","swfac","turfac","teturg","tetstomate","zrac","cumlracz","eop")
ncoeurs=1
option_effacement="non"





path_scripts="D:/Home/gpouget/Documents/Stics/fonction feuille excel/programmes_v4/multisimulation_feuille_excel"

source(file.path(path_scripts, "script_multisim_excel2txt.R"))

### To parallelize ...
for (i in 1:ncoeurs){
  source(file.path(path_scripts, "script_multisim_txt2results.R"))
}

source(file.path(path_scripts, "script_gather.R"))
