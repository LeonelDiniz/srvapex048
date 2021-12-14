select akd_cc, akd_codpla
from protheus_apex.akd010
where akd_cc = '06010602'
--and akd_codpla like '%2021'
and akd_codpla in ('RECEITAS.2021','ME.RECEITA.2021','DESPESAS.2021','ME.DESPESA.2021')
and d_e_l_e_t_ = ' '


/*
DESPESAS.2020  
RECEITAS.2021  
RECEITAS.0     
RECEITAS.2019  
DESPESAS.0     
ME.RECEITA.2021
DESPESAS.2021  
RECEITAS.2020  
DESPESAS.2019  
ME.DESPESA.2021
*/

select AKD_CODPLA from akd010
where d_e_l_e_t_ = ' '
GROUP BY AKD_CODPLA