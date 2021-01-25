SELECT
    current_database(),
    t.tablename,
    c.reltuples AS num_rows,
    pg_size_pretty(pg_relation_size(quote_ident(t.schemaname)::text || '.' || quote_ident(t.tablename)::text)) AS table_size --,

FROM pg_tables t
LEFT OUTER JOIN pg_class c ON t.tablename = c.relname

WHERE t.schemaname NOT IN ('pg_catalog', 'information_schema') and t.tablename ='event'
;