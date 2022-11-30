# multisimulation_feuille_excel
 
Variables to be defined in the beginning of script_windows.R :

- rep_multisimu: directory containing 
1. the excel sheet (name should be: *.xlsx), 
2. a "xml" directory containing 1/ a plant directory itself containing the plant files whose name should end with "_plt.xml", 2/ the climate files, 3/ potentially *_ini.xml, *_tec.xml, *_sta.xml, sols.xml files if one have these files available and one doesn't want to regenerate them with the excel sheet -> in this case, for example if one provides the file(s) *_sta.xml, one should not include any "Station" worksheet on the excel sheet
3. a "templates" directory containing (if wanted) the desired xml templates (names of the templates should be: *sol.xml, *tec.xml, *ini.xml, *sta.xml, *usm.xml)
4. an "output" directory in which the txt usms will be created from the different xml files
- stics_version: the Stics version used (use get_stics_versions_compat() to know the full list of stics versions that can be used)
- javastics_path: the Javastics folder
- var_names: a vector of variables names for which results must be returned. example: var_names = c("masec_n","mafruit")
- ncoeurs: number of cores used (ncoeurs = 1 for the moment because the scripts are not parallelized for Windows for the moment)
- path_scripts : the path that contains all the scripts to be used

Then these scripts use the content of the excel sheet and the templates to produce the xml files necessary for Stics: usms.xml, sols.xml, and the ini, tec, station xml files

Then the scripts convert the xml files into txt usms and execute Stics. 

Different results_i.Rdata files are produced for the core number i, each file containing the different variables calculated by Stics for all the usms corresponding to the core number i.

Then these different files are put together in one unique results_final.Rdata file, which is stored in the "output" sub directory of rep_multisimu.

