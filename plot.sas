/*An Example coude to generate publication quality plot
 Simulated data based on the paper published by
Arora, Bindvi, et al. "Antioxidant degradation kinetics in apples." Journal of food science and technology 55.4 (2018): 1306-1313.
We plot the Ascorbic acid decay in cut apples across different cultivars.
 
Auhtor:Samiul Haque
Change path to datafile as needed*/

%let path = '/compute-landingzone/Home/PublicationReadyPlot/table_APPLE_ACID_DECAY.csv';

proc import 
datafile=&path dbms=csv out=apple replace;
run;

data apple;
set apple;
time_var= input(Time,8.);
ascorbic_acid=input(AbConc,8.);
run;



ods listing gpath='/compute-landingzone/Home/PublicationReadyPlot/'; 
ods graphics on /
                          imagefmt=pdf
                         imagename="apple_decay"
                         width=6in height=4in
                         noborder;

proc sgplot data=apple; 
styleattrs datacontrastcolors=(red green
 blueviolet);
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