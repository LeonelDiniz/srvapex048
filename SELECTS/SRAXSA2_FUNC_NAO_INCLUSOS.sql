SELECT RA_FILIAL, RA_MAT, RA_NOME, RA_EMAIL 
FROM SRA010 RA
WHERE NOT EXISTS (SELECT * 
                FROM SA2010 A2
                WHERE A2.A2_EMAIL = RA_EMAIL
                AND A2.D_E_L_E_T_ = ' '
              )  
AND RA.D_E_L_E_T_ = ' '              
ORDER BY R_E_C_N_O_ DESC              

