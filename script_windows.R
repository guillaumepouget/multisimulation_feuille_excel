rep_multisimu="D:/Home/gpouget/Documents/Stics/fonction feuille excel/multisimulation"
#rep_multisimu="D:/Home/gpouget/Documents/Stics/fonction feuille excel/test_multisimulation_simcrau"
stics_version="V9.1"
#stics_version="V8.5"
javastics_path=  "D:/Home/gpouget/Documents/Stics/Stics_v8.5_v9.1_originales/JavaSTICS-1.41-stics-9.1"
var_names=c("masec_n","mafruit")
ncoeurs=1

path_scripts="D:/Home/gpouget/Documents/Stics/fonction feuille excel/programmes_v4/multisimulation_feuille_excel"

source(file.path(path_scripts, "script_multisim_excel2txt.R"))

### To parallelize ...
for (i in 1:ncoeurs){
  source(file.path(path_scripts, "script_multisim_txt2results.R"))
}

source(file.path(path_scripts, "script_gather.R"))
