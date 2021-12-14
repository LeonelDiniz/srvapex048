select zzc_ccdest, zzc_ccorig, zzc_orcame from PROTHEUS_APEX.zzc010
where d_e_l_e_t_ = ' '
and zzc_orcame in ('RECEITAS.2021','DESPESAS.2021')




select zzc_orcame from protheus_apex.zzc010
where d_e_l_e_t_ = ' '
GROUP BY zzc_orcame

/*
DESPESAS.2020  
RECEITAS.2021  
DESPESAS.2021  
*/

