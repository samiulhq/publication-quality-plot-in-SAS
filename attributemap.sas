proc format;
 value agefmt 20-29="20-29"
 30-39="30-39"
 40-49="40-49"
 50-59="50-59"
 60-69="60-69";
run;


data attrmap;
retain id "gender";
length value $ 6 fillcolor $ 9 linecolor $ 8 makercolor $ 8;
input value $ fillcolor $ linecolor $ markercolor $;
cards;
Male lightblue blue blue
Female pink maroon maroon
run;
Title height=14pt "Cholesterol Levels by Age Group and Gender" ; 
proc sgplot data=sashelp.heart dattrmap=attrmap;
 format AgeAtStart agefmt.;
 vbox cholesterol / category=AgeAtStart group=sex attrid=gender;
 keylegend /  valueattrs=(size=12pt) titleattrs=(size=14pt) location=inside;
 	xaxis label="Age at Start" labelattrs=(size=14) valueattrs=(size=14);
	yaxis label="Cholesterol" labelattrs=(size=14) valueattrs=(size=14);
run;
