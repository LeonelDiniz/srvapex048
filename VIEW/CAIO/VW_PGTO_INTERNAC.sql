/*
Autor: @leonel.diniz
Data: 29/05/2021
Descrição: Atendimento ao chamado 128382 requerido por Caio Rabelo De Paula Zanello
Nome VW: VW_PGTO_INTERNAC
*/
CREATE VIEW VW_PGTO_INTERNAC AS

select trim(a2_nome) as Razao_Social, a2_nreduz as Fornecedor, d1_cc as Centro_Custo, 
d1_clvl as Classe_Valor, d1_serie as Serie, zz3_xvlror as Vlr_Orig,
zz3_xmoeda as Moeda, 
CASE
    WHEN zz3_xmoeda = 1 THEN 'REAL'
    WHEN zz3_xmoeda = 2 THEN 'DOLAR'
    WHEN zz3_xmoeda = 3 THEN 'UFIR'
    WHEN zz3_xmoeda = 4 THEN 'EURO'
    WHEN zz3_xmoeda = 5 THEN 'IENE'
    WHEN zz3_xmoeda = 6 THEN 'DIRHAM'
    WHEN zz3_xmoeda = 7 THEN 'RUBRO'
    WHEN zz3_xmoeda = 8 THEN 'KWANZA'
    WHEN zz3_xmoeda = 9 THEN 'RENMINBI'
    WHEN zz3_xmoeda = 10 THEN 'PESO COLOMBIANO'
    WHEN zz3_xmoeda = 11 THEN 'PESO CUBA'
    WHEN zz3_xmoeda = 12 THEN 'FRANCO SUICO'
    WHEN zz3_xmoeda = 13 THEN 'LIBRA'
    WHEN zz3_xmoeda = 14 THEN 'SHEKEL'
    WHEN zz3_xmoeda = 15 THEN 'DOLAR BC'
    ELSE 'NULL'
END as Desc_Moeda,    
zz3_xvlrco as Vlr_Total, f1_xnumap as Numero_AP,
zz3_dtaupg as Dt_Vencto_AP,zz3_dtpgto as Dt_PGTO_AP, trim(zz3_descpg) as Desc_PGTO, e2_naturez as Natureza, ed_descric as Desc_Natureza
from sa2010
    join zz3010 on a2_cod = zz3_fornec
    join sf1010 on f1_doc = zz3_nota
    join sd1010 on d1_doc = zz3_nota    
    join se2010 on e2_num = zz3_nota
    join sed010 on ed_codigo = e2_naturez
    AND SF1010.D_E_L_E_T_ = ' '
    AND SD1010.D_E_L_E_T_ = ' '
    AND SE2010.D_E_L_E_T_ = ' '
    AND ZZ3010.D_E_L_E_T_ = ' '
order by zz3_dtaupg

