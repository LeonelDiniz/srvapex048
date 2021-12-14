select 
zb_fatura Fatura
,zc_solicit OS
--,zc_item Item
,zc_descri Viajante
,zb_tpserv Serviço
,zb_emissao Emissão
,zb_vencto Vencimento
,zc_total VlrFatura
,zb_total VlrOS  
from PROTHEUS_APEX.szb010
join PROTHEUS_APEX.szc010
on zb_codigo = zc_codigo
where PROTHEUS_APEX.szb010.d_e_l_e_t_ = ' '
and PROTHEUS_APEX.szc010.d_e_l_e_t_ = ' '




