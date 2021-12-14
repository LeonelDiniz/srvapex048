--ERRO ARGO VALOR MULTIPLICADO
select 
e2_prefixo, 
e2_num, 
e2_naturez,
e2_emissao,
e2_baixa,
e2_la,
e2_valor,
--e2_valor*&parcela NovoValor,
e2_txmoeda,
e2_vlcruz,
--(e2_valor*&parcela)*e2_txmoeda NovoValCruz,
e2_saldo,
e2_basepis,
e2_basecsl,
e2_baseiss,
e2_baseirf,
e2_basecof,
e2_baseins
from PROTHEUS_APEX.se2010
where d_e_l_e_t_ = ' '
and e2_emissao >= '20210101' 
and e2_prefixo = 'PTC'
and e2_num = '&numero'
