#this script takes as arguments (which are defined in script_windows.R):

# - rep_multisimu: a directory containing both a "xml" and an "output" sub-directory (see the header of script_multisim_excel2txt.R for the content of these sub-directories) 
# - javastics_path: the Javastics folder
# - var_names: a vector of variables names for which results must be returned. example: var_names = c("masec_n","mafruit")
# - ncoeurs: number of cores used 
# - i: number of the job (1 < i <= ncoeurs)

# note 1 : if one wants to use the program on a personal computer, just put ncoeurs=i=1

# note 2 : if one wants to force the param_gen.xml and param_newform.xml files, one just needs to put the modified param_gen.xml and param_newform.xml files in the rep_xml directory

# then this script converts the xml files into txt usms and executes Stics. the output of the function is a list containing 
# the different variables calculated by Stics for all the usms defined


if ( (!exists("rep_multisimu")) | (!exists("javastics_path")) | (!exists("var_names")) | (!exists("ncoeurs")) | (!exists("i")) ) {
  args = commandArgs(trailingOnly=TRUE)
  eval(parse(text=args))
  load(file.path(rep_multisimu, "variables.Rdata"))
}
  
#loading the Stics R packages
library(SticsRFiles)
library(SticsOnR)

#executing Stics on the txt usms for the job number i, the results are stored in the results variable
#output_path = file.path(rep_multisimu, "output")
workspace_path = file.path(rep_multisimu, "xml")

liste_usms=get_usms_list(usm_path = file.path(workspace_path, "usms.xml"))
nombre_usms=length(liste_usms)

quotient = nombre_usms %/% ncoeurs
reste = nombre_usms %% ncoeurs

if (reste == 0){
  
  liste_usms_interet=liste_usms[((quotient*(i-1))+1) : (quotient*i)]
  
}else{
  
  if (i <= reste){
    liste_usms_interet=liste_usms[((quotient*(i-1))+1+(i-1)) : (quotient*i+i)]
  }else{
    liste_usms_interet=liste_usms[((quotient*(i-1))+1+reste) : (quotient*i+reste)]
  }
  
}

sim_options = stics_wrapper_options(javastics_path = javastics_path, data_dir = file.path(output_path, "usms"), verbose = FALSE)
results = stics_wrapper(model_options = sim_options, sit_names = liste_usms_interet, var_names = var_names)

#return(results)}
save(results, file = file.path(output_path, paste0("results_",i,".Rdata")))

#erase the files created in the xml directory during the process of generation of txt usms
setwd(file.path(rep_multisimu, "xml"))
file.remove(diff_xml_dir)