{{
  config(
    post_hook = "call dbt.public.my_procedure_macro();"
  )
}}
select 1 as id
