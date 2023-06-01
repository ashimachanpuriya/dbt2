{% macro run_proc() %}
  {% do run_query("call dbt.public.my_procedure();") %}
{% endmacro %}
