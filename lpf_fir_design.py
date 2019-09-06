#!/usr/bin/python2

import os
from numpy import cos, sin, pi, absolute, arange
from scipy.signal import kaiserord, lfilter, firwin, freqz
from pylab import figure, clf, plot, xlabel, ylabel, xlim, ylim, title, grid, axes, show
import argparse
import shutil
from jinja2 import Environment, Template, FileSystemLoader, select_autoescape

cwd=os.path.dirname(os.path.abspath(__file__))

parser = argparse.ArgumentParser(description="FIR LPF coefficient generator")
parser.add_argument('-name',dest='name',default='lpf0', type=str, help='header file name')
parser.add_argument('-sr',dest='sr',type=int,help='sample rate [Hz]')
parser.add_argument('-tbw',dest='tbw',type=float,help='transition bandwidth (normalized to sample_rate/2) 0.0 -> 1.0')
parser.add_argument('-sba',dest='sba',type=float,help='attenuation in stop band (dB)')
parser.add_argument('-cut',dest='cut',type=float,help='cutoff frequency (normalized to sample_rate/2) 0.0 -> 1.0')

# parsing arguments
component = parser.parse_args()
nyq_rate = component.sr/2
component.show = True

env = Environment(
        loader     = FileSystemLoader(cwd),
        autoescape = select_autoescape(['html', 'xml'])
)

coeff_hpp=env.get_template("templates/fir_coeff.tpl")

# PRINT FILTER PARAMETERS
print ('sample rate: '+str(component.sr))
print ('transition bw: '+str(component.tbw))
print ('stop-band attenuation: '+str(component.sba))
print ('cutoff freq: '+str(component.cut))
print ('-------------------------------')

#------------------------------------------------
# Create a FIR filter and apply it to x.
#------------------------------------------------

# Compute the order and Kaiser parameter for the FIR filter.
N, beta = kaiserord(component.sba, component.tbw)
print('resulting filter order: '+str(N))

# Use firwin with a Kaiser window to create a lowpass FIR filter.
taps = firwin(N,component.cut, window=('kaiser', beta))

#------------------------------------------------
# Writes coefficients and metadata to header file
#------------------------------------------------

fir = {}
fir['dtype']='double'
fir['type']='lpf'
fir['name']=component.name
fir['num_coeff'] = N
fir['cutoff']=component.cut
fir['samp_rate']=component.sr
fir['coeff_data']=taps

#source code generation based on the templates
with open('fir_coeff_'+component.name+'.hpp', "w") as fh:
    fh.write(coeff_hpp.render(fir=fir))


#------------------------------------------------
# Plot the magnitude response of the filter.
#------------------------------------------------

if component.show:
    figure(2)
    clf()
    w, h = freqz(taps, worN=8000)
    plot((w/pi)*nyq_rate, absolute(h), linewidth=2)
    xlabel('Frequency (Hz)')
    ylabel('Gain')
    title('Amplitude Frequency Response')
    grid(True)

    show()
