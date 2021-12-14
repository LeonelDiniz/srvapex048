select * from protheus_apex.sx2010 where x2_chave = 'SZG' and d_e_l_e_t_= ' '

select * from protheus_apex.sx3010 where x3_arquivo = 'SZG' and d_e_l_e_t_= ' '

select * --ra_filial, ra_mat, ra_nome, ra_email
from protheus_apex.sra010 where d_e_l_e_t_= ' '

order by r_e_c_n_o_ desc

select * from protheus_apex.sa2010
where a2_filial = ' '
--and a2_nome like 'TIAGO DE MORAIS%'
order by r_e_c_n_o_ desc



select * from protheus_apex.szg010
where zg_filial = ' '
--and zg_email = 'LEONEL.DINIZ@APEXBRASIL.COM.BR'
and d_e_l_e_t_= ' '
order by r_e_c_n_o_ desc

select * from protheus_apex.srb010
where rb_filial = '011001'
and rb_mat = '02123'
--and rb_nome like 'TIAGO DE MORAIS%'
and d_e_l_e_t_= ' '
--order by r_e_c_n_o_ desc


