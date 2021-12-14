select
    ct2_filial as cod_filial,
    m0_filial as nome_filial,
    m0_fax_po as pais,
    to_date(ct2_data,'yyyymmdd') as data_lancto,
    substr(ct2_data,5,2) as Mes,
    substr(ct2_data,1,4) as Ano, 
    ct2_debito as cod_contacontabil,
    ct1_res as conta_reduzido,
    ct1_desc01 as conta_nome,
    ct2_valor as valor_original,
    (ct2_valor * -1) as valor_partida,
    ct2_hp as historico_padrao,
    ct2_hist as historico,
    'D' as tipo_partida,
    ct2_lote as Lote,
    (ct2_filial||ct2_data||ct2_lote||ct2_sblote||ct2_doc ) as Nr_lanc_contabil,
    ct2_linha as linha,
    ct2_ccd as cod_centrocusto,
    ctt.ctt_res  as red_centrocusto,
    ctt_desc01 as nome_centrocusto,  
    (case 
        when ct2.ct2_clvldb = ' 'and nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP'
        then to_char(f_projeto(ct2.ct2_xdocum))
        else ct2.ct2_clvldb
    end) as id_projeto,
    (case 
        when ct2.ct2_clvldb = ' ' and nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP'
            then (select cth.cth_desc01 from cth010 cth where CTH_FILIAL = '      ' and cth_clvl like to_char(f_projeto(ct2.ct2_xdocum))||'%' and cth.d_e_l_e_t_ <> '*')
        else cth.cth_desc01
    end) as nm_projeto, 
    (case 
        when ct2.ct2_xdocum <> ' ' and (cth_desc13 is null or cth_desc13 = ' ' )then nvl(replace ( translate(ct2.ct2_xdocum , '1234567890', ' ') , ' ', ''), 'N/A')
        when ct2.ct2_xdocum = ' ' and cth_desc13 = 'VIAGEM' then 'VIA'
        else 'N/A'
    end) as TIPO_FENIX, 
    ct2.ct2_xdocum,
    nvl(TRANSLATE(ct2.ct2_xdocum,'ABCDEFGHIJKLMNOPQRSTUVXYWZabcdefghijklmnopqrstuvxywz',' '), ' ') as cod_entidadefenix,
    nvl(cva.cva_codigo, 'XXX') as cod_origem,
    nvl(cva.cva_descri, 'Lcto Manual ou Importado integração') as desc_origem,
    sysdate as data_geracao,
    nvl(a2_cod, '      ') as codigo_fornecedor,
    nvl(a2_loja, '  ') as loja_fornecedor,
    nvl(a2_nome, '     ') as razao_fornecedor,
    nvl(ya_descr, '   ') as pais_fornecedor,
    nvl(a2_tipo, ' ') as tipo_fornecedor,
    (case 
        when ct2.ct2_xtpdes <> ' ' then ct2.ct2_xtpdes
        when ct2.ct2_xtpdes =  ' ' then ctt.ctt_xtpdes 
    end) as cd_tipo_despesa,
    (case 
        when ct2.ct2_xtpdes <> ' ' and ct2.ct2_xtpdes = '1' then 'Finalistica'
        when ct2.ct2_xtpdes <> ' ' and ct2.ct2_xtpdes = '2' then 'Administrativa' 
        when ct2.ct2_xtpdes <> ' ' and ct2.ct2_xtpdes = '3' then 'Despesa C. Pessoal' 
        when ct2.ct2_xtpdes <> ' ' and ct2.ct2_xtpdes = '4' then 'Folha de pagamento' 
        when ct2.ct2_xtpdes =  ' ' and ctt.ctt_xtpdes = '1' then 'Finalistica'
        when ct2.ct2_xtpdes =  ' ' and ctt.ctt_xtpdes = '2' then 'Administrativa' 
        when ct2.ct2_xtpdes =  ' ' and ctt.ctt_xtpdes = '3' then 'Despesa C. Pessoal'
        when ct2.ct2_xtpdes =  ' ' and ctt.ctt_xtpdes = '4' then 'Folha de pagamento'      
    end)as tipo_despesa,
    (case 
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'DT' then CT2_XDOCUM
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'RE' then f_dotacao(trim(CT2_XDOCUM))
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'EM' then f_dotacao(f_reserva(trim(CT2_XDOCUM)))
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP' then f_dotacao(f_reserva(f_empenho(CT2_XDOCUM)))
        when ct2.ct2_clvldb  not in (' ', 'null') and ct2.ct2_xdocum = ' ' and substr(ct2_data,1,4) <= '2019'
            then f_dotacao(f_reserva((select nr_empenho from VW_FNX_PROJETO_VIAGEM@fenix emp where cd_centro_custo_projeto = ctt_res and  id_projeto = to_number(trim(ct2.ct2_clvldb), '9999') and nr_ano = to_number(substr(ct2_data,1,4), '9999'))))  

        else  null
    end) as id_iniciativa_orcamentaria,
    (case
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'DT' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'RE' then CT2_XDOCUM
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'EM' then f_reserva(trim(CT2_XDOCUM))
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP' then f_reserva(f_empenho(CT2_XDOCUM))
        when ct2.ct2_clvldb  not in (' ', 'null') and ct2.ct2_xdocum = ' ' and substr(ct2_data,1,4) <= '2019'
            then f_reserva((select nr_empenho from VW_FNX_PROJETO_VIAGEM@fenix emp where cd_centro_custo_projeto = ctt_res and  id_projeto = to_number(trim(ct2.ct2_clvldb), '9999') and nr_ano = to_number(substr(ct2_data,1,4), '9999')))  
        else null
    end) as id_reserva,
    (case
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'DT' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'RE' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'EM' then CT2_XDOCUM
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP' then f_empenho(CT2_XDOCUM)
        when ct2.ct2_clvldb  not in (' ', 'null') and ct2.ct2_xdocum = ' ' and substr(ct2_data,1,4) <= '2019'
            then (select nr_empenho from VW_FNX_PROJETO_VIAGEM@fenix emp where cd_centro_custo_projeto = ctt_res and  id_projeto = to_number(trim(ct2.ct2_clvldb), '9999') and nr_ano = to_number(substr(ct2_data,1,4), '9999'))  
        else null
    end) as id_empenho,
    (case
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'DT' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'RE' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'EM' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP' then CT2_XDOCUM

        else null
    end) as id_autorizacao_pagamento,ct2_credit as cod_conta_credito --@leonel.diniz chamado:122520
from
    ct2010 ct2
        inner join ct1010 ct1 on
            ct1_conta = ct2_debito
            and ct1.d_e_l_e_t_ <> '*'
        inner join sys_company fil on
            m0_codfil = ct2_filial
            and fil.d_e_l_e_t_ <> '*'
        left join cva010 cva on
            ct2_lp = cva_codigo
            and ct2_filial = cva_filial
            and cva.d_e_l_e_t_ <> '*'
        left join ctt010 ctt on 
            ct2_ccd = ctt_custo
            and ctt.d_e_l_e_t_ <> '*'
        left join cth010 cth on
            ct2_clvldb = cth_clvl
            and cth.d_e_l_e_t_ <> '*'        
        left join sa2010 sa2 on
            substr(ct2_itemd,2,6)  = a2_cod
            and substr(ct2_itemd,8,2) = a2_loja
            and sa2.d_e_l_e_t_ <> '*'
        left join sya010 sya on
            a2_pais = ya_codgi
            and sya.d_e_l_e_t_ <> '*'            
where
    ct2.d_e_l_e_t_ <> '*'
    and ct2.ct2_dc = '1'
    --  and ct2_data > '20181031'
    and ct2_data >= '20200101' -- Chamado 110843
    and ct2_moedlc = '01' --real
    and ct2_tpsald = '1'

union all 


select
    ct2_filial as cod_filial,
    m0_filial as nome_filial,
    m0_fax_po as pais,
    to_date(ct2_data,'yyyymmdd') as data_lancto,
    substr(ct2_data,5,2) as Mes,
    substr(ct2_data,1,4) as Ano, 
    ct2_credit as cod_contacontabil,
    ct1_res as conta_reduzido,
    ct1_desc01 as conta_nome,
    ct2_valor as valor_original,
    ct2_valor as valor_partida,
    ct2_hp as historico_padrao,
    ct2_hist as historico,
    'C' as tipo_partida,
    ct2_lote as Lote,
    (ct2_filial||ct2_data||ct2_lote||ct2_sblote||ct2_doc ) as Nr_lanc_contabil,  
    ct2_linha as linha,
    ct2_ccc as cod_centrocusto,
    ctt.ctt_res  as red_centrocusto,
    ctt_desc01 as nome_centrocusto,
    (case 
        when ct2.ct2_clvlcr = ' ' and nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP'
        then to_char(f_projeto(ct2.ct2_xdocum))
        else ct2.ct2_clvlcr
    end) as id_projeto,
    (case 
        when ct2.ct2_clvlcr = ' ' and nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP'
            then (select cth.cth_desc01 from cth010 cth where CTH_FILIAL = '      ' and cth_clvl like to_char(f_projeto(ct2.ct2_xdocum))||'%' and cth.d_e_l_e_t_ <> '*')
        else cth.cth_desc01
    end) as nm_projeto,     
    (case 
        when ct2.ct2_xdocum <> ' ' and (cth_desc13 is null or cth_desc13 = ' ' )then nvl(replace ( translate(ct2.ct2_xdocum , '1234567890', ' ') , ' ', ''), 'N/A')
        when ct2.ct2_xdocum = ' ' and cth_desc13 = 'VIAGEM' then 'VIA'
        else 'N/A'
    end) as TIPO_FENIX, 
    ct2.ct2_xdocum,
    nvl(TRANSLATE(ct2.ct2_xdocum,'ABCDEFGHIJKLMNOPQRSTUVXYWZabcdefghijklmnopqrstuvxywz',' '), ' ') as cod_entidadefenix,
    nvl(cva.cva_codigo, 'XXX') as cod_origem,
    nvl(cva.cva_descri, 'Lcto Manual ou Importado integração') as desc_origem,
    sysdate as data_geracao,
    nvl(a2_cod, '      ') as codigo_fornecedor,
    nvl(a2_loja, '  ') as loja_fornecedor,
    nvl(a2_nome, '     ') as razao_fornecedor,
    nvl(ya_descr, '   ') as pais_fornecedor,
    nvl(a2_tipo, ' ') as tipo_fornecedor,
    (case 
        when ct2.ct2_xtpdes <> ' ' then ct2.ct2_xtpdes
        when ct2.ct2_xtpdes =  ' ' then ctt.ctt_xtpdes 
    end) as cd_tipo_despesa,
    (case 
        when ct2.ct2_xtpdes <> ' ' and ct2.ct2_xtpdes = '1' then 'Finalistica'
        when ct2.ct2_xtpdes <> ' ' and ct2.ct2_xtpdes = '2' then 'Administrativa' 
        when ct2.ct2_xtpdes <> ' ' and ct2.ct2_xtpdes = '3' then 'Despesa C. Pessoal' 
        when ct2.ct2_xtpdes <> ' ' and ct2.ct2_xtpdes = '4' then 'Folha de pagamento' 
        when ct2.ct2_xtpdes =  ' ' and ctt.ctt_xtpdes = '1' then 'Finalistica'
        when ct2.ct2_xtpdes =  ' ' and ctt.ctt_xtpdes = '2' then 'Administrativa' 
        when ct2.ct2_xtpdes =  ' ' and ctt.ctt_xtpdes = '3' then 'Despesa C. Pessoal'
        when ct2.ct2_xtpdes =  ' ' and ctt.ctt_xtpdes = '4' then 'Folha de pagamento'    
    end)as tipo_despesa,
    (case 
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'DT' then CT2_XDOCUM
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'RE' then f_dotacao(trim(CT2_XDOCUM))
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'EM' then f_dotacao(f_reserva(trim(CT2_XDOCUM)))
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP' then f_dotacao(f_reserva(f_empenho(CT2_XDOCUM)))
        when ct2.ct2_clvldb  not in (' ', 'null') and ct2.ct2_xdocum = ' ' and substr(ct2_data,1,4) <= '2019'
            then f_dotacao(f_reserva((select nr_empenho from VW_FNX_PROJETO_VIAGEM@fenix emp where cd_centro_custo_projeto = ctt_res and  id_projeto = to_number(trim(ct2.ct2_clvlcr), '9999') and nr_ano = to_number(substr(ct2_data,1,4), '9999'))))
        else  null
    end) as id_iniciativa_orcamentaria,
    (case
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'DT' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'RE' then CT2_XDOCUM
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'EM' then f_reserva(trim(CT2_XDOCUM))
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP' then f_reserva(f_empenho(CT2_XDOCUM))
        when ct2.ct2_clvldb  not in (' ', 'null') and ct2.ct2_xdocum = ' ' and substr(ct2_data,1,4) <= '2019'
            then f_reserva((select nr_empenho from VW_FNX_PROJETO_VIAGEM@fenix emp where cd_centro_custo_projeto = ctt_res and  id_projeto = to_number(trim(ct2.ct2_clvlcr), '9999') and nr_ano = to_number(substr(ct2_data,1,4), '9999')))     
        else null
    end) as id_reserva,
    (case
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'DT' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'RE' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'EM' then CT2_XDOCUM
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP' then f_empenho(CT2_XDOCUM)
        when ct2.ct2_clvldb  not in (' ', 'null') and ct2.ct2_xdocum = ' ' and substr(ct2_data,1,4) <= '2019'
            then (select nr_empenho from VW_FNX_PROJETO_VIAGEM@fenix emp where cd_centro_custo_projeto = ctt_res and  id_projeto = to_number(trim(ct2.ct2_clvlcr), '9999') and nr_ano = to_number(substr(ct2_data,1,4), '9999'))    
        else null
    end) as id_empenho,
    (case
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'DT' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'RE' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'EM' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP' then CT2_XDOCUM
        else null
    end) as id_autorizacao_pagamento,ct2_credit as cod_conta_credito --@leonel.diniz chamado:122520      
from
    ct2010 ct2
        inner join ct1010 ct1 on
            ct2_credit = ct1_conta
            and ct1.d_e_l_e_t_ <> '*'
        inner join sys_company fil on
            m0_codfil = ct2_filial
            and fil.d_e_l_e_t_ <> '*'
        left join cva010 cva on
            ct2_lp = cva_codigo
            and ct2_filial = cva_filial
            and cva.d_e_l_e_t_ <> '*'
        left join ctt010 ctt on 
            ct2_ccc = ctt_custo
            and ctt.d_e_l_e_t_ <> '*'
        left join cth010 cth on
            ct2_clvlcr = cth_clvl
            and cth.d_e_l_e_t_ <> '*'
        left join sa2010 sa2 on
            substr(ct2_itemc,2,6)  = a2_cod
            and substr(ct2_itemc,8,2) = a2_loja
            and sa2.d_e_l_e_t_ <> '*'  
        left join sya010 sya on
            a2_pais = ya_codgi
            and sya.d_e_l_e_t_ <> '*'            
where
    ct2.d_e_l_e_t_ <> '*'
    and ct2.ct2_dc = '2'
--    and ct2_data > '20181031'
    and ct2_data >= '20200101' -- Chamado 110843
    and ct2_moedlc = '01' --real
    and ct2_tpsald = '1'

union all 


select
    ct2_filial as cod_filial,
    m0_filial as nome_filial,
    m0_fax_po as pais,
    to_date(ct2_data,'yyyymmdd') as data_lancto,
    substr(ct2_data,5,2) as Mes,
    substr(ct2_data,1,4) as Ano,     
    ct2_credit as cod_contacontabil,
    ct1_res as conta_reduzido,
    ct1_desc01 as conta_nome,
    ct2_valor as valor_original,
    ct2_valor as valor_partida,
    ct2_hp as historico_padrao,
    ct2_hist as historico,
    'C' as tipo_partida,
    ct2_lote as Lote,
    (ct2_filial||ct2_data||ct2_lote||ct2_sblote||ct2_doc ) as Nr_lanc_contabil,  
    ct2_linha as linha,
    ct2_ccc as cod_centrocusto,
    ctt.ctt_res  as red_centrocusto,
    ctt_desc01 as nome_centrocusto,
    (case 
        when ct2.ct2_clvlcr = ' ' and nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP'
        then to_char(f_projeto(ct2.ct2_xdocum))
        else ct2.ct2_clvlcr
    end) as id_projeto,
    (case 
        when ct2.ct2_clvlcr = ' ' and nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP'
            then (select cth.cth_desc01 from cth010 cth where CTH_FILIAL = '      ' and cth_clvl like to_char(f_projeto(ct2.ct2_xdocum))||'%' and cth.d_e_l_e_t_ <> '*')
        else cth.cth_desc01
    end) as nm_projeto, 
    (case 
        when ct2.ct2_xdocum <> ' ' and (cth_desc13 is null or cth_desc13 = ' ' )then nvl(replace ( translate(ct2.ct2_xdocum , '1234567890', ' ') , ' ', ''), 'N/A')
        when ct2.ct2_xdocum = ' ' and cth_desc13 = 'VIAGEM' then 'VIA'
        else 'N/A'
    end) as TIPO_FENIX,  
    ct2.ct2_xdocum,
    nvl(TRANSLATE(ct2.ct2_xdocum,'ABCDEFGHIJKLMNOPQRSTUVXYWZabcdefghijklmnopqrstuvxywz',' '), ' ') as cod_entidadefenix,
    nvl(cva.cva_codigo, 'XXX') as cod_origem,
    nvl(cva.cva_descri, 'Lcto Manual ou Importado integração') as desc_origem,
    sysdate as data_geracao,
    nvl(a2_cod, '      ') as codigo_fornecedor,
    nvl(a2_loja, '  ') as loja_fornecedor,
    nvl(a2_nome, '     ') as razao_fornecedor,
    nvl(ya_descr, '   ') as pais_fornecedor,
    nvl(a2_tipo, ' ') as tipo_fornecedor,
    (case 
        when ct2.ct2_xtpdes <> ' ' then ct2.ct2_xtpdes
        when ct2.ct2_xtpdes =  ' ' then ctt.ctt_xtpdes 
    end) as cd_tipo_despesa,
    (case 
        when ct2.ct2_xtpdes <> ' ' and ct2.ct2_xtpdes = '1' then 'Finalistica'
        when ct2.ct2_xtpdes <> ' ' and ct2.ct2_xtpdes = '2' then 'Administrativa' 
        when ct2.ct2_xtpdes <> ' ' and ct2.ct2_xtpdes = '3' then 'Despesa C. Pessoal' 
        when ct2.ct2_xtpdes <> ' ' and ct2.ct2_xtpdes = '4' then 'Folha de pagamento'
        when ct2.ct2_xtpdes =  ' ' and ctt.ctt_xtpdes = '1' then 'Finalistica'
        when ct2.ct2_xtpdes =  ' ' and ctt.ctt_xtpdes = '2' then 'Administrativa' 
        when ct2.ct2_xtpdes =  ' ' and ctt.ctt_xtpdes = '3' then 'Despesa C. Pessoal'
        when ct2.ct2_xtpdes =  ' ' and ctt.ctt_xtpdes = '4' then 'Folha de pagamento'    
    end)as tipo_despesa,
    (case 
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'DT' then CT2_XDOCUM
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'RE' then f_dotacao(trim(CT2_XDOCUM))
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'EM' then f_dotacao(f_reserva(trim(CT2_XDOCUM)))
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP' then f_dotacao(f_reserva(f_empenho(CT2_XDOCUM)))
        when ct2.ct2_clvldb  not in (' ', 'null') and ct2.ct2_xdocum = ' ' and substr(ct2_data,1,4) <= '2019'
            then f_dotacao(f_reserva((select nr_empenho from VW_FNX_PROJETO_VIAGEM@fenix emp where cd_centro_custo_projeto = ctt_res and  id_projeto = to_number(trim(ct2.ct2_clvlcr), '9999') and nr_ano = to_number(substr(ct2_data,1,4), '9999'))))

        else  null
    end) as id_iniciativa_orcamentaria,
    (case
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'DT' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'RE' then CT2_XDOCUM
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'EM' then f_reserva(trim(CT2_XDOCUM))
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP' then f_reserva(f_empenho(CT2_XDOCUM))
        when ct2.ct2_clvldb  not in (' ', 'null') and ct2.ct2_xdocum = ' ' and substr(ct2_data,1,4) <= '2019'
            then f_reserva((select nr_empenho from VW_FNX_PROJETO_VIAGEM@fenix emp where cd_centro_custo_projeto = ctt_res and  id_projeto = to_number(trim(ct2.ct2_clvlcr), '9999') and nr_ano = to_number(substr(ct2_data,1,4), '9999')))

        else null
    end) as id_reserva,
    (case
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'DT' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'RE' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'EM' then CT2_XDOCUM
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP' then f_empenho(CT2_XDOCUM)
        when ct2.ct2_clvldb  not in (' ', 'null') and ct2.ct2_xdocum = ' ' and substr(ct2_data,1,4) <= '2019'
            then (select nr_empenho from VW_FNX_PROJETO_VIAGEM@fenix emp where cd_centro_custo_projeto = ctt_res and  id_projeto = to_number(trim(ct2.ct2_clvlcr), '9999') and nr_ano = to_number(substr(ct2_data,1,4), '9999'))  
        else null
    end) as id_empenho,
    (case
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'DT' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'RE' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'EM' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP' then CT2_XDOCUM
        else null
    end) as id_autorizacao_pagamento,ct2_credit as cod_conta_credito --@leonel.diniz chamado:122520   
from
    ct2010 ct2
        inner join ct1010 ct1 on
            ct2_credit = ct1_conta
            and ct1.d_e_l_e_t_ <> '*'
        inner join sys_company fil on
            m0_codfil = ct2_filial
            and fil.d_e_l_e_t_ <> '*'
        left join cva010 cva on
            ct2_lp = cva_codigo
            and ct2_filial = cva_filial
            and cva.d_e_l_e_t_ <> '*'
        left join ctt010 ctt on 
            ct2_ccc = ctt_custo
            and ctt.d_e_l_e_t_ <> '*'
        left join cth010 cth on
            ct2_clvlcr = cth_clvl
            and cth.d_e_l_e_t_ <> '*'
        left join sa2010 sa2 on
            substr(ct2_itemc,2,6)  = a2_cod
            and substr(ct2_itemc,8,2) = a2_loja
            and sa2.d_e_l_e_t_ <> '*'     
        left join sya010 sya on
            a2_pais = ya_codgi
            and sya.d_e_l_e_t_ <> '*'
where
    ct2.d_e_l_e_t_ <> '*'
    and ct2.ct2_dc = '3'
    --and ct2_data > '20181031'
    and ct2_data >= '20200101'
    and ct2_moedlc = '01' --real
    and ct2_tpsald = '1'

union all 

select
    ct2_filial as cod_filial,
    m0_filial as nome_filial,
    m0_fax_po as pais,
    to_date(ct2_data,'yyyymmdd') as data_lancto,
    substr(ct2_data,5,2) as Mes,
    substr(ct2_data,1,4) as Ano,     
    ct2_debito as cod_contacontabil,
    ct1_res as conta_reduzido,
    ct1_desc01 as conta_nome,
    ct2_valor as valor_original,
    (ct2_valor * -1) as valor_partida,
    ct2_hp as historico_padrao, 
    ct2_hist as historico,
    'D' as tipo_partida,
    ct2_lote as Lote,
    (ct2_filial||ct2_data||ct2_lote||ct2_sblote||ct2_doc ) as Nr_lanc_contabil,
    ct2.ct2_linha as linha,
    ct2_ccd as cod_centrocusto,
    ctt.ctt_res  as red_centrocusto,
    ctt_desc01 as nome_centrocusto,
    (case 
        when ct2.ct2_clvldb = ' 'and nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP'
        then to_char(f_projeto(ct2.ct2_xdocum))
        else ct2.ct2_clvldb
    end) as id_projeto,
    (case 
        when ct2.ct2_clvldb = ' ' and nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP'
            then (select cth.cth_desc01 from cth010 cth where CTH_FILIAL = '      ' and cth_clvl like to_char(f_projeto(ct2.ct2_xdocum))||'%' and cth.d_e_l_e_t_ <> '*')
        else cth.cth_desc01
    end) as nm_projeto, 
    (case 
        when ct2.ct2_xdocum <> ' ' and (cth_desc13 is null or cth_desc13 = ' ' )then nvl(replace ( translate(ct2.ct2_xdocum , '1234567890', ' ') , ' ', ''), 'N/A')
        when ct2.ct2_xdocum = ' ' and cth_desc13 = 'VIAGEM' then 'VIA'
        else 'N/A'
    end) as TIPO_FENIX,  
    ct2.ct2_xdocum,
    nvl(TRANSLATE(ct2.ct2_xdocum,'ABCDEFGHIJKLMNOPQRSTUVXYWZabcdefghijklmnopqrstuvxywz',' '), ' ') as cod_entidadefenix,
    nvl(cva.cva_codigo, 'XXX') as cod_origem,
    nvl(cva.cva_descri, 'Lcto Manual ou Importado integração') as desc_origem,
    sysdate as data_geracao,
    nvl(a2_cod, '      ') as codigo_fornecedor,
    nvl(a2_loja, '  ') as loja_fornecedor,
    nvl(a2_nome, '     ') as razao_fornecedor,
    nvl(ya_descr, '   ') as pais_fornecedor,
    nvl(a2_tipo, ' ') as tipo_fornecedor,
    (case 
        when ct2.ct2_xtpdes <> ' ' then ct2.ct2_xtpdes
        when ct2.ct2_xtpdes =  ' ' then ctt.ctt_xtpdes 
    end) as cd_tipo_despesa,
    (case 
        when ct2.ct2_xtpdes <> ' ' and ct2.ct2_xtpdes = '1' then 'Finalistica'
        when ct2.ct2_xtpdes <> ' ' and ct2.ct2_xtpdes = '2' then 'Administrativa' 
        when ct2.ct2_xtpdes <> ' ' and ct2.ct2_xtpdes = '3' then 'Despesa C. Pessoal' 
        when ct2.ct2_xtpdes <> ' ' and ct2.ct2_xtpdes = '4' then 'Folha de pagamento'
        when ct2.ct2_xtpdes =  ' ' and ctt.ctt_xtpdes = '1' then 'Finalistica'
        when ct2.ct2_xtpdes =  ' ' and ctt.ctt_xtpdes = '2' then 'Administrativa' 
        when ct2.ct2_xtpdes =  ' ' and ctt.ctt_xtpdes = '3' then 'Despesa C. Pessoal'
        when ct2.ct2_xtpdes =  ' ' and ctt.ctt_xtpdes = '4' then 'Folha de pagamento'   

    end)as tipo_despesa,
    (case 
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'DT' then CT2_XDOCUM
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'RE' then f_dotacao(trim(CT2_XDOCUM))
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'EM' then f_dotacao(f_reserva(trim(CT2_XDOCUM)))
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP' then f_dotacao(f_reserva(f_empenho(CT2_XDOCUM)))
        when ct2.ct2_clvldb  not in (' ', 'null') and ct2.ct2_xdocum = ' ' and substr(ct2_data,1,4) <= '2019'
            then f_dotacao(f_reserva((select nr_empenho from VW_FNX_PROJETO_VIAGEM@fenix emp where cd_centro_custo_projeto = ctt_res and  id_projeto = to_number(trim(ct2.ct2_clvldb), '9999') and nr_ano = to_number(substr(ct2_data,1,4), '9999'))))  
        else  null
    end) as id_iniciativa_orcamentaria,
    (case
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'DT' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'RE' then CT2_XDOCUM
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'EM' then f_reserva(trim(CT2_XDOCUM))
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP' then f_reserva(f_empenho(CT2_XDOCUM))
        when ct2.ct2_clvldb  not in (' ', 'null') and ct2.ct2_xdocum = ' ' and substr(ct2_data,1,4) <= '2019'
            then f_reserva((select nr_empenho from VW_FNX_PROJETO_VIAGEM@fenix emp where cd_centro_custo_projeto = ctt_res and  id_projeto = to_number(trim(ct2.ct2_clvldb), '9999') and nr_ano = to_number(substr(ct2_data,1,4), '9999')))  

        else null
    end) as id_reserva,
    (case
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'DT' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'RE' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'EM' then CT2_XDOCUM
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP' then f_empenho(CT2_XDOCUM)
        when ct2.ct2_clvldb  not in (' ', 'null') and ct2.ct2_xdocum = ' ' and substr(ct2_data,1,4) <= '2019'
            then (select nr_empenho from VW_FNX_PROJETO_VIAGEM@fenix emp where cd_centro_custo_projeto = ctt_res and  id_projeto = to_number(trim(ct2.ct2_clvldb), '9999') and nr_ano = to_number(substr(ct2_data,1,4), '9999'))  

        else null
    end) as id_empenho,
    (case
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'DT' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'RE' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'EM' then null
        when nvl(replace ( translate( ct2.ct2_xdocum, '1234567890', ' ') , ' ', ''), 'N/A') = 'AP' then CT2_XDOCUM
        else null
    end) as id_autorizacao_pagamento,ct2_credit as cod_conta_credito --@leonel.diniz chamado:122520  
from
    ct2010 ct2
        inner join ct1010 ct1 on
            ct1_conta = ct2_debito
            and ct1.d_e_l_e_t_ <> '*'
        inner join sys_company fil on
            m0_codfil = ct2_filial
            and fil.d_e_l_e_t_ <> '*'
        left join cva010 cva on
            ct2_lp = cva_codigo
            and ct2_filial = cva_filial
            and cva.d_e_l_e_t_ <> '*'
        left join ctt010 ctt on 
            ct2_ccd = ctt_custo
            and ctt.d_e_l_e_t_ <> '*'
        left join cth010 cth on
            ct2_clvldb = cth_clvl
            and cth.d_e_l_e_t_ <> '*'          
        left join sa2010 sa2 on
            substr(ct2_itemd,2,6)  = a2_cod
            and substr(ct2_itemd,8,2) = a2_loja
            and sa2.d_e_l_e_t_ <> '*'
        left join sya010 sya on
            a2_pais = ya_codgi
            and sya.d_e_l_e_t_ <> '*'
where
    ct2.d_e_l_e_t_ <> '*'
    and ct2.ct2_dc = '3'
    --and ct2_data > '20181031'
    and ct2_data >= '20200101' -- Chamado 110843
    and ct2_moedlc = '01' --real
    and ct2_tpsald = '1'
    