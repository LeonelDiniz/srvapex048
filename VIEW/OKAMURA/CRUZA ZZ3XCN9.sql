SELECT
    ZZ3_CODIGO, ZZ3_CONTRA,ZZ3_PROJET 
FROM
    ZZ3010 ZZ3,
    VW_PCO_PROJETO VWP,
    VW_PCO_EMPENHO VWE
WHERE
    ZZ3.D_E_L_E_T_ = ' '
    AND VWP.ID_PROJETO=ZZ3_PROJET
    AND VWE.ID_EMPENHO=ZZ3.ZZ3_EMPENH
    AND ZZ3_CODIGO NOT IN 

(SELECT
    ZZ3_CODIGO AP
    
    
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
    
--ORDER BY NM_PROJETO--@leonel.diniz Chamado:129507    
)
    
    
    

    
    
  
