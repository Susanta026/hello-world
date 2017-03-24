spool compile.log
prompt compiling user objects

DECLARE
    l_vc_user       VARCHAR2 (256);
    l_vc_count      NUMBER;
    l_vc_obj_name   VARCHAR2 (256);
    l_vc_obj_type   VARCHAR2 (256);
BEGIN
    SELECT   USER INTO l_vc_user FROM DUAL;

    DBMS_OUTPUT.put_line ('user is : ' || l_vc_user);
    DBMS_UTILITY.compile_schema (l_vc_user);

    SELECT   COUNT (object_name)
      INTO   l_vc_count
      FROM   user_objects
     WHERE   status = 'INVALID';

    DBMS_OUTPUT.put_line ('Number of invalid objects');
    DBMS_OUTPUT.put_line (l_vc_count);

    FOR i IN (SELECT   object_name, object_type
                FROM   user_objects
               WHERE   status = 'INVALID')
    LOOP
        DBMS_OUTPUT.put_line ('Object Name : ' || i.object_name);
        DBMS_OUTPUT.put_line ('Object Type : ' || i.object_type);
    END LOOP;
END;
/

spool off
