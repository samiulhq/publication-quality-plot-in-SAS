/*An Example code to generate publication quality plot
 Simulated data 
Change path to datafile as needed*/

%let path = '/compute-landingzone/Home/PubReadyPlot/table_APPLE_ACID_DECAY.csv';

proc import 
datafile=&path dbms=csv out=apple replace;
run;
/*convert charecters to numeric for plotting */
data apple;
set apple;
time_var= input(Time,8.);
ascorbic_acid=input(AbConc,8.);
run;

/* options for producing vector images in pdf*/
%let outpath='/compute-landingzone/Home/PublicationReadyPlot/';
%let filename='app_decay';
%let format = pdf;
ods listing gpath=&outpath; 
ods graphics on / 
                          imagefmt=&format
                         imagename=&filename
                         width=6in height=4in
                         noborder noscale;

proc sgplot data=apple; 
styleattrs datacontrastcolors=(red green
 blueviolet);  /*set colors by group*/
where time_var<=8 and Cultivar in ('Royal Gala','Gale Gala','Scarlet Gala');
series x=Time y=ascorbic_acid / group=Cultivar lineattrs=(pattern=solid thickness=2);



scatter x=Time y=ascorbic_acid / group=Cultivar 
markerattrs=(size=10 symbol=CircleFilled);
xaxis label='Time(minutes)' labelattrs=(size=12 family='Arial' weight=bold) 
valueattrs=(size=11) minor minorcount=9;
yaxis label='Ascorbic Acid (mg/100g)' labelattrs=(size=12 family='Arial' weight=bold) 
valueattrs=(size=11 family='Arial') minor minorcount=9;
   legenditem type=markerline name="I1" /
              label="Royal Gala" lineattrs=GraphData1(pattern=solid) markerattrs=GraphData1(symbol=CircleFilled);
   legenditem type=markerline name="I2" /
              label="Scarlet Gala" lineattrs=GraphData2(pattern=solid) markerattrs=GraphData2(symbol=CircleFilled);

    legenditem type=markerline name="I3" /
              label="Gale Gala" lineattrs=GraphData3(pattern=solid) markerattrs=GraphData3(symbol=CircleFilled);

   keylegend "I1" "I2" "I3" /  noborder title="" location=inside position=topright across=1 valueattrs=(Size=12); 
run;




/*Plot lines with errorbar */


/*Step 1: add synthetic stderror to data*/

data apple;
call streaminit(12345);
set apple;
std_err=0.2*abs(rand('normal'));
upper=ascorbic_acid+std_err;
lower=ascorbic_acid-std_err;
run;

proc sgplot data=apple; 
styleattrs datacontrastcolors=(red green
 blueviolet);  /*set colors by group*/
where time_var<=8 and Cultivar in ('Royal Gala','Gale Gala','Scarlet Gala');
series x=Time y=ascorbic_acid / group=Cultivar lineattrs=(pattern=solid thickness=2);



scatter x=Time y=ascorbic_acid / group=Cultivar yerrorlower=lower yerrorupper=upper
markerattrs=(size=10 symbol=CircleFilled);
xaxis label='Time(minutes)' labelattrs=(size=12 family='Arial' weight=bold) 
valueattrs=(size=11) minor minorcount=9;
yaxis label='Ascorbic Acid (mg/100g)' labelattrs=(size=12 family='Arial' weight=bold) 
valueattrs=(size=11 family='Arial') minor minorcount=9;
   legenditem type=markerline name="I1" /
              label="Royal Gala" lineattrs=GraphData1(pattern=solid) markerattrs=GraphData1(symbol=CircleFilled);
   legenditem type=markerline name="I2" /
              label="Scarlet Gala" lineattrs=GraphData2(pattern=solid) markerattrs=GraphData2(symbol=CircleFilled);

    legenditem type=markerline name="I3" /
              label="Gale Gala" lineattrs=GraphData3(pattern=solid) markerattrs=GraphData3(symbol=CircleFilled);

   keylegend "I1" "I2" "I3" /  noborder title="" location=inside position=topright across=1 valueattrs=(Size=12); 
run;



