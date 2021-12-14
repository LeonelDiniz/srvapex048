--se não tiver sido contabilizado alterar somente e2
select e2_filial, e2_prefixo, e2_num, e2_vencto,e2_valor,e2_vlcruz, e2_saldo, e2_basepis, e2_basecsl, e2_baseiss, e2_baseirf, e2_basecof, e2_baseins
from PROTHEUS_APEX.se2010
--select * from protheus_apex.se2010
where e2_filial = '011001'
and e2_num BETWEEN '10044' and '10047'
and d_e_l_e_t_ = ' '