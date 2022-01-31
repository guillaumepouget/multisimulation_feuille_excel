#this script takes as arguments (which are defined in script_windows.R):

# - rep_multisimu: directory containing 
#   * the excel sheet (name should be: *.xlsx), 
#   * a "xml" directory containing 1/ a plant directory itself containing the plant files whose name should end with "_plt.xml", 2/ the climate files, 
#   * a "templates" directory containing (if wanted) the desired xml templates (names of the templates should be: *sol.xml, *tec.xml, *ini.xml, *sta.xml)
#   * an "output" directory in which the txt usms will be created from the different xml files
# - stics_version: the Stics version used (use get_stics_versions_compat() to know the full list of stics versions that can be used)
# - javastics_path: the Javastics folder

# then this script uses the content of the excel sheet and the templates to produce the xml files necessary for Stics: usms.xml, sols.xml, 
# and the ini, tec, station xml files 
# after that the script generates the txt usms from the xml files

  
#loading the Stics R packages

if ((!exists("rep_multisimu")) | (!exists("stics_version")) | (!exists("javastics_path"))){
  args = commandArgs(trailingOnly=TRUE)
  eval(parse(text=args))
}

library(SticsRFiles)
library(SticsOnR)

#store the content of the xml dir before generation of the xml and txt files
contenu_xml_dir_avant=dir(file.path(rep_multisimu, "xml"))

#path of the excel sheet
usm_xl_file = file.path(rep_multisimu, list.files(path = rep_multisimu, pattern = "*.xlsx$"))

#path of the templates (sol, tec and/or ini)
path_templates=file.path(rep_multisimu, "templates")

#generating the usms.xml file
usms_param = read_params_table(usm_xl_file, sheet_name = "USMs", num_na = "NA")

if (!is.null(usms_param)){

  usms_out_file = paste0(rep_multisimu, "/xml/usms.xml")
  gen_usms_xml(usms_out_file = usms_out_file, usms_param = usms_param, stics_version = stics_version)

}

#generating the sols.xml file
soils_param = read_params_table(usm_xl_file, sheet_name = "Soils", num_na = "NA")

if (!is.null(soils_param)){

  sols_out_file = paste0(rep_multisimu, "/xml/sols.xml")

  if (length(list.files(path = path_templates, pattern = "*sol.xml$")) > 0){
  
    sols_in_file=file.path(path_templates, list.files(path = path_templates, pattern = "*sol.xml$"))
    gen_sols_xml(sols_out_file = sols_out_file, sols_param = soils_param, sols_in_file = sols_in_file)
  
  }else{
  
    gen_sols_xml(sols_out_file = sols_out_file, sols_param = soils_param, stics_version = stics_version)
  
  }

}
#generating the tec xml files
out_path=file.path(rep_multisimu, "xml")
tec_param = read_params_table(usm_xl_file, sheet_name = "Tec", num_na = "NA")

if (!is.null(tec_param)){

  if (length(list.files(path = path_templates, pattern = "*tec.xml$")) > 0){
  
    tec_in_file=file.path(path_templates, list.files(path = path_templates, pattern = "*tec.xml$"))
    gen_tec_xml(param_table = tec_param, tec_in_file = tec_in_file, out_path = out_path)
  
  }else{
  
    gen_tec_xml(param_table = tec_param, out_path = out_path, stics_version = stics_version)
  
  }

}

#generating the ini xml files
ini_param = read_params_table(usm_xl_file, sheet_name = "Ini", num_na = "NA")

if (!is.null(ini_param)){

  if (length(list.files(path = path_templates, pattern = "*ini.xml$")) > 0){
  
    ini_in_file=file.path(path_templates, list.files(path = path_templates, pattern = "*ini.xml$"))
    gen_ini_xml(param_table = ini_param, ini_in_file = ini_in_file, out_path = out_path)
  
  }else{
  
    gen_ini_xml(param_table = ini_param, out_path = out_path, stics_version = stics_version)
  
  }

}
  
#generating the station xml files
sta_param = read_params_table(usm_xl_file, sheet_name = "Station", num_na = "NA")

if (!is.null(sta_param)){

  if (length(list.files(path = path_templates, pattern = "*sta.xml$")) > 0){
  
    sta_in_file=file.path(path_templates, list.files(path = path_templates, pattern = "*sta.xml$"))
    gen_sta_xml(param_table = sta_param, sta_in_file = sta_in_file, out_path = out_path)
  
  }else{
  
    gen_sta_xml(param_table = sta_param, out_path = out_path, stics_version = stics_version)
  
  }

}

#generating the txt usms from the xml files
workspace_path = file.path(rep_multisimu, "xml")
output_path = file.path(rep_multisimu, "output")

gen_usms_xml2txt(javastics_path = javastics_path, workspace_path = workspace_path, target_path = output_path)

#erase the files created in the xml directory during the process of generation of txt usms

if (option_effacement_fichiers == "oui"){
  
  contenu_xml_dir_apres=dir(file.path(rep_multisimu, "xml"))
  diff_xml_dir=setdiff(contenu_xml_dir_apres, contenu_xml_dir_avant)
  setwd(file.path(rep_multisimu, "xml"))
  file.remove(diff_xml_dir)
  
}

#erase the files created in the xml directory during the process of generation of txt usms


