--AK2 Itens do Orçamento 
--select * from PROTHEUS_APEX.tmp_iniciativas2021_de_para;
rollback

begin          
for i in (select cod_iniciativa, codcentrocusto_de, codcentrocusto_para 
from tmp_iniciativas2021_de_para) loop
update ak2010 set ak2_cc = i.codcentrocusto_para 
where trim(ak2_cc) = i.codcentrocusto_de 
and trim(ak2_clvlr) = i.cod_iniciativa 
and ak2_orcame like '%2021%' 
and d_e_l_e_t_ = ' ';
end loop;
end;

update ak2010 set ak2_cc = '06010901' where ak2_clvlr='00000000000000002801' and ak2_orcame like '%2021%' and ak2_cc='06020701' and d_e_l_e_t_ = ' ';

commit
rollback

----------------------------------------------------------------------------------------------------------------------------------------

--AKD Lançamentos                   
--select * from PROTHEUS_APEX.tmp_iniciativas2021_de_para;
begin
for i in (select cod_iniciativa, codcentrocusto_de, codcentrocusto_para 
from tmp_iniciativas2021_de_para) loop
update akd010 set akd_cc = i.codcentrocusto_para 
where trim(akd_cc) = i.codcentrocusto_de 
and trim(akd_clvlr) = i.cod_iniciativa 
and akd_codpla like '%2021%' 
and d_e_l_e_t_ = ' ';
end loop;
end;

UPDATE akd010 set akd_cc='06030801' where akd_clvlr in ('00000000000000002930','00000000000000002928','00000000000000002801') and akd_codpla like '%2021%' and akd_cc = '06021005';
UPDATE akd010 set akd_cc='06010901' where akd_clvlr in ('00000000000000002930','00000000000000002928','00000000000000002801') and akd_codpla like '%2021%' and akd_cc = '06020701';

commit

----------------------------------------------------------------------------------------------------------------------------------------

--AKF Operações Orçamentárias     
--select * from PROTHEUS_APEX.tmp_iniciativas2021_de_para;
begin 
for i in (select cod_iniciativa, codcentrocusto_de, codcentrocusto_para 
from tmp_iniciativas2021_de_para) loop
update akf010 set akf_xccust = i.codcentrocusto_para 
where trim(akf_xccust) = i.codcentrocusto_de 
and trim(akf_xproje) = i.cod_iniciativa 
and akf_xano = 2021 
and d_e_l_e_t_ = ' ';
end loop;
end;

commit

----------------------------------------------------------------------------------------------------------------------------------------

--CTH Classes de Valores XCC              
--select * from PROTHEUS_APEX.tmp_iniciativas2021_de_para;
begin 
for i in (select cod_iniciativa, codcentrocusto_de, codcentrocusto_para 
from tmp_iniciativas2021_de_para) loop
update cth010 
set cth_xcc = i.codcentrocusto_para   
where trim(cth_xcc) = i.codcentrocusto_de 
and trim(cth_clvl) = i.cod_iniciativa 
and cth_dtexsf >= '20210101' 
and d_e_l_e_t_ = ' ';
end loop;
end;

commit

----------------------------------------------------------------------------------------------------------------------------------------

--CTH Classes de Valores XCCUNI              
--select * from PROTHEUS_APEX.tmp_iniciativas2021_de_para;
begin 
for i in (select cod_iniciativa, codcentrocusto_de, codcentrocusto_para 
from tmp_iniciativas2021_de_para) loop
update cth010 
set cth_xccuni = i.codcentrocusto_para   
where trim(cth_xccuni) = i.codcentrocusto_de 
and trim(cth_clvl) = i.cod_iniciativa 
and cth_dtexsf >= '20210101' 
and d_e_l_e_t_ = ' ';
end loop;
end;

commit
----------------------------------------------------------------------------------------------------------------------------------------

--ZZR DE/PARA CANCEL. INICIATIVA    
--select * from PROTHEUS_APEX.tmp_zzr_de_para;
begin 
for i in (select zzr_cc_de, zzr_cc_para 
from PROTHEUS_APEX.tmp_zzr_de_para) loop
update zzr010 
set zzr_cc = i.zzr_cc_para 
where trim(zzr_cc) = i.zzr_cc_de 
and d_e_l_e_t_ = ' ';
end loop;
end;

commit

----------------------------------------------------------------------------------------------------------------------------------------


--ZZC Transferencia de Dotação Origem     
--select * from PROTHEUS_APEX.tmp_zzc_de_para;
begin 
for i in (select cc_destino_de, cc_destino_para, cc_origem_de, cc_origem_para 
from PROTHEUS_APEX.tmp_zzc_de_para) loop
update zzc010 
set zzc_ccorig = i.cc_origem_para   
where trim(zzc_ccorig) = i.cc_origem_de 
and zzc_orcame  like '%2021%' 
and d_e_l_e_t_ = ' ';
end loop;
end;

commit

----------------------------------------------------------------------------------------------------------------------------------------

--ZZC Transferencia de Dotação Destino     
--select * from PROTHEUS_APEX.tmp_zzc_de_para;
begin 
for i in (select cc_destino_de, cc_destino_para, cc_origem_de, cc_origem_para 
from PROTHEUS_APEX.tmp_zzc_de_para) loop
update zzc010 
set zzc_ccdest = i.cc_destino_para  
where trim(zzc_ccdest) = i.cc_destino_de 
and zzc_orcame  like '%2021%' 
and d_e_l_e_t_ = ' ';
end loop;
end;

commit



