select
    cth_clvl id_projeto
    ,cth.cth_desc01 as nm_projeto
    ,cth.cth_xaprov as cd_lider
    ,(select distinct usr.usr_nome from vw_usrcc usr where usr.usr_id=cth.cth_xaprov and cth.d_e_l_e_t_=' ') as nm_lider
    ,cth.cth_xobjet as CD_objetivo_estrategico
    ,(select  dbms_lob.substr(blob_to_clob(zzk.zzk_dobjet),4000,1)
      from zzk010 zzk 
      where cth.cth_filial=' ' and 
            cth.d_e_l_e_t_=' ' and
            cth.cth_xobjet=zzk.zzk_objeti and rownum<2) as ds_objetivo_estrategico
    ,cth.cth_xdiret as CD_diretriz
    ,(select  dbms_lob.substr(blob_to_clob(zzk.zzk_ddiret),4000,1)
      from zzk010 zzk 
      where cth.cth_filial=' ' and 
            cth.d_e_l_e_t_=' ' and
            cth.cth_xdiret=zzk.zzk_diretr) as ds_diretriz
    ,decode(cth.cth_xpjres,'1','S','2','N',cth.cth_xpjres) as fl_projeto_estrategico
    ,cth_xclade as cd_classe_despesa
    ,f_combo('CTH_XCLADE',cth.cth_xclade) as ds_classe_despesa
    ,cth_ctorca as cd_categoria_orcamento
    ,(select sx.x5_descri 
      from sx5010 sx
      where  cth.cth_filial=' ' and 
             cth.d_e_l_e_t_=' ' and
             sx.x5_chave=cth.cth_ctorca and
             sx.x5_tabela='ZW') as ds_categoria_orcamento,
   cth_xcc as CD_CENTRO_CUSTO,
   (select ctt.ctt_desc01 from ctt010 ctt where ctt.ctt_filial=' ' and cth.cth_xcc=ctt.ctt_custo and ctt.d_e_l_e_t_=' ') as nm_centro_custo,
   cth_xprogr as cd_programa_receita,
   (select ak5_descri from ak5010 ak5 where d_e_l_e_t_ = ' ' and ak5_codigo = cth_xprogr) as nm_programa_receita,
   cth_xprogd as cd_programa_despesa,
   (select ak5_descri from ak5010 ak5 where d_e_l_e_t_ = ' ' and ak5_codigo = cth_xprogd) as nm_programa_despesa,
   cth.CTH_DTEXIS as dt_incio,
   cth.CTH_DTEXSF as dt_termino
from
    protheus_apex.cth010 cth
where
    cth.d_e_l_e_t_ = ' '
and  cth_clvl like '0000%'