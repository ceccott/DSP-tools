#ifndef {{wave.name|upper}}_HPP
#define {{wave.name|upper}}_HPP

/* Generated with waveform_coeff_header_generator */

// METADATA
#define NUM_COEFF               {{wave.num_coeff}}
#define WAVE_FREQ_HZ            {{wave.fhz}}
#define WAVE_PERIOD_S           {{wave.tp}}
#define WAVE_SAMPLE_PERIOD_S    {{wave.ts}}

// COEFFICIENTS

const {{wave.dtype}} {{wave.name}}[NUM_COEFF]=
{
{%- for sample in wave.coeff_data %}
{{sample}}{% if not loop.last %},{% endif %}{%- endfor %}
};


#endif /* ifndef {{wave.name|upper}} */
