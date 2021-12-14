--AK2 Itens do Orçamento ok
--select * from PROTHEUS_APEX.tmp_iniciativas2021_de_para;
rollback

begin           
for i in (select cod_iniciativa, codcentrocusto_de, codcentrocusto_para from tmp_iniciativas2021_de_para) loop
update ak2010 set ak2_cc = i.codcentrocusto_para where ak2_cc = i.codcentrocusto_de and ak2_orcame like '%2021%' and d_e_l_e_t_ = ' ';
end loop;
end;

--AKD Lançamentos                   
--select * from PROTHEUS_APEX.tmp_iniciativas2021_de_para;
begin
for i in (select cod_iniciativa, codcentrocusto_de, codcentrocusto_para from tmp_iniciativas2021_de_para) loop
update akd010 set akd_cc = i.codcentrocusto_para where akd_cc = i.codcentrocusto_de and akd_codpla like '%2021%' and d_e_l_e_t_ = ' ';
end loop;
end;

--AKF Operações Orçamentárias  OK     
--select * from PROTHEUS_APEX.tmp_iniciativas2021_de_para;
begin
for i in (select cod_iniciativa, codcentrocusto_de, codcentrocusto_para from tmp_iniciativas2021_de_para) loop
update akf010 set akf_xccust = i.codcentrocusto_para where akf_xccust = i.codcentrocusto_de and akf_xano = 2021 and d_e_l_e_t_ = ' ';
end loop;
end;


--CTH Classes de Valores    OK            
--select * from PROTHEUS_APEX.tmp_iniciativas2021_de_para;
begin
for i in (select cod_iniciativa, codcentrocusto_de, codcentrocusto_para from tmp_iniciativas2021_de_para) loop
update cth010 
set cth_xcc = i.codcentrocusto_para,cth_xccuni = i.codcentrocusto_para   
where cth_xcc = i.codcentrocusto_de and cth_xccuni = i.codcentrocusto_de and cth_dtexsf >= '20210101' and d_e_l_e_t_ = ' ';
end loop;
end;


--ZZR DE/PARA CANCEL. INICIATIVA   OK 
--select * from PROTHEUS_APEX.tmp_zzr_de_para;
begin
for i in (select zzr_cc_de, zzr_cc_para from PROTHEUS_APEX.tmp_zzr_de_para) loop
update zzr010 set zzr_cc = i.zzr_cc_para where zzr_cc = i.zzr_cc_de and d_e_l_e_t_ = ' ';
end loop;
end;


--ZZC Transferencia de Dotação      OK
--select * from PROTHEUS_APEX.tmp_zzc_de_para;
begin
for i in (select cc_destino_de, cc_destino_para, cc_origem_de, cc_origem_para from PROTHEUS_APEX.tmp_zzc_de_para) loop
update zzc010 
set zzc_ccdest = i.cc_destino_para,
zzc_ccorig = i.cc_origem_para   
where zzc_ccdest = i.cc_destino_de and zzc_ccorig = i.cc_origem_de and zzc_orcame  like '%2021%' and d_e_l_e_t_ = ' ';
end loop;
end;



commit
