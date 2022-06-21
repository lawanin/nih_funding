DESCRIPTION
In Fall 2021, IPP Intern made list of basic science departments for all AAMC schools
and their equivalent departments at Harvard, as he determined them. 
This list is source_files/department_list.csv

He combined that list with 2016-2020 NIH Funding data to produce two groups of files:
1. departments_nih_funding.csv (2020, otherwise departments_nih_year.csv) , a list 
of the basic science departments of all AAMC schools, their harvard_equivalents, 
and their total NIH funding for the given year
2. full_nih_funding.csv (2020, otherwise full_nih_funding_year.csv), a list of 
the basic science departments of all AAMC schools, their harvard equivalents, 
and data on every NIH grant awarded to these departments in the given year

As part of the combining process, he had to convert between abbreviated AAMC and NIH nomenclature. 
He produced a table to facilitate future coversion. This table is nih_aamc_names.csv

When making the Tableau workbook, he used the combined departments_nih_funding to make 
files for each harvard_equivalent that contains A) the fundings that those departments
recieved each year and B) a new row containing the average funding recieved by those
departments each year. Because some departments have multiple harvard_equivalents, 
he found it easier to make a separate document for each harvard_equivalent. These
are used to make the line graphs in the the nih_tableau.twb. For Microbiology and Immunology, 
there is code that changes the usual handling of NA funding values in order to change 
the look of the Harvard line (see code and the Tableau workbook).

CAVEATS
1. The intern determined Harvard equivalents with little knowledge of the full scope
of each Harvard department and even less knowledge of each competitor department.
He had perused the website for each basic science department at Harvard and matched
each competitor department usually only by looking at its name, at other times also by a
cursory look through the competitor department's website. Departments like Microbiology,
Immunology, and Biomedical Informatics have names common to departments at many schools. 
Departments like BCMP and SCRB have uncommon names. At times, multiple competitors were assigned. 
At times, none were assigned. 

The criteria for assigning Harvard equivalents are as follows:
Neurobiology: Dept. name contains Neurobiology, Neuroscience, Brain, or the like
DBMI: Name contains Informatics, (Bio)statistics, or the like
Microbiology/Immunology: Name contains either Microbiology or Immunology
Genetics: Name contains Genetics, Gene, or the like
Cell Biology: Name contains cell or cellular, outside the context of stem cells
BCMP: Name contains either Chemistry, (Bio)physics, Molecular, or Pharmacology
Systems Biology: Name contains Systems Biology or Computational Biology, or the like
SCRB: Name contains Stem or Regenerative
GHSM: Non-stem department that does not contain the word policy
HCP: Non-stem department that does contain the word policy

2. The list, with few exceptions, only includes departments of medical schools:
  Other organizational units (e.g. centers, institutes) at medical schools that compete with Harvard departments 
  and that may recieve NIH funding are thus not included in either department_list.csv
  or the non-source files with NIH funding. Such organizational units are not in all schools and 
  usually recieve less funding than departments. 

  Other university departments that are not part of a medical school (e.g. FAS Molecular and Cellular Biology) 
  that compete with Harvard departments and that may recieve NIH funding are thus
  also not included in either department_list.csv or the non-source files with NIH funding. 
  Harvard Medical School recieves much more NIH funding than FAS departments, for reference. 
  
  If such departments or other organizational units recieved NIH funding, they are 
  included in source_files/Worldwide_2020.csv

3. The NIH data as obtained from BRIMR Report has some flaws in reporting PIs. 
PI ID is not always assigned and is not always consistent. A few PI Names may be
incosistent for the same PI. Regular errors, such as trailing spaces or the incosistent
inclusion of a period after the middle initial, have been corrected in the code. 
Less regular errors, such as a variant middle name (e.g. GREENBERG, MICHAEL E and GREENBERG, MICHAEL ELDON)
have been corrected only for Harvard PIs. Such a variant middle name occurs for approximately
200 PIs in the 2016-2020 data. Data at the PI level should be treated with caution.

NEXT STEPS
1. Prepare more years. Provided there are no changes to the format of the data, 
the code should work for multiple years. However, manual checking for changes 
in school and department names would be necessary. Choosing a small groups of competitor 
schools, which would be prioritized in manual checking, could expedite this process. 

2. Address the issue of the same PI with different (middle) names. This occurs 
for about 200 of 12000 PIs. As above, choosing a small groups of competitor 
schools, which would be prioritized in manual checking, could expedite this process.

3. Better define competitors. Get input from HMS researchers on who competitors are. 
Though medical school departments, typically earn more than both medical school centers
and non-medical school departments, the data would be more complete if one were to  
look through such grant recieving bodies and identify potential competitors. 

NOTES
schools in AAMC, no Basic Science Departments, i.e. not in Department List:
California
Central Michigan
Illinois-Carles (none found, no organizational chart to confirm)
Quinnipiac-Netter
UNLV Kerkorian

in AAMC, not in NIH 2020:
California
California Northstate
Central Michigan
Geisinger Commonwealth
Hackensack Meridian
Kaiser Permanente-Tyson
Illinois-Carles
NYU Long Island
Oakland Beaumont
Rutgers RW-Johsnson (but RW-Johnson departments are included under Rutgers in NIH)
San Juan Bautista
South Carolina Greenville
Texas Tech-Foster
Uniformed Services-Herbert
Western Michigan-Stryker
Zucker Hofstra Northwell

in NIH 2020, not in AAMC:
Oklahoma State (D.O.)
UT Tyler (no M.Ds awarded)
Alaska Anchorage (dual enrollment with U Washington)
Southern Illinois Springfield and Carbondale not distinguished in AAMC (departments of both are included in NIH)
Charles R. Drew (dual enrollment with UC Los Angeles)

no departments specified in NIH 2020:
Einstein
Mayo-Alix

updates to NIH Table from recent department name change:
Arkansas: Physiology and Biophysics to Physiology and Cell Biology
Cincinnati: ENVIRONMENTAL HEALTH to ENVIRONMENTAL AND PUBLIC HEALTH SCIENCES
Columbia: Joint Centers for Systems Biology to Systems Biology
Dartmouth-Geisel: DARTMOUTH INSTITUTE FOR HEALTH POLICY AND CLINICAL PRACTICE, remove Dartmouth Institute"
Emory: PHARMACOLOGY to PHARMACOLOGY AND CHEMICAL BIOLOGY
Indiana: Anatomy and Cell Biology to Anatomy Cell Biology and Physiology
Indiana: Biostatistics to Biostatistics and Health Data Science
Iowa-Carver: Biochemistry to BIOCHEMISTRY AND MOLECULAR BIOLOGY
"Kansas: PREVENTIVE MEDICINE AND PUBLIC HEALTH to POPULATION HEALTH (unsourced, execpt the fact that population health has a public health program)
Massachusetts: QUANTITATIVE HEALTH SCIENCES TO POPULATION AND QUANTITATIVE HEALTH SCIENCES
MC Wisconsin: Cell Biology Neurobiology and Anatomy (CBNA) to remove parentheses
Missouri Kansas City: Informatic Medicine and Personalized Health to Biomedical and Health Informatics
Renaissance Stony Brook: Molecular Genetics and Microbiology to Microbiology and Immunology
Rochester: NEUROBIOLOGY AND ANATOMY TO NEUROSCIENCE
Rush: Cell and Molecular Medicine to Anatomy and Cell Biology
UC Riverside: Center for Healthy Communities to SOCIAL MEDICINE POPULATION AND PUBLIC HEALTH
"UC San Fransisco: Anthropology, Hist and Social Med Humanities and Social Sciences "

changes in department list to accomodate NIH 2020:
Alabama: Biochemistry and Molecular Genetics to Molec
Arizona Phoenix: school to Arizona (Phoenix)
Arkansas: NEUROBIOLOGY AND DEVELOPMENTAL SCIENCES to SCIS
Brown: Molecular Biology Cell Biology and Biochemistry to Biol
Brown: Molecular Pharmacology Physiology and Biotechnology to MOLECULAR PHARM BIOTECH
Caribe: Neurosciences to Neuroscience (as in other Caribe source)
Case Western: Molecular Biology and Microbiology to Molecular Biol and Microbiology
Chicago-Pritzker: Pharmacological and Physiological Sciences to SCIS
Chicago-Pritzker: CANCER RESEARCH to BEN MAY DEPARTMENT FOR CANCER RESEARCH (out of respect for donors)
Colorado: Biochemistry and Molecular Genetics to Molec
Creighton:Pharmacology and Neuroscience to Pharmacology (and Neuroscience)
Florida: Molecular Genetics and Microbiology to Microbiol
Florida: PATHOLOGY IMMUNOLOGY AND LABORATORY MEDICINE to IMMUNOL AND LAB
Geffen: Microbiology Immunology and Molecular Genetics to Immun and Molec
Geffen: Molecular and Medical Phamacology to Med
Georgetown: Biochemistry Molecular and Cellular Biology to Biochemistry, Molec Biology and Cell Biology
Hawaii-Burns: ANATOMY BIOCHEMISTRY AND PHYSIOLOGY to BIOCHEM
Howard: BIOCHEMISTRY AND MOLECULAR BIOLOGY to BIOCHEM
Loma-Linda: Consolidated 5 divisions within Basic Science Department to BASIC SCIENCES(...)
Loma-Linda: Included Pathology and Human Anatomy
Loyola: Molecular Pharmacology and Neuroscience to Molecular Pharmacology and Therapeutics (and Neuroscience)
LSU New Orleans:  Pharmacology to Pharmacology and Experimental Therapeutics (as in another LSU source)
LSU New Orleans: MICROBIOLOGY IMMUNOLOGY AND PARASITOLOGY to IMMUN
Meharry: Biochemistry Cancer Biology Neuroscience and Pharmacology to Biochemistry and Cancer Biology (Neuroscience and Pharmacology)
Meharry: MICROBIOLOGY IMMUNOLOGY AND PHYSIOLOGY to MICROBIOLOGY AND IMMUNOLOGY (AND PHYSIOLOGY)
Michigan: Neuroscience to (Translational) Neuroscience
Minnesota: Microbiology to Microbiology and Immunology
Morehouse: 	MICROBIOLOGY, BIOCHEM AND IMMUNOLOGY to BIOCHEM
Mount Sinai:Changed PATHOLOGY MOLECULAR AND CELL-BASED MEDICINE to PATHOLOGY (MOLECULAR AND CELL-BASED MEDICINE)
Nebraska: BIOCHEMISTRY AND MOELCULAR BIOLOGY to MOLEC
New York Medical: Split Pathology Microbiology and Immunology into two departments 
North Dakota: Added PHARMACOLOGY, PHYSIOLOGY, AND THERAPEUTICS
Oklahoma: Biochemistry and Molecular Biology to BIOL
Oregon: Added Biochemistry and Molecular Biology and Physiology and Pharmacology
Oregon: Added Computation Biology, not a department but center. Added Computational Biology, listed as clinical."
Oregon: Added BIOCHEMISTRY AND MOLECULAR BIOLOGY (OLD) and PHYSIOLOGY AND PHARMACOLOGY (OLD); current Chemical Physiology and Biochemistry is a merger of two departments. The old ones are listed in NIH.
Ponce: originally one basic science department, added subdivisions as they appear in NIH 2020
Rutgers New Jersey:  Microbiology Biochemistry and Molecular Genetics to Biochem
Rutgers RW-Johson: School to Rutgers New Jersey (RW Johsnon)
St Louis: Pharmacology and Physiology to Pharmacological and Physiological Science
TCU UNTHSC: Added Insistitute for Cancer Research
Temple-Katz: Medical Genetics and Biochemistry to MOLEC
Temple-Katz: Replaced bigger departments with subdepartments, old departments in parentheses. Defaulted to NIH name for subdepartment if conflict with website
Tennessee: Pharmacology Addiction Science and Toxicology to Pharmacology (Addiction Science and Toxicology)
Texas Tech: CELLULAR PHYSIOLOGY AND MOLECULAR BIOPHYSICS to MOLEC
Tufts: Developmental Molecular and Chemical Biology to Developmental Molec and Chemical Biol
UT Houston-McGovern: MICROBIOLOGY AND MOLECULAR GENETICS to MOLEC
UT Medical Branch: Preventive Medicine and Population Health to Preventive Medicine and Community Health (agrees with other UTMB source)
UT San Antonio-Long: Added EPIDEMIOLOGY AND BIOSTATISTICS
UT San Antonio-Long: MICROBIOLOGY IMMUNOLOGY AND MOLECULAR GENETICS to MOLEC
Virginia: Microbiology Immunology and Cancer Biology to Immun
Wake Forest: Biostatistics and Data Science to Biostatistical Sciences
Wayne State: split Biochemistry Immunology and Microbiology into Biochemistry and Molecular Biology and Immunology and Microbiology (two PhD granting programs within one dept.)
West Virginia: PHYSIOLOGY AND PHARMACOLOGY TO PHYSIOLOGY (AND) PHARMACOLOGY (AND NEUROSCIENCE); Seems to have done a recent back and forth on name of Physiology and Pharmacology Department
Wisconsin: Biostatistics and Medical Informatics to Med
Wright State-Boonshoft: BIOCHEMISTRY AND MOLECULAR BIOLOGY to MOLEC
Wright State-Boonshoft: NEUROSCIENCE CELL BIOLOGY AND PHYSIOLOGY to BIOL

other notes:
Florida State: One Biomedical sciences Department  divided into three graduate programs, which have been listed as departments: BIOMEDICAL SCIENCES, NEUROSCIENCE, MOLECULAR BIOPHYSICS; unclear whether larger department or subdivision is in NIH 2020
Rutgers: Note- after merging of two school there are two pathologies, both PATHOLOGY AND LABORATORY MEDICINE and PATHOLOGY IMMUNOLOGY AND LABORATORY MEDICINE, latter left unmatched
UCF: School of Medicine treated as one department in NIH
Wayne State: Note- Opthamology department in NIH does not include Anatomy

SOURCES
Basic Science Departments- The intern recorded university sources used to determine
basic science departments in most but not all cases. Find these in list_sources/

AAMC Names- downloadable report from AAMC Medical School Profile System with 2019 data

NIH Funding- http://www.brimr.org/NIH_Awards/NIH_Awards.htm

AUTHOR
Nosa Lawani, IPP Intern 2021-22