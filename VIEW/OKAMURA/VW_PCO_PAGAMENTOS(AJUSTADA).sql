SELECT distinct
    ZZ3_PROJET ID_PROJETO,
    VWP.NM_PROJETO,
    ZZ3_ACAO ID_ACAO,
    (SELECT ZZA.ZZA_DESCRI FROM ZZA010 ZZA WHERE ZZA.D_E_L_E_T_ = ' ' AND ZZ3.ZZ3_FILIAL=ZZA.ZZA_FILIAL AND ZZ3.ZZ3_ACAO=ZZA_CODIGO) AS NM_ACAO,
    ZZ3_FORNEC FORNECEDOR,
    ZZ3_LOJA LOJA,
    (SELECT SA2.A2_NOME FROM SA2010 SA2 WHERE SA2.D_E_L_E_T_ = ' ' AND ZZ3.ZZ3_FILIAL=SA2.A2_FILIAL AND ZZ3.ZZ3_FORNEC=A2_COD AND ZZ3.ZZ3_LOJA=SA2.A2_LOJA) AS NM_FORNECEDOR,
    ZZ3_CONTRA CD_CONTRATO,
    ZZ3_COMPET COMPETENCIA,
    ZZ3_EMPENH ID_EMPENHO,
    VWE.DS_EMPENHO,
    VWE.VL_EMPENHO,
    ZZ3_TPPGTO AS CD_TIPO_PAGAMENTO,
    F_COMBO('ZZ3_TPPGTO',ZZ3_TPPGTO) AS DS_TIPO_PAGAMENTO,
    ZZ3_BANCO BANCO,
    ZZ3_AGENCI AGENCIA,
    ZZ3_CONTA CONTA,
    ZZ3_CIBAN IBAN,
    ZZ3_SWIFT SWIFT,
    ZZ3_OSAPEX OSAPEX,
    ZZ3_CODIGO AP,
    SUBSTR(ZZ3_DATA,-2)||'/'||SUBSTR(ZZ3_DATA,5,2)||'/'||SUBSTR(ZZ3_DATA,1,4) AS DT_LANCAMENTO,
    ZZ3_XMOEDA CD_MOEDA,
    (SELECT RTRIM(X6_CONTEUD) FROM SX6010 SX6 WHERE X6_VAR = 'MV_MOEDA'||RPAD(ZZ3_XMOEDA,2,' ') AND SX6.D_E_L_E_T_ = ' ') AS DS_MOEDA,
    SUBSTR(ZZ3_EMISSA,-2)||'/'||SUBSTR(ZZ3_EMISSA,5,2)||'/'||SUBSTR(ZZ3_EMISSA,1,4) DT_EMISSAO,
    SUBSTR(ZZ3_DTPGTO,-2)||'/'||SUBSTR(ZZ3_DTPGTO,5,2)||'/'||SUBSTR(ZZ3_DTPGTO,1,4) AS  DT_PAGAMENTO ,
    ZZ3_NOTA as NU_NF,
    (SELECT SUBSTR(E2_BAIXA,-2)||'/'||SUBSTR(E2_BAIXA,5,2)||'/'||SUBSTR(E2_BAIXA,1,4) FROM SE2010 SE2 WHERE SE2.D_E_L_E_T_ = ' ' AND E2_XNUMAP = ZZ3_CODIGO AND E2_TIPO = 'NF' AND E2_PARCELA = '   ' AND E2_SALDO = 0) AS  DT_AUTORIZACAO,
    --SUBSTR(ZZ3_DTAUPG,-2)||'/'||SUBSTR(ZZ3_DTAUPG,5,2)||'/'||SUBSTR(ZZ3_DTAUPG,1,4) AS  DT_AUTORIZACAO,
    dbms_lob.substr(blob_to_clob(zz3_obs),4000,1) as DS_OBSERVACAO,
    CASE
        WHEN ZZ3_XTXCON = 0 THEN 1
        ELSE ZZ3_XTXCON
    END as tx_conversao,
    ZZ3_XVLROR vl_total_moeda_original,
    --zz3_XVLROR*ZZ3_XTXCON as vl_convertido,
    CASE
        WHEN ZZ3_XMOEDA = 1 THEN zz3_XVLROR*ZZ3_XTXCON
        ELSE (SELECT SUM(E2_VALOR) FROM SE2010 SE2 WHERE SE2.D_E_L_E_T_ = ' ' AND E2_XNUMAP = ZZ3_CODIGO AND E2_TIPO = 'NF' AND E2_PARCELA = '   ' )
    END  as vl_convertido,
    --zz3.zz3_xvlire as vl_imposto_remessa,
    CASE
        WHEN ZZ3_XMOEDA = 1 THEN zz3.zz3_xvlire
        ELSE (SELECT SUM(E2_VALOR) FROM SE2010 SE2 WHERE SE2.D_E_L_E_T_ = ' ' AND E2_XNUMAP = ZZ3_CODIGO AND E2_TIPO = 'TX' AND E2_NATUREZ <> '20407010' )
    END as vl_imposto_remessa,
    ZZ3_XREDIM as fl_reducao_imposto,
    zz3_xvltre as vl_taxa_remessa,
    ZZ3_XCIDE as fl_cide,
    --ZZ3_XVLCID as vl_cide,
    CASE
        WHEN ZZ3_XMOEDA = 1 THEN ZZ3_XVLCID
        ELSE (SELECT SUM(E2_VALOR) FROM SE2010 SE2 WHERE SE2.D_E_L_E_T_ = ' ' AND E2_XNUMAP = ZZ3_CODIGO AND E2_TIPO = 'TX' AND E2_NATUREZ = '20407010' )
    END as vl_cide,
    --ZZ3_XVALOR as vl_total_nf,
    CASE
        WHEN ZZ3_XMOEDA = 1 THEN ZZ3_XVALOR
        ELSE (SELECT SUM(E2_VALOR) FROM SE2010 SE2 WHERE SE2.D_E_L_E_T_ = ' ' AND E2_XNUMAP = ZZ3_CODIGO )
    END as vl_total_nf,
    ZZ3_USINC as ds_login_ins_nota,
    ZZ3_DESCPG as ds_pagto,
    ZZ3_STATUS AS cd_status_pagamento,
    /*
       -- F_COMBO('ZZ3_STATUS',ZZ3_STATUS) AS DS_status_PAGAMENTO,
       Realizado alteração na VIEW pelo chamado 120647
       Criado uma nova função para antender especificamente essa view e a tabela ZZ3 campo ZZ3_STATUS
       Luciano Silva de Souza - TOTVS
       16/11/2020
    */
    F_COMBO_SX5('Z3',ZZ3_STATUS) AS DS_status_PAGAMENTO,
    cn9_xtpmdl as "Tp. Md Lici",--@leonel.diniz Chamado:129507
    (SELECT  ZZM_DESCRI FROM ZZM010 WHERE CN9.CN9_XTPMDL = ZZM_CODIGO AND ZZM010.D_E_L_E_T_ = ' ' AND CN9.D_E_L_E_T_ = ' ') AS "Modal. Lict"--@leonel.diniz Chamado:129507   
    
FROM
    ZZ3010 ZZ3
    JOIN VW_PCO_PROJETO VWP--@leonel.diniz Chamado:129507  
        ON VWP.ID_PROJETO=ZZ3_PROJET--@leonel.diniz Chamado:129507  
       
    JOIN VW_PCO_EMPENHO VWE--@leonel.diniz Chamado:129507  
        ON VWE.ID_EMPENHO=ZZ3.ZZ3_EMPENH--@leonel.diniz Chamado:129507  
    
    INNER JOIN CN9010 CN9--@leonel.diniz Chamado:129507
       ON CN9.CN9_NUMERO = SUBSTR(ZZ3.ZZ3_CONTRA, 0,15)--@leonel.diniz Chamado:129507
       AND SUBSTR(ZZ3_CONTRA, 16,3) = cn9_revisa--@leonel.diniz Chamado:129507-->NÃO REMOVER ESTA LINHA   
       OR cn9_revisa is null--@leonel.diniz Chamado:129507-->NÃO REMOVER ESTA LINHA NULL É DIFERENTE DE '   ' NA REVISAO
       AND  CN9.D_E_L_E_T_ = ' '--@leonel.diniz Chamado:129507   

WHERE
    ZZ3.D_E_L_E_T_ = ' '
    AND CN9.D_E_L_E_T_ = ' '
    
ORDER BY NM_PROJETO--@leonel.diniz Chamado:129507    
    