{% macro dol_eur(colm, deci=2) -%}
    round( 0.89 * {{ colm }}, {{ deci }})
{%- endmacro %}