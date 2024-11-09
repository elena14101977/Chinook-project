{% macro domain(col_a) %}
  substring( {{col_a}},position('@' in {{col_a}} )+1,length({{col_a}}) )
{% endmacro %}

