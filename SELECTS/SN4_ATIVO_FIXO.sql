SELECT N4_CBASE  FROM SN4010
WHERE N4_FILIAL = '011001'
and n4_conta = '1241010098'
order by n4_cbase



--select max(r_e_c_d_e_l_)
select  n4_cbase,  MAX(r_e_c_n_o_)
from protheus_apex.sn4010
where n4_conta = '1241010098'
and d_e_l_e_t_ = '*'
GROUP BY N4_CBASE


select  MAX(r_e_c_n_o_)
from protheus_apex.sn4010
