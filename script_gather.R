#this script takes as arguments (which are defined in script_windows.R):

# - rep_multisimu: a directory containing 1 sub directory:
#   the "output" directory in which the different files results_i.Rdata are stored
# - ncoeurs: number of cores used 

#then this script takes the different results_i.Rdata files and put them together in one unique results_final.Rdata file, which is stored in the "output" sub directory of rep_multisimu


if ( (!exists("ncoeurs")) | (!exists("rep_multisimu")) ) {
  args = commandArgs(trailingOnly=TRUE)
  eval(parse(text=args))
}

rep_output=file.path(rep_multisimu, "output")

liste_totale=list(error=FALSE,sim_list=NULL)
  
  for (i in 1:ncoeurs){
    
    load(file.path(rep_output, paste0("results_",i,".Rdata")))
    
    liste_totale$sim_list=c(liste_totale$sim_list, results$sim_list)
    liste_totale$error=liste_totale$error || results$error
    
  }

attr(liste_totale$sim_list, "class")= "cropr_simulation"

save(liste_totale, file = file.path(rep_output, paste0("results_final.Rdata")))

#erase all the files in the output directory except the final list "results_final.Rdata"
contenu_output_dir_apres=dir(file.path(rep_multisimu, "output"))
contenu_output_dir_apres=contenu_output_dir_apres[!grepl("\\.Rdata$", contenu_output_dir_apres)]
setwd(file.path(rep_multisimu, "output"))
unlink(contenu_output_dir_apres, recursive = TRUE)
contenu_output_dir_apres=dir(file.path(rep_multisimu, "output"))
contenu_output_dir_apres=contenu_output_dir_apres[-which(contenu_output_dir_apres == "results_final.Rdata")]
file.remove(contenu_output_dir_apres)