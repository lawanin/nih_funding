a <- read_csv("departments_nih_funding.csv") 
b <- read_csv("departments_nih_2019.csv") 
c <- read_csv("departments_nih_2018.csv") 
d <- read_csv("departments_nih_2017.csv")
e <- read_csv("departments_nih_2016.csv") 

x <- a %>% 
  left_join(b) %>% 
  left_join(c) %>% 
  left_join(d) %>% 
  left_join(e) 

# Average

x %>% 
  mutate(department_name = if_else(school == "Harvard" & str_detect(department_name, "MICROBIOLOGY|IMMUNO"), "MICROBIOLOGY + IMMUNOLOGY", department_name)) %>% 
  mutate(harvard_equivalent = if_else(school == "Harvard" & str_detect(department_name, "MICROBIOLOGY|IMMUNO"), "Mb;Imm", harvard_equivalent)) %>% 
  group_by(school, department_name, harvard_equivalent) %>% 
  summarize(across(contains("nih"), ~sum(., na.rm = TRUE))) %>% 
  pivot_longer(cols = contains("nih"),
               names_to = c("funding_type", "year"),
               names_sep = "_", 
               values_to = "funding_amount") %>% 
  write_csv("school_departments_2016.csv")

#  Neurobiology

x %>% 
  rowwise() %>% 
  group_by(school, department_name, harvard_equivalent) %>% 
  summarize(across(contains("nih"), ~sum(., na.rm = TRUE))) %>% 
  pivot_longer(cols = contains("nih"),
               names_to = c("funding_type", "year"),
               names_sep = "_", 
               values_to = "funding_amount") %>% 
  filter(str_detect(harvard_equivalent, "^Nb")) -> nb_departments

nb_average <- nb_departments %>% 
  group_by(year) %>% 
  summarize(funding_amount = round(mean(funding_amount, na.rm = TRUE))) %>% 
  mutate(school = "Average") %>% 
  mutate(department_name = "Average") %>% 
  mutate(harvard_equivalent = "Nb") %>% 
  mutate(funding_type = "nih") 

nb_departments %>% 
  bind_rows(nb_average) %>% 
  write_csv("nb_departments_2016_2020.csv")

# DBMI 

x %>% 
  rowwise() %>% 
  group_by(school, department_name, harvard_equivalent) %>% 
  summarize(across(contains("nih"), ~sum(., na.rm = TRUE))) %>% 
  pivot_longer(cols = contains("nih"),
               names_to = c("funding_type", "year"),
               names_sep = "_", 
               values_to = "funding_amount") %>% 
  filter(str_detect(harvard_equivalent, "DBMI")) -> dbmi_departments

dbmi_average <- dbmi_departments %>% 
  group_by(year) %>% 
  summarize(funding_amount = round(mean(funding_amount, na.rm = TRUE))) %>% 
  mutate(school = "Average") %>% 
  mutate(department_name = "Average") %>% 
  mutate(harvard_equivalent = "DBMI") %>% 
  mutate(funding_type = "nih") 

dbmi_departments %>% 
  bind_rows(dbmi_average) %>% 
  write_csv("dbmi_departments_2016_2020.csv")

# Microbiology and Immunology

 x %>%
   rowwise() %>%
   group_by(school, department_name, harvard_equivalent) %>%
   summarize(across(contains("nih"), ~sum(., na.rm = TRUE))) %>%
   pivot_longer(cols = contains("nih"),
                names_to = c("funding_type", "year"),
                names_sep = "_",
                values_to = "funding_amount") %>%
   filter(str_detect(harvard_equivalent, "Mb|Imm")) -> mbimm_departments

mbimm_average <- mbimm_departments %>%
   group_by(year) %>%
   summarize(funding_amount = round(mean(funding_amount, na.rm = TRUE))) %>%
   mutate(school = "Average") %>%
   mutate(department_name = "Average") %>%
   mutate(harvard_equivalent = "Mb;Imm") %>% 
  mutate(funding_type = "nih")
  
  # objects t and u are used to make the following changes for the Tableau chart:
  # For Harvard MICROBIOLOGY and Harvard IMMUNOLOGY, Change 2016-2018 from 0 to match Harvard MICROBIOLOGY AND IMMUNOLOGY numbers;
  # The above concerns three departments at Harvard: MICROBIOLOGY AND IMMUNOBIOLOGY (defunct 2018); MICROBIOLOGY; IMMUNOLOGY

t <- mbimm_departments %>% 
  filter(school == "Harvard", str_detect(department_name, "AND"))

u <- set_names(t$funding_amount, t$year)

# in addition to change above, the mutate functions also replace 2019 and 2020 MICROBIOLOGY AND IMMUNOBIOLOGY 0s with NA

 mbimm_departments %>%
  bind_rows(mbimm_average) %>%
   group_by(year) %>% 
   mutate(funding_amount = if_else(school == "Harvard" & year < 2019 & str_detect(department_name, "AND") == FALSE, u[as.character(year)], funding_amount)) %>%
   mutate(funding_amount = if_else(school == "Harvard" & year >= 2019 & str_detect(department_name, "AND"), na_if(funding_amount, 0), funding_amount)) %>%  
   write_csv("mbimm_departments_2016_2020.csv")


# Genetics

x %>% 
  rowwise() %>% 
  group_by(school, department_name, harvard_equivalent) %>% 
  summarize(across(contains("nih"), ~sum(., na.rm = TRUE))) %>% 
  pivot_longer(cols = contains("nih"),
               names_to = c("funding_type", "year"),
               names_sep = "_", 
               values_to = "funding_amount") %>% 
  filter(harvard_equivalent != "CB;Nb;BCMP;Gn" & str_detect(harvard_equivalent, "Gn")) -> gn_departments

gn_average <- gn_departments %>% 
  group_by(year) %>% 
  summarize(funding_amount = round(mean(funding_amount, na.rm = TRUE))) %>% 
  mutate(school = "Average") %>% 
  mutate(department_name = "Average") %>% 
  mutate(harvard_equivalent = "Gn") %>% 
  mutate(funding_type = "nih") 

gn_departments %>% 
  bind_rows(gn_average) %>% 
  write_csv("gn_departments_2016_2020.csv")

# GHSM

x %>% 
  rowwise() %>% 
  group_by(school, department_name, harvard_equivalent) %>% 
  summarize(across(contains("nih"), ~sum(., na.rm = TRUE))) %>% 
  pivot_longer(cols = contains("nih"),
               names_to = c("funding_type", "year"),
               names_sep = "_", 
               values_to = "funding_amount") %>% 
  filter(str_detect(harvard_equivalent, "GHSM")) -> ghsm_departments

ghsm_average <- ghsm_departments %>% 
  group_by(year) %>% 
  summarize(funding_amount = round(mean(funding_amount, na.rm = TRUE))) %>% 
  mutate(school = "Average") %>% 
  mutate(department_name = "Average") %>% 
  mutate(harvard_equivalent = "GHSM") %>% 
  mutate(funding_type = "nih") 

ghsm_departments %>% 
  bind_rows(ghsm_average) %>% 
  write_csv("ghsm_departments_2016_2020.csv")

# HCP

x %>% 
  rowwise() %>% 
  group_by(school, department_name, harvard_equivalent) %>% 
  summarize(across(contains("nih"), ~sum(., na.rm = TRUE))) %>% 
  pivot_longer(cols = contains("nih"),
               names_to = c("funding_type", "year"),
               names_sep = "_", 
               values_to = "funding_amount") %>% 
  filter(str_detect(harvard_equivalent, "HCP")) -> hcp_departments

hcp_average <- hcp_departments %>% 
  group_by(year) %>% 
  summarize(funding_amount = round(mean(funding_amount, na.rm = TRUE))) %>% 
  mutate(school = "Average") %>% 
  mutate(department_name = "Average") %>% 
  mutate(harvard_equivalent = "HCP") %>% 
  mutate(funding_type = "nih") 

hcp_departments %>% 
  bind_rows(hcp_average) %>% 
  write_csv("hcp_departments_2016_2020.csv")

# BCMP

x %>% 
  rowwise() %>% 
  group_by(school, department_name, harvard_equivalent) %>% 
  summarize(across(contains("nih"), ~sum(., na.rm = TRUE))) %>% 
  pivot_longer(cols = contains("nih"),
               names_to = c("funding_type", "year"),
               names_sep = "_", 
               values_to = "funding_amount") %>% 
  filter(str_detect(harvard_equivalent, "BCMP")) -> bcmp_departments

bcmp_average <- bcmp_departments %>% 
  group_by(year) %>% 
  summarize(funding_amount = round(mean(funding_amount, na.rm = TRUE))) %>% 
  mutate(school = "Average") %>% 
  mutate(department_name = "Average") %>% 
  mutate(harvard_equivalent = "BCMP") %>% 
  mutate(funding_type = "nih") 

bcmp_departments %>% 
  bind_rows(bcmp_average) %>% 
  write_csv("bcmp_departments_2016_2020.csv")

# CB 

x %>% 
  rowwise() %>% 
  group_by(school, department_name, harvard_equivalent) %>% 
  summarize(across(contains("nih"), ~sum(., na.rm = TRUE))) %>% 
  pivot_longer(cols = contains("nih"),
               names_to = c("funding_type", "year"),
               names_sep = "_", 
               values_to = "funding_amount") %>% 
  filter(str_detect(harvard_equivalent, "CB")) -> cb_departments

cb_average <- cb_departments %>% 
  group_by(year) %>% 
  summarize(funding_amount = round(mean(funding_amount, na.rm = TRUE))) %>% 
  mutate(school = "Average") %>% 
  mutate(department_name = "Average") %>% 
  mutate(harvard_equivalent = "CB") %>% 
  mutate(funding_type = "nih") 

cb_departments %>% 
  bind_rows(cb_average) %>% 
  write_csv("cb_departments_2016_2020.csv")

#

# SCRB 

x %>% 
  rowwise() %>% 
  group_by(school, department_name, harvard_equivalent) %>% 
  summarize(across(contains("nih"), ~sum(., na.rm = TRUE))) %>% 
  pivot_longer(cols = contains("nih"),
               names_to = c("funding_type", "year"),
               names_sep = "_", 
               values_to = "funding_amount") %>% 
  filter(str_detect(harvard_equivalent, "SCRB")) -> scrb_departments

scrb_average <- scrb_departments %>% 
  group_by(year) %>% 
  summarize(funding_amount = round(mean(funding_amount, na.rm = TRUE))) %>% 
  mutate(school = "Average") %>% 
  mutate(department_name = "Average") %>% 
  mutate(harvard_equivalent = "SCRB") %>% 
  mutate(funding_type = "nih") 

scrb_departments %>% 
  bind_rows(scrb_average) %>% 
  write_csv("scrb_departments_2016_2020.csv")

# SB 

x %>% 
  rowwise() %>% 
  group_by(school, department_name, harvard_equivalent) %>% 
  summarize(across(contains("nih"), ~sum(., na.rm = TRUE))) %>% 
  pivot_longer(cols = contains("nih"),
               names_to = c("funding_type", "year"),
               names_sep = "_", 
               values_to = "funding_amount") %>% 
  filter(str_detect(harvard_equivalent, "SB")) -> sb_departments

sb_average <- sb_departments %>% 
  group_by(year) %>% 
  summarize(funding_amount = round(mean(funding_amount, na.rm = TRUE))) %>% 
  mutate(school = "Average") %>% 
  mutate(department_name = "Average") %>% 
  mutate(harvard_equivalent = "SB") %>% 
  mutate(funding_type = "nih") 

sb_departments %>% 
  bind_rows(sb_average) %>% 
  write_csv("sb_departments_2016_2020.csv")