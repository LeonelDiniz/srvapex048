select 
date_nfe data
,time_nfe hora
,doc_id numeronf
,cnpjdest cnpj
,a1_nome cliente
,case status
when 1 then 'Nfe Recebida'
when 2 then 'Nfe Assinada'
when 3 then 'Nfe com falha no XML'
when 4 then 'Nfe Transmitida'
when 5 then '***ERRO NFE***'
when 6 then 'Nfe autorizada'
when 7 then 'Nfe Cancelada'
end autorizacao
,trim(sped054.xmot_sefr) mensagem
/*,case statuscanc
when 0 then 'Autorizado'
--when 1 then '1 - A Transmitir'
when 2 then 'Cancelada'
when 3  then 'Falha envio'
end statuscanc*/
,case statusmail
when 0 then 'ERRO TSS'
when 1 then 'Email pendente'
when 2 then 'Email Enviado'
when 3  then 'Falha entrega'
end statusemail
,trim(email) email
,doc_chv chave
--,sped050.nfe_prot protocolo
from sped_apex.sped050 sped050
join sped_apex.sped054 sped054
on sped050.nfe_id = sped054.nfe_id
join protheus_apex.sa1010 a1
on a1.a1_cgc = sped050.cnpjdest
where sped050.d_e_l_e_t_ = ' '
--and date_nfe >= '20211001'
order by doc_id desc