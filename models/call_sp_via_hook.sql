{{
  config(
    post_hook = "call dbt.public.my_procedure();"
  )
}}
select 1 as id
