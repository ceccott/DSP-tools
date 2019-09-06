#ifndef FIR_COEFF_HPP
#define FIR_COEFF_HPP

/*  Generated with lpf_fir_design.py  */

// METADATA
#define NUM_COEFF               {{fir.num_coeff}}
#define FILTER_TYPE             "{{fir.type}}"
#define SAMPLE_RATE             {{fir.samp_rate}}
#define CUTOFF_NYQ              {{fir.cutoff}}

// FILTER COEFFICIENTS

const {{fir.dtype}} {{fir.name}}[NUM_COEFF]=
{
{%- for sample in fir.coeff_data %}
{{sample}}{% if not loop.last %},{% endif %}{%- endfor %}
};


#endif /* ifndef FIR_COEFF_HPP */
