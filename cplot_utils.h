#ifndef CPLOT_H
#define CPLOT_H

#include <stdio.h>
#include <stdlib.h>

/* Minimal single trace plotting interface based on GNU Plot */

FILE * temp = fopen("data.temp", "w");

// call to append data point
int cplot_append(double x, double y){

    fprintf(temp,"%lf %lf \n",x,y); //Write the data to a temporary file
    return 0;
}

// call to display plot
int cplot_plot(){
	const char * commandsForGnuplot[] = {"set title \"Output Data\"", "plot 'data.temp'"};
    
    FILE * gnuplotPipe = popen ("gnuplot -persistent", "w");

    for (int i=0; i < 2; i++)
    {
    fprintf(gnuplotPipe, "%s \n", commandsForGnuplot[i]); //Send commands to gnuplot one by one.
    }
    return 0;
}

#endif /* ifndef CPLOT_H */
