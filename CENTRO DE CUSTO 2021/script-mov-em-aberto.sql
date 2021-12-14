update cn9010--Contratos                      
set cn9_xcc = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(cn9_xcc))
where 
    d_e_l_e_t_ = ' '
    and cn9_situac = '05'--contratos vigentes
    and trim(cn9_xcc) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');

----------------------------------------------------------------------------------------------------------------------------------------	
	
update cne010--Itens da Medição de Contratos  
set cne_cc = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(cne_cc))
where 
    d_e_l_e_t_ = ' '
    and cne_dtent like '2021%'
    and trim(cne_cc) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');
	
----------------------------------------------------------------------------------------------------------------------------------------    
    
update cnd010--Cabeçalho Medição de Contratos 
set cnd_xcc = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(cnd_xcc))
where 
    d_e_l_e_t_ = ' '
    and cnd_dtinic like '2021%'
    and cnd_situac = 'A'--medições em aberto
    and trim(cnd_xcc) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');

----------------------------------------------------------------------------------------------------------------------------------------

update sc7010--Ped.Compra / Aut.Entrega       
set c7_cc = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(c7_cc))
where 
    d_e_l_e_t_ = ' '
    and c7_emissao like '2021%'
    and C7_encer <> 'E'--pedidos em aberto
    and trim(c7_cc) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');	
	
----------------------------------------------------------------------------------------------------------------------------------------    
    
update sd1010--Itens das NF de Entrada       
set d1_cc = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(d1_cc))
where 
    d_e_l_e_t_ = ' '
    and d1_emissao like '2021%'
    and d1_tes = ' '--apenas para notas não classificadas
    and trim(d1_cc) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');

----------------------------------------------------------------------------------------------------------------------------------------

update se2010--Contas a Pagar                 
set e2_ccc = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(e2_ccc))
where 
    d_e_l_e_t_ = ' '
    and e2_emissao like '2021%'
    and e2_baixa = ' '--apenas não baixados
    and trim(e2_ccc) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');

----------------------------------------------------------------------------------------------------------------------------------------
/*
update fk2010--Baixas a Pagar          CENTROS DE CUSTO EM BRANCO  
set fk2_ccusto = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(fk2_ccusto))
where 
    d_e_l_e_t_ = ' '
    and fk2_data like '2021%'
    and trim(fk2_ccusto) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');
*/
----------------------------------------------------------------------------------------------------------------------------------------

update fk5010--Movimentos Bancários         
set fk5_ccusto = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(fk5_ccusto))
where 
    d_e_l_e_t_ = ' '
    and fk5_data like '2021%'
    and trim(fk5_ccusto) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');

----------------------------------------------------------------------------------------------------------------------------------------

update sc5010--Pedidos de Venda              
set 
   c5_xcc = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(c5_xcc))
where 
    d_e_l_e_t_ = ' '
    and c5_emissao like '2021%'
    and trim(c5_xcc) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');

----------------------------------------------------------------------------------------------------------------------------------------
	
update sc6010--Itens dos Pedidos de Venda     
set c6_cc = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(c6_cc))
where 
    d_e_l_e_t_ = ' '
    and c6_num in (select c5_num from sc5010 where d_e_l_e_t_ = ' ' and c5_emissao like '2021%' )
    and trim(c6_cc) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');	

----------------------------------------------------------------------------------------------------------------------------------------	
/*	
update sd2010--Itens de Venda da NF    ***TODOS OS REGISTROS ESTÃO CLASSIFICADOS       
set d2_ccusto = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(d2_ccusto))
where 
    d_e_l_e_t_ = ' '
    and d2_emissao like '2021%'
    and d2_tes = ' '--apenas para notas não classificadas
    and trim(d2_ccusto) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');	
*/
----------------------------------------------------------------------------------------------------------------------------------------
	
update se1010--Contas a receber   
set e1_ccd = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(e1_ccd))
where 
    d_e_l_e_t_ = ' '
    and e1_emissao like '2021%'
    and e1_baixa = ' '--apenas para não baixados
    and trim(e1_ccd) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');	

----------------------------------------------------------------------------------------------------------------------------------------
	
update seu010--Movimentos do Caixinha        
set eu_ccd = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(eu_ccd))
where 
    d_e_l_e_t_ = ' '
    and eu_emissao like '2021%'
    and eu_baixa = ' '--apenas para não baixados
    and trim(eu_ccd) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');	

----------------------------------------------------------------------------------------------------------------------------------------
	
update sn3010--Saldos e Valores               
set 
    N3_CUSTBEM = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(N3_CUSTBEM))
where 
    d_e_l_e_t_ = ' '
    and n3_dtbaixa = ' '--apenas para bens não baixados
   
    and trim(N3_CUSTBEM) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');

----------------------------------------------------------------------------------------------------------------------------------------

update sn3010--Saldos e Valores    
set 
    N3_CCUSTO = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(N3_CCUSTO) )
where 
    d_e_l_e_t_ = ' '
    and n3_dtbaixa = ' '--apenas para bens não baixados  
    and trim(N3_CCUSTO) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');

----------------------------------------------------------------------------------------------------------------------------------------

--Conforme acordado com o Renato Almeida não será alterado as movimentações já realizadas em 2021 	
/*update sn4010--Movimentações do Ativo Fixo    
set 
    N4_CCUSTO = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(N4_CCUSTO))
where 
    d_e_l_e_t_ = ' '
   
    and trim(N4_CCUSTO) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');
*/

----------------------------------------------------------------------------------------------------------------------------------------

--Não há registros para o exercicio 2021. Ultimo Resgistro:20200618
/*
update sz8010--VIAGENS CABECALHO              
set 
    z8_cc = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(z8_cc))
where 
    d_e_l_e_t_ = ' '
   
    and trim(z8_cc) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');
*/

----------------------------------------------------------------------------------------------------------------------------------------

--Movimentações com registro de vencimento para dia 15/07/2021
/*
update szb010--CABECALHO DA FATURA            
set 
    zb_cc = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(zb_cc))
where 
    d_e_l_e_t_ = ' '
  
    AND zm_emissao = '20210101'
   
    and trim(zb_cc) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');	
    */

----------------------------------------------------------------------------------------------------------------------------------------

--Conforme acordado com o Renato Almeida não será alterado as movimentações já realizadas em 2021 	
/*
update CT2010--Lançamentos Contábeis          
set 
    ct2_ccd = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(ct2_ccd))
where 
    d_e_l_e_t_ = ' '
    and ct2_data like '2021%'
    and trim(ct2_ccd) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');

----------------------------------------------------------------------------------------------------------------------------------------

update CT2010--Lançamentos Contábeis  
set 
    ct2_ccc = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(ct2_ccc))
where 
    d_e_l_e_t_ = ' '
    and ct2_data like '2021%'
    and trim(ct2_ccc) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');
    
*/

----------------------------------------------------------------------------------------------------------------------------------------

--Conforme acordado com o Renato Almeida não será alterado as movimentações já realizadas em 2021 
/*
update CTk010--Arquivo de Contra-Prova        
set 
    ctk_ccc = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(ctk_ccc))
where 
    d_e_l_e_t_ = ' '
    and ctk_data like '2021%'
    and trim(ctk_ccc) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');
    
update CTk010--Arquivo de Contra-Prova        
set 
    ctk_ccd = (select CODCC_PROTHEUS_PARA from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE = trim(ctk_ccd))
where 
    d_e_l_e_t_ = ' '
    and ctk_data like '2021%'
    and trim(ctk_ccd) in (select CODCC_PROTHEUS_DE from PROTHEUS_APEX.tmp_organograma2021_de_para where CODCC_PROTHEUS_DE <> ' ');
*/    

--Observação: Todos os scripts foram executados. Os que estão comentados alguns o Renatos pediu para retirar e outros não existe  movimentação para os critérios adotados em 2021.

commit

rollback 