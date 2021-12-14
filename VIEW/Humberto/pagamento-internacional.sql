--Chamado: 134804 Solicitante: Humberto de Paula Ricardi
create view VW_PG_INTERNAC AS 

SELECT e2_xbcopg || '-' || a6_nome BancoPagamento
	--a6_nome NomeBanco,
	,e2_xctapg ContaPagamento
	,e2_xagepg AgenciaPagamento
	,ze_codnat Natureza
	--,ed_descric DescNatureza
	,E2_xnumap AP
	,e2_fornece CodFornecedor
	,trim(a2_nome) Fornecedor
	,trim(a2_end) Endereco
	,ya_descr Pais
	,e2_emissao Emissao
	,zz3_descpg DescPagamento
	,e2_vencrea Vencimento
    ,ze_nombco Banco
	,ze_forbco BancoFor
	,ze_forage AngenciaFor
	,ze_forcont ContaFor
	,ze_swift Swift
    ,ze_Iban
	,
	--protheus_apex.sa6010.a6_xciban Iban2,
	CASE 
		WHEN a6_moedap = '01'
			THEN '01-REAL'
		WHEN a6_moedap = '02'
			THEN '02-DOLAR'
		WHEN a6_moedap = '03'
			THEN '03-UFIR'
		WHEN a6_moedap = '04'
			THEN '04-EURO'
		WHEN a6_moedap = '05'
			THEN '05-IENE'
		WHEN a6_moedap = '06'
			THEN '06-DIRHAM'
		WHEN a6_moedap = '07'
			THEN '07-RUBLO'
		WHEN a6_moedap = '08'
			THEN '08-KWANZA'
		WHEN a6_moedap = '09'
			THEN '09-RENMINBI'
		WHEN a6_moedap = '10'
			THEN '10-PESO COLOMBIANO'
		WHEN a6_moedap = '11'
			THEN '11-PESO CUBA'
		WHEN a6_moedap = '12'
			THEN '12-FRANCO SUICO'
		WHEN a6_moedap = '13'
			THEN '13-LIBRA'
		WHEN a6_moedap = '14'
			THEN '14-SHEKEL'
		WHEN a6_moedap = '15'
			THEN '15-DOLAR (BC)'
		ELSE 'NA'
		END AS Moeda
	,
	--a6_moedap Moeda,
	--zz3_xmoeda Moeda,
	zz3_xvlror ValorOrig
FROM protheus_apex.zz3010
JOIN protheus_apex.se2010 ON zz3010.zz3_codigo = se2010.e2_XNUMAP
JOIN protheus_apex.sze010 ON ze_numap = zz3_codigo
JOIN protheus_apex.sa2010 ON e2_fornece = a2_cod
JOIN PROTHEUS_APEX.sed010 ON e2_naturez = ed_codigo
JOIN protheus_apex.sya010 ON a2_pais = ya_codgi
JOIN protheus_apex.sa6010 ON e2_xctapg = a6_numcon

	--and zz3010.zz3_codigo = '0000303519'
	AND e2_tipo = 'NF'
	AND a6_moedap <> '01'
WHERE se2010.d_e_l_e_t_ = ' '
	AND zz3010.d_e_l_e_t_ = ' '
    AND sze010.d_e_l_e_t_ = ' '
