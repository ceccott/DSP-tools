# DSPtools

Various tools for DSP purposes:

#### Python

* `waveform_coeff_header_generator.py` to design waveform periods samples and export the coefficients to an header `.hpp` file for C/C++ usage

  * usage example: `./waveform_coeff_header_generator.py -f 100 -sf 100 -a 1 -shape sin -dtype double`

    ```
    optional arguments:
      -h, --help    show this help message and exit
      -name NAME    header file name
      -f FHZ        frequency in Hz
      -sf SAMPF     sampling factor (default:20)
      -a AMPV       amplitude in V
      -phi0 PHI0    phase shift in rads
      -shape SHAPE  waveform shape [tri saw square sin]
      -dtype DTYPE  samples data type [int,int64,float,double]
    ```

    ​


* `lpf_fir_design.py` to design LPF FIR filters (based on scipy.signal.firwin and kaiser window) and export the coefficients to an header `.hpp` file for C/C++ usage

  * usage example: `./lpf_fir_design.py -sr 1000 -tbw 0.2 -sba 20 -cut 0.3`

    ```
    optional arguments:
      -h, --help  show this help message and exit
      -name NAME  header file name
      -sr SR      sample rate [Hz]
      -tbw TBW    transition bandwidth (normalized to sample_rate/2) 0.0 -> 1.0
      -sba SBA    attenuation in stop band (dB)
      -cut CUT    cutoff frequency (normalized to sample_rate/2) 0.0 -> 1.0
    ```



#### C/C++

* `cplot_utils.h` header-only minimal C interface to GNU plot for simple single trace in-code data logging and plotting

  * usage:

    ```
    cplot_append(double x, double y); // to append a data point
    cplot_plot(); 					  // to display plot
    ```



#### Matlab

* Various DSP functions in `./Matlab/`

