select ak2_cc 
from protheus_apex.ak2010
where ak2_cc = '06010602'
and ak2_orcame in ('RECEITAS.2021','ME.RECEITA.2021','DESPESAS.2021','ME.DESPESA.2021')
and d_e_l_e_t_ = ' '


select AK2_ORCAME from protheus_apex.ak2010
where d_e_l_e_t_ = ' '
GROUP BY AK2_ORCAME

/*
DESPESAS.2020  
RECEITAS.2021  
ME.RECEITA.2021
RECEITAS.2020  
DESPESAS.2021  
ME.DESPESA.2021
*/