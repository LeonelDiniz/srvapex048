--- select * from protheus_apex.MPMENU_MENU
/*
 Consultar para verificar o menu de acesso de determinado usuário ou módulo do sistema
*/
SELECT DISTINCT
    --protheus_apex.sys_usr.usr_id,
    protheus_apex.sys_usr.usr_nome as "Nome Completo",
    --protheus_apex.sys_usr.usr_codigo,
    trim(protheus_apex.sys_usr.usr_email)as "E-mail",
    trim(protheus_apex.sys_usr.usr_depto) as "Departamento",
    protheus_apex.sys_usr_groups.usr_grupo as Grupo_Menu,
    protheus_apex.MPMENU_MENU.M_NAME as Menu,
    protheus_apex.MPMENU_MENU.M_MODULE as Modulo,
    protheus_apex.MPMENU_MENU.M_ARQMENU as Local
    --protheus_apex.sys_usr.usr_cargo
    --protheus_apex.sys_usr_groups.usr_grupo,
    --protheus_apex.sys_grp_group.gr__nome,
    --protheus_apex.sys_grp_module.gr__modulo
FROM protheus_apex.sys_usr
    INNER JOIN protheus_apex.sys_usr_groups ON protheus_apex.sys_usr.usr_id = protheus_apex.sys_usr_groups.usr_id
    INNER JOIN protheus_apex.sys_grp_group ON protheus_apex.sys_usr_groups.usr_grupo = protheus_apex.sys_grp_group.gr__id
    INNER JOIN protheus_apex.sys_grp_module ON protheus_apex.sys_grp_group.gr__id = protheus_apex.sys_grp_module.gr__id
    INNER JOIN protheus_apex.MPMENU_MENU ON protheus_apex.MPMENU_MENU.M_ID = protheus_apex.sys_grp_module.GR__ARQMENU
WHERE
    protheus_apex.sys_usr.usr_msblql = 2
    AND protheus_apex.sys_grp_module.gr__modulo = 4 ---   ALTERA ACESSO APENAS AO MÓDULO ESPECÍFICO
     --and protheus_apex.sys_usr.usr_nome like 'Leonel%'
    and protheus_apex.sys_usr.d_e_l_e_t_ = ' '

ORDER BY protheus_apex.sys_usr.usr_nome
  --  protheus_apex.sys_usr_groups.usr_id