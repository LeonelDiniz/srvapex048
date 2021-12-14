SELECT 
--cn8_numdoc,
(select cn3_descri from protheus_apex.cn3010 where cn8_tpcauc = cn3_codigo and cn3010.d_e_l_e_t_ = ' ' )ModGaranatia,
--cn8_descau,
(select cn9_numero from PROTHEUS_APEX.cn9010 where cn8_contra=cn9_numero and cn9010.d_e_l_e_t_ = ' ' group by cn9_numero)NumContrato,
(select cn9_xnuant from PROTHEUS_APEX.cn9010 where cn8_contra=cn9_numero and cn9010.d_e_l_e_t_ = ' ' group by cn9_xnuant)NumAnterior,
(select a2_cgc from sa2010 where cn8_fornec=a2_cod and sa2010.d_e_l_e_t_ = ' ') CNPJ ,
(select a2_nome from sa2010 where cn8_fornec=a2_cod and sa2010.d_e_l_e_t_ = ' ') NomeFornec ,
cn8_emiten Emitente,
cn8_descmo Moeda,
(select max(cn9_vlatu) from PROTHEUS_APEX.cn9010 where cn8_contra=cn9_numero and cn9010.d_e_l_e_t_ = ' ' group by cn9_numero)VlrAtu,
cn8_vlefet VlrEfetivo, 
cn8_dtinvi DtInicio, 
cn8_dtfivi DtFim, 
cn8_dtent DtEntrega, 
cn8_observ Observacao
FROM PROTHEUS_APEX.CN8010
WHERE d_e_l_e_t_ = ' ';



