library(tidyverse)

# This code takes the files in source_files and outputs three files
  # 1. departments_nih_funding.csv, a list of the basic science departments of all AAMC schools, 
  # their harvard_equivalents, and their total NIH funding for 2020
  # 2. full_nih_funding.csv, a list of the basic science departments of all AAMC schools, 
  # their Harvard equivalents, and data on every NIH grant awarded to these departments in 2020
  # 3. nih_aamc_names.csv, a list that converts between AAMC school names and NIH school names


# department_list.csv is a file made by intern looking at department websites for 
# AAMC schools and assessing Harvard equivalents
# during cleaning, some parentheses were added to department_list.csv. see notes in read_me.txt.
# these are removed here. names with parentheses removed should match NIH table

z <- read_delim("source_files/department_list.csv", delim = ",") %>% 
  mutate(department_name = toupper(department_name)) %>% 
  mutate(school = str_replace_all(school, " \\(.*\\)|\\(.*\\)[ ]*", "")) %>% 
  mutate(department_name = str_replace_all(department_name, " \\(.*\\)|\\(.*\\)[ ]*", "")) %>% 
  mutate(department_name = str_replace_all(department_name, "\\*", "")) %>% 
  
  # after parentheses are removed there are two Medical Education departments, Southern Illinois, 
  # one at (Carbondale) another at (Springfield)
  
  distinct()

y <- read_delim("source_files/Worldwide_2020.csv", skip = 1, delim = ";")

# object x is NIH table with names that match AAMC nomenclature and so department_list.csv

y %>% 
  
  # may be the case for other years
  
  mutate(`NIH MC COMBINING NAME` = if_else(`ORGANIZATION NAME` == "HARVARD UNIVERSITY" & `DEPT NAME` == "STEM CELL AND REGENERATIVE BIOLOGY","SCHOOLS OF MEDICINE",`NIH MC COMBINING NAME`)) %>% 
  filter(`NIH MC COMBINING NAME` == "SCHOOLS OF MEDICINE") %>% 
  mutate(FUNDING = as.numeric(str_replace_all(FUNDING, "\\.|\\$", ""))) %>% 
  arrange(`ORGANIZATION NAME`) %>% 
  mutate(`ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF SOUTHERN CALIFORNIA", "Southern Cal-Keck"),
         # added HARVARD UNIVERSITY because of SCRB
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "HARVARD MEDICAL SCHOOL|HARVARD UNIVERSITY", "Harvard"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "BOSTON UNIVERSITY MEDICAL CAMPUS", "Boston"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "CASE WESTERN RESERVE UNIV/CLEVELAND CLINIC LERNER", "Case Western Reserve"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "JOHNS HOPKINS UNIVERSITY", "Johns Hopkins"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "NORTHWESTERN UNIVERSITY CHICAGO", "Northwestern-Feinberg"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "DREXEL UNIVERSITY", "Drexel"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "GEORGE WASHINGTON UNIVERSITY", "George Washington"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "GEORGETOWN UNIVERSITY", "Georgetown"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "TUFTS UNIVERSITY BOSTON", "Tufts"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "COLUMBIA UNIVERSITY HEALTH SCIENCES", "Columbia-Vagelos"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "OHIO STATE UNIVERSITY", "Ohio State"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF PENNSYLVANIA", "Pennsylvania-Perelman"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "PENNSYLVANIA STATE UNIV HERSHEY MED CTR", "Penn State"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "YALE UNIVERSITY", "Yale"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "STANFORD UNIVERSITY", "Stanford"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "INDIANA UNIV-PURDUE UNIV INDIANAPOLIS", "Indiana"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF WASHINGTON", "U Washington"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "THOMAS JEFFERSON UNIVERSITY", "Jefferson-Kimmel"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "MEDICAL COLLEGE OF WISCONSIN", "MC Wisconsin"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "NEW YORK UNIVERSITY SCHOOL OF MEDICINE", "NYU-Grossman"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF CALIFORNIA SAN FRANCISCO", "UC San Fransisco"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF MIAMI SCHOOL OF MEDICINE", "Miami-Miller"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF MIAMI SCHOOL OF MEDICINE", "Miami-Miller"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF ILLINOIS.*", "Illinois"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "WASHINGTON UNIVERSITY ST LOUIS", "Washington U St Louis"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "TULANE UNIVERSITY OF LOUISIANA", "Tulane"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "DUKE UNIVERSITY", "Duke"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "WAKE FOREST UNIVERSITY HEALTH SCIENCES", "Wake Forest"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "WAYNE STATE UNIVERSITY", "Wayne State"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "WEILL MEDICAL COLLEGE OF CORNELL UNIVERSITY", "Cornell-Weill"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "BROWN UNIVERSITY", "Brown-Alpert"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "ALBERT EINSTEIN COLLEGE OF MEDICINE", "Einstein"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "TEMPLE UNIVERSITY", "Temple-Katz"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "DARTMOUTH COLLEGE", "Dartmouth-Geisel"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF CHICAGO", "Chicago-Pritzker"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF PITTSBURGH", "Pittsburgh"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "EASTERN VIRGINIA MEDICAL SCHOOL", "Eastern Virginia"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "NEW YORK MEDICAL COLLEGE", "New York Medical"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF SOUTH FLORIDA", "USF-Morsani"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "NEW YORK MEDICAL COLLEGE", "New York Medical"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "EMORY UNIVERSITY", "Emory"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF MINNESOTA", "Minnesota"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "MICHIGAN STATE UNIVERSITY", "Michigan State"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF MICHIGAN ANN ARBOR", "Michigan"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "VIRGINIA COMMONWEALTH UNIVERSITY", "Virginia Commonwealth"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "ROSALIND FRANKLIN UNIV OF MEDICINE & SCI", "Chicago Med Franklin"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "LOYOLA UNIVERSITY CHICAGO", "Loyola Stritch"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "SAINT LOUIS UNIVERSITY", "Saint Louis"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "ICAHN SCHOOL OF MEDICINE MOUNT SINAI", "Mount Sinai-Icahn"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF COLORADO DENVER", "Colorado"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "VANDERBILT UNIVERSITY", "Vanderbilt"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF CINCINNATI", "Cincinnati"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "ALBANY MEDICAL COLLEGE", "Albany"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF CALIFORNIA LOS ANGELES", "UCLA-Geffen"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "CREIGHTON UNIVERSITY", "Creighton"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF WISCONSIN MADISON", "Wisconsin"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF IOWA", "Iowa-Carver"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF VERMONT", "Vermont-Larner"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "WEST VIRGINIA UNIVERSITY", "West Virginia"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "SUNY DOWNSTATE MEDICAL CENTER", "SUNY Downstate"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIV OF MASSACHUSETTS MED SCH WORCESTER", "Massachusetts"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF VIRGINIA", "Virginia"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF NORTH CAROLINA CHAPEL HILL", "North Carolina"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF KENTUCKY", "Kentucky"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF TOLEDO HEALTH SCIENCE CAMPUS", "Toledo"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF CALIFORNIA SAN DIEGO", "UC San Diego"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF MARYLAND BALTIMORE", "Maryland"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "STATE UNIVERSITY OF NEW YORK BUFFALO", "Buffalo-Jacobs"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "OREGON HEALTH & SCIENCE UNIVERSITY", "Oregon"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "RUSH UNIVERSITY MEDICAL CENTER", "Rush"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF LOUISVILLE", "Louisville"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "LOMA LINDA UNIVERSITY", "Loma Linda"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UPSTATE MEDICAL UNIVERSITY", "SUNY Upstate"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "RUTGERS, THE STATE UNIVERSITY OF NEW JERSEY", "Rutgers New Jersey"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF UTAH", "Utah"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF TENNESSEE HEALTH SCI CTR", "Tennessee"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF TEXAS HLTH SCI CTR SAN ANTONIO", "UT San Antonio-Long"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "MEDICAL UNIVERSITY OF SOUTH CAROLINA", "MU South Carolina"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "AUGUSTA UNIVERSITY", "MC Georgia Augusta"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "NORTHEAST OHIO MEDICAL UNIVERSITY", "Northeast Ohio"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF TEXAS MED BR GALVESTON", "UT Medical Branch"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF ALABAMA BIRMINGHAM", "Alabama"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "STATE UNIVERSITY OF NEW YORK STONY BROOK", "Renaissance Stony Brook"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "FLORIDA STATE UNIVERSITY", "Florida State"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF OKLAHOMA HLTH SCIENCES CTR", "Oklahoma"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "FLORIDA INTERNATIONAL UNIVERSITY", "FIU-Wertheim"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF MISSOURI KANSAS CITY", "Missouri Kansas City"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "MEHARRY MEDICAL COLLEGE", "Meharry"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF NORTH DAKOTA", "North Dakota"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF ARKANSAS FOR MEDICAL SCIENCES", "Arkansas"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF SOUTH CAROLINA COLUMBIA", "South Carolina Columbia"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "MERCER UNIVERSITY MACON", "Mercer"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF CALIFORNIA DAVIS", "UC Davis"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "LOUISIANA STATE UNIV HSC NEW ORLEANS", "LSU New Orleans"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF MISSOURI COLUMBIA", "Missouri Columbia"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "MAYO CLINIC ROCHESTER", "Mayo-Alix"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF FLORIDA", "Florida"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "HOWARD UNIVERSITY", "Howard"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "LOUISIANA STATE UNIV HSC SHREVEPORT", "LSU Shreveport"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF CALIFORNIA IRVINE", "UC Irvine"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "WRIGHT STATE UNIVERSITY", "Wright State-Boonshoft"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "MOREHOUSE SCHOOL OF MEDICINE", "Morehouse"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF ARIZONA", "Arizona"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF TEXAS HLTH SCI CTR HOUSTON", "UT Houston-McGovern"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF MISSISSIPPI MED CTR", "Mississippi"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "PONCE SCHOOL OF MEDICINE", "Ponce"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF CONNECTICUT SCH OF MED/DNT", "Connecticut"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF CENTRAL FLORIDA", "UCF"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "ROWAN UNIVERSITY", "Cooper Rowan"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF TEXAS SOUTHWESTERN DALLAS", "UT Southwestern"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF NEW MEXICO HEALTH SCIENCES CTR", "New Mexico"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF HAWAII MANOA", "Hawaii-Burns"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "TEXAS TECH UNIVERSITY HEALTH SCIENCES CENTER", "Texas Tech"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "TEXAS A&M UNIVERSITY HEALTH SCIENCE CENTER", "Texas A & M"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "SOUTHERN ILLINOIS UNIVERSITY CARBONDALE", "Southern Illinois"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "SOUTHERN ILLINOIS UNIVERSITY SPRINGFIELD", "Southern Illinois"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSIDAD CENTRAL DEL CARIBE", "Caribe"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF SOUTH DAKOTA", "South Dakota-Sanford"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "EAST TENNESSEE STATE UNIVERSITY", "East Tennessee-Quillen"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF SOUTH ALABAMA", "South Alabama"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF NEVADA RENO", "Nevada Reno"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "MARSHALL UNIVERSITY", "Marshall-Edwards"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "CITY COLLEGE OF NEW YORK", "CUNY"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "FLORIDA ATLANTIC UNIVERSITY", "Florida Atlantic-Schmidt"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "VIRGINIA POLYTECHNIC INST AND STATE UNIV", "Virginia Tech Carilion"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF PUERTO RICO MEDICAL SCIENCES", "Puerto Rico"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "EAST CAROLINA UNIVERSITY", "East Carolina-Brody"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "BAYLOR COLLEGE OF MEDICINE", "Baylor"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF CALIFORNIA RIVERSIDE", "UC Riverside"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "WASHINGTON STATE UNIVERSITY", "Washington State-Floyd"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF TEXAS RIO GRANDE VALLEY", "UT Rio Grande Valley"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF TEXAS AUSTIN", "UT Austin-Dell"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF ROCHESTER", "Rochester"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF NEBRASKA MEDICAL CENTER", "Nebraska"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF KANSAS MEDICAL CENTER", "Kansas"),
         `ORGANIZATION NAME` = str_replace_all(`ORGANIZATION NAME`, "UNIVERSITY OF NORTH TEXAS HLTH SCI CTR", "TCU UNTHSC")) %>% 
  filter(str_detect(`ORGANIZATION NAME`, "[a-z]") == TRUE | `ORGANIZATION NAME` %in% c("CUNY", "UCF", "TCU UNTHSC")) -> x

# a table converting between NIH names and AAMC names

nih_aamc_names <- y %>% 
  filter(`NIH MC COMBINING NAME` == "SCHOOLS OF MEDICINE") %>% 
  inner_join(x, by = c("DEPT NAME", "ORGANIZATION ID (IPF)")) %>% 
  select(`ORGANIZATION NAME.x`, `ORGANIZATION NAME.y`)  %>% 
  rename(nih = `ORGANIZATION NAME.x`) %>% 
  rename(aamc = `ORGANIZATION NAME.y`) %>% 
  distinct()

# correcting discrepancies in department names as found online and as in NIH table.
# see notes in read_me.txt. most discrepancies resolved through direct changes to department_list.csv. 
# see above.

x_cleaned <- x %>%  
  mutate(`DEPT NAME` = str_replace_all(`DEPT NAME`, ",", "")) %>% 
  mutate(`DEPT NAME`  = str_replace_all(`DEPT NAME`, "&", "AND")) %>% 
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "Columbia-Vagelos", str_replace_all(`DEPT NAME`, "JOINT CENTERS FOR SYSTEMS BIOLOGY", "SYSTEMS BIOLOGY"), `DEPT NAME`)) %>% 
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "Indiana", str_replace_all(`DEPT NAME`, "ANATOMY AND CELL BIOLOGY", "ANATOMY CELL BIOLOGY AND PHYSIOLOGY"), `DEPT NAME`)) %>% 
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "Indiana", str_replace_all(`DEPT NAME`, "BIOSTATISTICS", "BIOSTATISTICS AND HEALTH DATA SCIENCE"), `DEPT NAME`)) %>% 
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "MC Wisconsin", str_replace_all(`DEPT NAME`, "ANATOMY \\(.*\\)", "ANATOMY"), `DEPT NAME`)) %>%
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "UC San Fransisco", str_replace_all(`DEPT NAME`, "ANTHROP.*", "HUMANITIES AND SOCIAL SCIENCES"), `DEPT NAME`)) %>% 
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "Dartmouth-Geisel", str_replace_all(`DEPT NAME`, "DARTMOUTH INSTITUTE FOR HEALTH POLICY AND CLINICAL PRACTICE", "HEALTH POLICY AND CLINICAL PRACTICE"), `DEPT NAME`)) %>% 
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "Emory", str_replace_all(`DEPT NAME`, "PHARMACOLOGY", "PHARMACOLOGY AND CHEMICAL BIOLOGY"), `DEPT NAME`)) %>% 
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "Cincinnati", str_replace_all(`DEPT NAME`, "ENVIRONMENTAL HEALTH", "ENVIRONMENTAL AND PUBLIC HEALTH SCIENCES"), `DEPT NAME`)) %>% 
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "Iowa-Carver", str_replace_all(`DEPT NAME`, "BIOCHEMISTRY", "BIOCHEMISTRY AND MOLECULAR BIOLOGY"), `DEPT NAME`)) %>% 
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "Massachusetts", str_replace_all(`DEPT NAME`, "QUANTITATIVE HEALTH SCIENCES", "POPULATION AND QUANTITATIVE HEALTH SCIENCES"), `DEPT NAME`)) %>% 
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "Rush", str_replace_all(`DEPT NAME`, "CELL AND MOLECULAR MEDICINE", "ANATOMY AND CELL BIOLOGY"), `DEPT NAME`)) %>% 
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "Renaissance Stony Brook", str_replace_all(`DEPT NAME`, "MOLECULAR GENETICS AND MICROBIOLOGY", "MICROBIOLOGY AND IMMUNOLOGY"), `DEPT NAME`)) %>% 
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "Missouri Kansas City", str_replace_all(`DEPT NAME`, "INFORMATIC MEDICINE AND PERSONALIZED HEALTH", "BIOMEDICAL AND HEALTH INFORMATICS"), `DEPT NAME`)) %>% 
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "Arkansas", str_replace_all(`DEPT NAME`, "PHYSIOLOGY AND BIOPHYSICS", "PHYSIOLOGY AND CELL BIOLOGY"), `DEPT NAME`)) %>% 
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "UC Riverside", str_replace_all(`DEPT NAME`, "CENTER FOR HEALTHY COMMUNITIES", "SOCIAL MEDICINE POPULATION AND PUBLIC HEALTH"), `DEPT NAME`)) %>% 
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "Kansas", str_replace_all(`DEPT NAME`, "PREVENTIVE MEDICINE AND PUBLIC HEALTH", "POPULATION HEALTH"), `DEPT NAME`)) %>% 
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "Rochester", str_replace_all(`DEPT NAME`, "NEUROBIOLOGY AND ANATOMY", "NEUROSCIENCE"), `DEPT NAME`)) 

# departments_nih_funding is every department in the department_list with its total
# 2020 NIH funding. harvard_equivalents included.

departments_nih_funding <- x_cleaned %>% 
  rename(school = `ORGANIZATION NAME`,
         department_name = `DEPT NAME`) %>% 
  group_by(school, department_name) %>% 
  summarize(`TOTAL FUNDING` = sum(FUNDING)) %>% 
  left_join(z, ., by = c("school", "department_name")) %>%
  select(school, `department_name`, harvard_equivalent, `TOTAL FUNDING`) %>% 
  rename(nih_2020 = `TOTAL FUNDING`) 

# full_nih_funding is the full NIH table for every department in department_list.csv.
# harvard_equivalents included.

full_nih_funding <- x_cleaned %>% 
  rename(school = `ORGANIZATION NAME`,
         department_name = `DEPT NAME`) %>% 
  left_join(z, ., by = c("school", "department_name"))

write_csv(nih_aamc_names, "nih_aamc_names.csv")
write_csv(departments_nih_funding, "departments_nih_funding.csv")
write_csv(full_nih_funding, "full_nih_funding.csv")