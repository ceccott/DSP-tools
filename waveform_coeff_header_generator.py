#!/usr/bin/env python2

import os
import sys
import math
import argparse
import shutil
import matplotlib.pyplot as plt
from jinja2 import Environment, Template, FileSystemLoader, select_autoescape

cwd=os.path.dirname(os.path.abspath(__file__))

parser = argparse.ArgumentParser(description="Generate HLS component project")
parser.add_argument('-name',dest='name',default='coeff', type=str, help='header file name')
parser.add_argument('-f', dest='fhz',   type=str, help= 'frequency in Hz')
parser.add_argument('-sf', dest='sampf', default=20,   type=int, help= 'sampling factor (default:20)')
parser.add_argument('-a', dest='ampv', default=1, type=str, help= 'amplitude in V')
parser.add_argument('-phi0', dest='phi0', default=0, type=str, help= 'phase shift in rads')
parser.add_argument('-shape', dest='shape', type=str, help= 'waveform shape [tri saw square sin]')
#parser.add_argument('-np',dest='np',type=int, help='number of periods, (default 1)')
parser.add_argument('-dtype', dest='dtype',  help= 'samples data type [int,int64,float,double]')

def triangular(a,f,t,phi0):
    return a*(2/math.pi)*math.asin(math.sin(math.pi*2*f*t +phi0))
    # return 2*abs(a-(3*a*f*(t+ 1/(2*f) + phi0/(2*math.pi*f)) % (2*a)))-a

def sawtooth(a,f,t,phi0):
    return (2*a*f*(t+phi0/(2*math.pi*f)) % (2*a)) - a

def square(a,f,t,phi0):
    pass

def sine(a,f,t,phi0):
    # print a,f,t,phi0
    return math.sin(2*math.pi*f*t + phi0)*a


sample_fun={'tri':triangular,'sqr':square,'sin':sine,'saw':sawtooth}

if __name__ == "__main__":
    print "Waveform Coefficients header file generator"

    env = Environment(
        loader     = FileSystemLoader(cwd),
        autoescape = select_autoescape(['html', 'xml'])
    )

    # parsing
    component = parser.parse_args()
    component.name = str(component.name)

    coeff_hpp=env.get_template("templates/coeff_hpp.tpl")

    #converting to dict
    wave= vars(component)

    #computing metadata
    a = float(wave['ampv'])
    phi0 = float(wave['phi0'])
    fhz = float(wave['fhz'])
    tp = 1/float(wave['fhz'])
    ts = tp/wave['sampf']
    num_coeff = wave['sampf']

    coeff_data = []

    wave_fun = sample_fun[wave['shape']]

    for i in range(num_coeff):
        t = ts*i
        coeff_data.append(wave_fun(a,fhz,t,phi0))

    X = range(num_coeff)
    plt.plot(X, [coeff_data[x] for x in X])

    #adding metadata and data to dict
    wave.update({'tp':tp,'ts':ts,'num_coeff':num_coeff,'coeff_data':coeff_data})

    #source code generation based on the templates
    with open(component.name+'.hpp', "w") as fh:
            fh.write(coeff_hpp.render(wave=wave))

    print "--generated coefficients header file"

    print "Done."

    # show waveform
    plt.show()

