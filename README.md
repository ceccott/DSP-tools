# DSPtools

Various tools for DSP purposes:

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

    ​