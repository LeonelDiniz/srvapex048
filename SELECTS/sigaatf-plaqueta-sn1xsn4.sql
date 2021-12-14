--SN1 - CADASTRO DE ATIVO IMOBILZIADO
--SN3 - CADASTRO DE SALDOS E VALORES
--SN4 - MOVIMENTAÇÕES DO ATIVO

select *  from PROTHEUS_APEX.sn1010
where d_e_l_e_t_ = ' '
and n1_cbase = '6946';

select * from PROTHEUS_APEX.sn3010
where d_e_l_e_t_ = ' '
and n3_cbase = '6946';

select * from PROTHEUS_APEX.sn4010
where d_e_l_e_t_ = ' '
and n4_cbase = '6946';


select n1_filial, n1_cbase,n1_grupo, n1_chapa from PROTHEUS_APEX.sn1010
where d_e_l_e_t_ = ' '
and n1_cbase not in (select n4_cbase from PROTHEUS_APEX.sn4010
where d_e_l_e_t_ = ' ')
order by n1_filial, n1_cbase;



