SELECT
	(trim(e5_prefixo) ||'/'|| trim(e5_numero) || '/'|| trim(e5_parcela)) as numero,
	    e2_fornece,
	    e2_loja,
	    a2_nome,
	    a2_cgc,
	    e2_xnumap,
	    e5_data,
	    e2_emissao,
	    e2_valor,
	    (case when e5_recpag = 'P' then e5_valor
	    when e5_recpag = 'R' then e5_valor * -1
	    end) as  e5_valor
	FROM
	    protheus_apex.SE5010 se5
	        inner join protheus_apex.SE2010 se2
	            on e2_filial = e5_filial
	            and e2_num = e5_numero 
	            and e2_prefixo = e5_prefixo
	            and e2_parcela = e5_parcela
	            and e2_fornece = e5_fornece
	            and e2_loja = e5_loja
	            and se2.d_e_l_e_t_ <> '*'
	        inner join protheus_apex.SA2010 sa2
	            on a2_cod = e2_fornece
	            and a2_loja = e2_loja
	            and sa2.d_e_l_e_t_ <> '*'
	WHERE
	    se5.d_e_l_e_t_ <> '*'
	    AND e5_situaca = ' '
	    and se5.r_e_c_n_o_ not in (select * from protheus_apex.vw_estornados)
	    and e5_motbx in ('NOR', 'DEB','BXF')--- ? não contempla BXF
	    and e5_data between '20210401' and '20210401'
        and e2_PREFIXO = 'INV'
        and e5_PREFIXO = 'INV'
	--if !empty(MV_PAR03)
		    --and e2_fornece = '"+MV_PAR03+"' 
		    --and e2_loja = '"+MV_PAR04+"'
	--endif
	
	--if!empty(MV_PAR05)
		    --and e2_xnumap = '"+MV_PAR05+"'
	--endif
	
	order by 
		e2_fornece,
		e5_data