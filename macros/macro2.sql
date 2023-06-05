{% macro stored_proc__pi() %}

    {% set run_proc_2 %}
        {{target.database}}.{{target.schema}}.stored_proc__pi
    {% endset %}
    
    {% set stored_proc_ddl_query %}
        CREATE OR REPLACE PROCEDURE my_procedure_macro()
        RETURNS VARCHAR
        LANGUAGE JAVASCRIPT
        AS
        $$

        var bulkData = [];

        var stmt = snowflake.createStatement({ sqlText: "SELECT * FROM customers" });
        var resultSet = stmt.execute();

        while (resultSet.next()) {
            var id = resultSet.getColumnValue("ID");
            var firstName = resultSet.getColumnValue("FIRST_NAME");
            var lastName = resultSet.getColumnValue("LAST_NAME");

            let model = {
                'id': id,
                'first name': firstName,
                'last name': lastName
            };

            bulkData.push(model);
        }

        var values = bulkData.map(model => `('${model.id}', '${model['first name']}', '${model['last name']}')`).join(', ');
        var insertStatement = `INSERT INTO DBT.PUBLIC.test1 (id, "first name", "last name") VALUES ${values}`;

        snowflake.execute({ sqlText: insertStatement });

        return 'Data inserted successfully';
        $$;
    {% endset %}

    {% do run_query(stored_proc_ddl_query) %}
    {% do log('Created stored proc:\t' ~ run_proc_2, True) %}

    {# return the name of the stored procedure #}
    {%- do return(run_proc_2) %}
    
{% endmacro %}