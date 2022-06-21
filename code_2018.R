library(tidyverse)

# still need to check on illinois and carbondale 

z <- read_delim("source_files/department_list.csv", delim = ",") %>% 
  mutate(department_name = toupper(department_name)) %>% 
  mutate(school = str_replace_all(school, " \\(.*\\)|\\(.*\\)[ ]*", "")) %>% 
  mutate(department_name = str_replace_all(department_name, " \\(.*\\)|\\(.*\\)[ ]*", "")) %>% 
  mutate(department_name = str_replace_all(department_name, "\\*", "")) %>% 
  distinct()

names <- read_csv("nih_aamc_names.csv")

y <- read_delim("source_files/Worldwide_2018.csv", skip = 1, delim = ";") 

# This uses the conversion table generated in the 2020 file. Several of these schools
# have variations in their name (e.g. "SCHOOL AT LOCATION" in 2019 vs "SCHOOL LOCATION" in 2020), 
# consistent and most common. str_detect() strings have been are intended to be
# specific enough to identify only the medical school (even when schools of medicine are not filtered for)
# but as general enough so that it can accomodate the widest amount of variation in future years.

y %>% 
  
  # may be the case for other years
  
  rename_with(toupper) %>% 
  
  # some trailing spaces in pi_name; cause trouble in tableau but not R
  
  mutate(across(.cols = everything(), ~str_replace_all(., " *$", ""))) %>% 
  mutate(`PI NAME` = str_replace_all(`PI NAME`, "\\.$", "")) %>% 
  
  mutate(`NIH MC COMBINING NAME` = if_else(`ORGANIZATION NAME` == "HARVARD UNIVERSITY" & `DEPT NAME` == "STEM CELL AND REGENERATIVE BIOLOGY","SCHOOLS OF MEDICINE",`NIH MC COMBINING NAME`)) %>% 
  filter(`NIH MC COMBINING NAME` == "SCHOOLS OF MEDICINE") %>% 
  mutate(FUNDING = as.numeric(str_replace_all(FUNDING, "\\.|\\$", ""))) %>% 
  arrange(`ORGANIZATION NAME`) %>% 
  rename(nih = `ORGANIZATION NAME`) %>% 
  mutate(nih = case_when(str_detect(nih, "CLEVELAND CLINIC LERNER") ~ "CASE WESTERN RESERVE UNIV/CLEVELAND CLINIC LERNER", 
                         str_detect(nih, "ICAHN") ~ "ICAHN SCHOOL OF MEDICINE MOUNT SINAI",
                         str_detect(nih, "PURDUE.*INDIANAPOLIS") ~ "INDIANA UNIV-PURDUE UNIV INDIANAPOLIS",
                         str_detect(nih, "NORTHWESTERN.*CHICAGO") ~ "NORTHWESTERN UNIVERSITY CHICAGO",
                         str_detect(nih, "RUTGERS.*MED") ~ "RUTGERS, THE STATE UNIVERSITY OF NEW JERSEY",
                         str_detect(nih, "SOUTHERN ILLINOIS.*MED") ~ "SOUTHERN ILLINOIS UNIVERSITY SPRINGFIELD",
                         str_detect(nih, "STATE UNIVERSITY OF NEW YORK.*BUFFALO") ~ "STATE UNIVERSITY OF NEW YORK BUFFALO",
                         str_detect(nih, "TEMPLE") ~ "TEMPLE UNIVERSITY",
                         str_detect(nih, "TEXAS A&M.*HEALTH") ~ "TEXAS A&M UNIVERSITY HEALTH SCIENCE CENTER",
                         str_detect(nih, "TEXAS TECH.*HEALTH") ~ "TEXAS TECH UNIVERSITY HEALTH SCIENCES CENTER",
                         str_detect(nih, "ALABAMA.*BIRMINGHAM") ~ "UNIVERSITY OF ALABAMA BIRMINGHAM",
                         str_detect(nih, "ARKANSAS.*MED") ~ "UNIVERSITY OF ARKANSAS FOR MEDICAL SCIENCES",
                         str_detect(nih, "CALIFORNIA.*DAVIS") ~ "UNIVERSITY OF CALIFORNIA DAVIS",
                         str_detect(nih, "CALIFORNIA.*IRVINE") ~ "UNIVERSITY OF CALIFORNIA IRVINE",
                         str_detect(nih, "CALIFORNIA.*SAN DIEGO") ~ "UNIVERSITY OF CALIFORNIA SAN DIEGO",
                         str_detect(nih, "CALIFORNIA.*SAN FRANCISCO") ~ "UNIVERSITY OF CALIFORNIA SAN FRANCISCO",
                         str_detect(nih, "HAWAII.*MANOA") ~ "UNIVERSITY OF HAWAII MANOA",
                         str_detect(nih, "ILLINOIS.*CHICAGO") ~ "UNIVERSITY OF ILLINOIS CHICAGO",
                         str_detect(nih, "ILLINOIS.*URBANA") ~ "UNIVERSITY OF ILLINOIS URBANA-CHAMPAIGN",
                         str_detect(nih, "MICHIGAN.*ANN") ~ "UNIVERSITY OF MICHIGAN ANN ARBOR",
                         str_detect(nih, "MISSOURI.*COLUMBIA") ~ "UNIVERSITY OF MISSOURI COLUMBIA",
                         str_detect(nih, "NEW MEXICO.*HEALTH") ~ "UNIVERSITY OF NEW MEXICO HEALTH SCIENCES CTR",
                         str_detect(nih, "NORTH CAROLINA CHAPEL HILL") ~ "UNIVERSITY OF NORTH CAROLINA CHAPEL HILL",
                         str_detect(nih, "UNIVERSITY.*PITTSBURGH") ~ "UNIVERSITY OF PITTSBURGH",
                         str_detect(nih, "PUERTO RICO.*MED") ~ "UNIVERSITY OF PUERTO RICO MEDICAL SCIENCES",
                         str_detect(nih, "SOUTH CAROLINA.*COLUMBIA") ~ "UNIVERSITY OF SOUTH CAROLINA COLUMBIA",
                         str_detect(nih, "AUSTIN") ~ "UNIVERSITY OF TEXAS AUSTIN",
                         str_detect(nih, "TOLEDO.*HEALTH") ~ "UNIVERSITY OF TOLEDO HEALTH SCIENCE CAMPUS",
                         str_detect(nih, "VERMONT") ~ "UNIVERSITY OF VERMONT",
                         str_detect(nih, "WISCONSIN.*MADISON") ~ "UNIVERSITY OF WISCONSIN MADISON",
                         str_detect(nih, "VIRGINIA.*TECH") ~ "VIRGINIA POLYTECHNIC INST AND STATE UNIV",
                         str_detect(nih, "^WASHINGTON UNIVERSITY") ~ "WASHINGTON UNIVERSITY ST LOUIS",
                         str_detect(nih, "MED.*CORNELL") ~ "WEILL MEDICAL COLLEGE OF CORNELL UNIVERSITY",
                         # for 2018
                         str_detect(nih, "(LOUISIANA|LSU).*(HSC|HEA.*CENTER)(?! SHREVEPORT)") ~ "LOUISIANA STATE UNIV HSC NEW ORLEANS",
                         str_detect(nih, "T.*SOUTHWESTERN") ~ "UNIVERSITY OF TEXAS SOUTHWESTERN DALLAS",
                         # because of HARVARD UNIVERSITY in SCRB
                         str_detect(nih, "HARVARD") ~ "HARVARD MEDICAL SCHOOL",
                         str_detect(nih, ".*") ~ nih)) %>% 
  left_join(names, .) %>% 
  select(-nih) %>% 
  rename(`ORGANIZATION NAME` = aamc) -> x

# same command as for 2020. 14 of 16 were applicable to 2018.

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
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "Rochester", str_replace_all(`DEPT NAME`, "NEUROBIOLOGY AND ANATOMY", "NEUROSCIENCE"), `DEPT NAME`))  %>% 
  
  # unique to 2019
  
  mutate(`DEPT NAME` = if_else(`ORGANIZATION NAME` == "Iowa-Carver", str_replace_all(`DEPT NAME`, "PHARMACOLOGY", "NEUROSCIENCE AND PHARMACOLOGY"), `DEPT NAME`)) %>% 

  # NIH `PI NAME` sometimes differs for the same person, e.g. GREENBERG, MICHAEL E vs GREENBERG MICHAEL, ELDON; difficult to resolve this issue without looking at each case individually;
  # took care of some cases by deleting periods (e.g. MICHAEL E vs MICHAEL E.); for now, will deal with cases of HARVARD PIs only

  mutate(`PI NAME` = if_else(`ORGANIZATION NAME` == "Harvard" & str_detect(`PI NAME`, "GREENBERG, MICHAEL"), "GREENBERG, MICHAEL E", `PI NAME`)) %>% 
  mutate(`PI NAME` = if_else(`ORGANIZATION NAME` == "Harvard" & str_detect(`PI NAME`, "CHOU, JAMES"), "CHOU, JAMES J", `PI NAME`)) %>% 
  mutate(`PI NAME` = if_else(`ORGANIZATION NAME` == "Harvard" & str_detect(`PI NAME`, "PATEL, CHIRAG"), "PATEL, CHIRAG J", `PI NAME`)) 

departments_funding_2018 <- x_cleaned %>% 
  rename(school = `ORGANIZATION NAME`,
         department_name = `DEPT NAME`) %>% 
  group_by(school, department_name) %>% 
  summarize(`TOTAL FUNDING` = sum(FUNDING)) %>% 
  left_join(z, ., by = c("school", "department_name")) %>%
  select(school, `department_name`, harvard_equivalent, `TOTAL FUNDING`) %>% 
  rename(nih_2018 = `TOTAL FUNDING`) 

full_nih_2018 <- x_cleaned %>% 
  rename(school = `ORGANIZATION NAME`,
         department_name = `DEPT NAME`) %>% 
  left_join(z, ., by = c("school", "department_name"))

write_csv(departments_funding_2018, "departments_nih_2018.csv")
write_csv(full_nih_2018, "full_nih_2018.csv")