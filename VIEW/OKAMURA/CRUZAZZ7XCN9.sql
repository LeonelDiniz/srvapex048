SELECT
--
    ZZ7_FILIAL AS "FILIAL DO SISTEMA",
    ZZ7_NUMERO AS "NUMERO OS",
    ZZ7_OSAPEX AS "NUMERO OS APEX",
    ZZ7_EMPENH AS "EMPENHO"
FROM
    ZZ7010 ZZ7
    INNER JOIN ZZL010 ZZL
        ON ZZL_NUMERO = ZZ7_NUMERO
        AND ZZL.D_E_L_E_T_ = ' '
    INNER JOIN SA2010 SA2
        ON A2_COD = ZZ7_FORNEC
        AND A2_LOJA = ZZ7_LOJA
        AND SA2.D_E_L_E_T_ = ' '
WHERE
    ZZ7.D_E_L_E_T_ = ' '
    and ZZ7.ZZ7_CONTRA NOT IN (
    
    SELECT ZZ7.ZZ7_CONTRA
FROM 
    ZZ7010 ZZ7
 
    INNER JOIN ZZL010 ZZL
        ON ZZL_NUMERO = ZZ7_NUMERO
        AND ZZL.D_E_L_E_T_ = ' '

    INNER JOIN SA2010 SA2
        ON A2_COD = ZZ7_FORNEC
        AND A2_LOJA = ZZ7_LOJA
        AND SA2.D_E_L_E_T_ = ' '
                

    INNER JOIN CN9010 CN9--@leonel.diniz Chamado:129507
       ON CN9.CN9_NUMERO = SUBSTR(ZZ7.ZZ7_CONTRA, 0,15)--@leonel.diniz Chamado:129507
       AND SUBSTR(ZZ7_CONTRA, 16,3) = cn9_revisa--@leonel.diniz Chamado:129507-->NÃO REMOVER ESTA LINHA   
       OR cn9_revisa is null--@leonel.diniz Chamado:129507-->NÃO REMOVER ESTA LINHA NULL É DIFERENTE DE '   ' NA REVISAO
       AND  CN9.D_E_L_E_T_ = ' '--@leonel.diniz Chamado:129507   

WHERE
    ZZ7.D_E_L_E_T_ = ' '
    AND CN9.D_E_L_E_T_ = ' '
    )




    
    

    
    
  
