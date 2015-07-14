declare
  l_sql          varchar2(32000);
  l_param_names  t_str_array;
  l_param_values t_str_array;

begin

  l_param_names  := t_str_array ('OWNER');
  l_param_values := t_str_array (:OWNER);

  l_sql := q'[
  select
    u.name as username
  , dts.name as default_tablespace
  , tts.name as temporary_tablespace
  from sys.user$ u, sys.ts$ dts, sys.ts$ tts
  where u.datats# = dts.ts#
  and u.tempts# = tts.ts#
  and u.name = upper(:OWNER)
  ]';

  l_param_names  := t_str_array ('OWNER', 'TABLE_NAME');
  l_param_values := t_str_array (:OWNER, :TABLE_NAME);

  l_sql := q'[
    select
      c1.owner,
      c1.table_name,
      cursor(
        select
          c2.column_name,
          initcap(c2.data_type) ||
          decode(c2.data_type,
                  'CHAR',      '('|| c2.char_length ||')',
                  'VARCHAR',   '('|| c2.char_length ||')',
                  'VARCHAR2',  '('|| c2.char_length ||')',
                  'NCHAR',     '('|| c2.char_length ||')',
                  'NVARCHAR',  '('|| c2.char_length ||')',
                  'NVARCHAR2', '('|| c2.char_length ||')',
                  'NUMBER',    '('||
                   nvl(c2.data_precision,c2.data_length)||
                       decode(c2.data_scale,null,null,
                              ','||c2.data_scale)||')',
                     null) as data_type,
          c2.nullable
        from sys.all_tab_columns c2
        where c1.owner = c2.owner
        and c1.table_name = c2.table_name
        order by c2.column_id
        ) as columns
   from sys.all_tab_columns c1
  where c1.owner = nvl(:OWNER, user)
    and (:TABLE_NAME is null or
         instr(upper(c1.table_name),upper(:TABLE_NAME)) > 0)
    and substr(c1.table_name,1,4) != 'BIN$'
    and substr(c1.table_name,1,3) != 'DR$'
  order by c1.owner, c1.table_name
  ]';

  l_sql := q'[
    select
      t.*
    , cursor(
        select c.*
        from sys.all_tab_columns c
        where t.owner = c.owner
        and t.table_name = c.table_name
        order by c.column_id
        ) as columns
   from sys.all_tables t
  where t.owner = nvl(:OWNER, user)
    and (:TABLE_NAME is null or
         instr(upper(t.table_name),upper(:TABLE_NAME)) > 0)
    and substr(t.table_name,1,4) != 'BIN$'
    and substr(t.table_name,1,3) != 'DR$'
  order by t.owner, t.table_name
  ]';

  dbms_output.put_line(json_util_pkg.sql_to_json(l_sql, l_param_names, l_param_values));
end;
/
