DROP VIEW VW_FORNEC_CN9

CREATE VIEW AS VW_FORNEC_CN9


SELECT DISTINCT A2_COD AS FORNEC, cn9_xtpmdl AS MODALI, ZZM_DESCRI
FROM CN9010, SA2010, ZZM010
WHERE CN9_XDESCR = A2_NOME
AND cn9_xtpmdl = ZZM_CODIGO
OR cn9_xtpmdl = ' '
and sa2010.d_e_l_e_t_ = ' '
and cn9010.d_e_l_e_t_ = ' '
and ZZM010.d_e_l_e_t_ = ' '