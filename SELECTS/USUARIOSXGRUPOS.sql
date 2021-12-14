SELECT DISTINCT
    --protheus_apex.sys_usr.usr_id,
    protheus_apex.sys_usr.usr_nome as "Nome Completo",
   -- protheus_apex.sys_usr.usr_codigo,
    trim(protheus_apex.sys_usr.usr_email)as "E-mail",
   TRIM(protheus_apex.sys_usr.usr_depto) as "Departamento"
 --protheus_apex.sys_usr.usr_cargo
    --protheus_apex.sys_usr_groups.usr_grupo,
    --protheus_apex.sys_grp_group.gr__nome,
    --protheus_apex.sys_grp_module.gr__modulo
FROM
         protheus_apex.sys_usr
    INNER JOIN protheus_apex.sys_usr_groups ON protheus_apex.sys_usr.usr_id = protheus_apex.sys_usr_groups.usr_id
    INNER JOIN protheus_apex.sys_grp_group ON protheus_apex.sys_usr_groups.usr_grupo = protheus_apex.sys_grp_group.gr__id
    INNER JOIN protheus_apex.sys_grp_module ON protheus_apex.sys_grp_group.gr__id = protheus_apex.sys_grp_module.gr__id
WHERE
    protheus_apex.sys_usr.usr_msblql = 2
    AND protheus_apex.sys_grp_module.gr__modulo in ('04','02','69')

ORDER BY protheus_apex.sys_usr.usr_nome
  --  protheus_apex.sys_usr_groups.usr_id