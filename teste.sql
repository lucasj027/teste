/*
select	
		usu_codcvn
		,usu_codcrt
		,usu_ocratu 
		,usu_datref
		,usu_docpag
		,usu_vlrtit
		,DATEPART(YEAR, usu_datref) ano
		,DATEPART(MONTH, usu_datref) mes
into ##053EmAbril
FROM usu_tlogtit tit
WHERE usu_codcvn IN (1)
and usu_ocratu = '053'
and DATEPART(YEAR, usu_datref) = 2020
and DATEPART(MONTH, usu_datref) = 03
and not exists (
					select	
					usu_codcvn
					,usu_codcrt
					,usu_ocratu
					,usu_datref
					,usu_docpag
					,usu_vlrtit
					,DATEPART(YEAR, usu_datref) ano
					,DATEPART(MONTH, usu_datref) mes
			FROM usu_tlogtit tit2
			WHERE usu_codcvn IN (1)
			and usu_ocratu = '053'
			and DATEPART(YEAR, usu_datref) = 2020
			and DATEPART(MONTH, usu_datref) = 04
			and tit.usu_codcvn = tit2.usu_codcvn
			and RIGHT('000000000000000' + LTRIM(RTRIM(tit.usu_docpag)), 15)
			=	RIGHT('000000000000000' + LTRIM(RTRIM(tit2.usu_docpag)), 15) collate SQL_Latin1_General_CP1_CI_AS 
			)

*/

--Recuperado 053 Maio 2021

select recuperado.*
		,DC.DATA
from SolloBrasil_CVT.dbo.dCalendario dc
LEFT JOIN
					(SELECT (CASE
								WHEN usu_codcvn = 20	THEN 'ACACCI'
								WHEN usu_codcvn = 9		THEN 'APAE-SP'
								WHEN usu_codcvn = 1		THEN 'APAE-ES'
								WHEN usu_codcvn = 13	THEN 'HECI'
								WHEN usu_codcvn = 3		THEN 'HEVV'
								WHEN usu_codcvn = 15	THEN 'HIFA'
								WHEN usu_codcvn = 18	THEN 'STA CASA CAC'
								WHEN usu_codcvn = 16	THEN 'STA CASA VIX'
							END) AS Convenio
						,(CASE
								WHEN usu_codcrt = 1		THEN 'Acatado'
								WHEN usu_codcrt = 2		THEN 'Faturado'
								WHEN usu_codcrt = 3		THEN 'Rejeitado'
								WHEN usu_codcrt = 4		THEN 'Cancelado'
								WHEN usu_codcrt = 5		THEN 'Arrecadado'
								WHEN usu_codcrt = 99	THEN 'sem a��o'
								else 'Verificar'						
							END) AS AcaoRetorno
				,usu_codcvn
				,usu_codcrt
				,usu_ocratu
				,usu_datref
				,usu_docpag
				,usu_vlrtit
				,DATEPART(YEAR, usu_datref) ano
				,DATEPART(MONTH, usu_datref) mes
		FROM usu_tlogtit tit3
		WHERE usu_codcvn IN (1, 3, 9, 15, 16, 18, 20)
		and datepart(year,usu_datref) >= 2020
		and exists (
							select	top 10
							usu_codcvn
							,usu_codcrt
							,usu_ocratu
							,usu_datref
							,usu_docpag
							,usu_vlrtit
							,DATEPART(YEAR, usu_datref) ano
							,DATEPART(MONTH, usu_datref) mes
					--into ##053EmAbril
					FROM usu_tlogtit tit
					WHERE usu_codcvn IN (1, 3, 9, 15, 16, 18, 20)
					--and usu_ocratu = '053'
					and usu_codcrt in (1)
					and DATEPART(YEAR, usu_datref) = 2021
					and DATEPART(MONTH, usu_datref) = 05
					and exists (
										select	
										usu_codcvn
										,usu_codcrt
										,usu_ocratu
										,usu_datref
										,usu_docpag
										,usu_vlrtit
										,DATEPART(YEAR, usu_datref) ano
										,DATEPART(MONTH, usu_datref) mes
								FROM usu_tlogtit tit2
								WHERE usu_codcvn IN (1, 3, 9, 15, 16, 18, 20)
								and usu_ocratu = '053'
								and DATEPART(YEAR, usu_datref) = 2021
								and DATEPART(MONTH, usu_datref) = 04
								and tit.usu_codcvn = tit2.usu_codcvn
								and RIGHT('000000000000000' + LTRIM(RTRIM(tit.usu_docpag)), 15)
								=	RIGHT('000000000000000' + LTRIM(RTRIM(tit2.usu_docpag)), 15) collate SQL_Latin1_General_CP1_CI_AS 
					)
					and tit.usu_codcvn = tit3.usu_codcvn
					and RIGHT('000000000000000' + LTRIM(RTRIM(tit.usu_docpag)), 15)
					=	RIGHT('000000000000000' + LTRIM(RTRIM(tit3.usu_docpag)), 15) collate SQL_Latin1_General_CP1_CI_AS  
			
		)
)recuperado
ON recuperado.usu_datref = dc.DATA
where datepart(year,dc.data) >= 2020
and datepart(year,dc.data) <= 2021




/*




--AND DATEPART(YEAR, usu_datref ) >= DATEPART(YEAR, DATEADD(YEAR, -2, GETDATE()))
--AND DATEPART(YEAR, usu_datref ) >= 2020
--AND usu_codcrt IN (01)
GROUP BY 
		
		DATEPART(YEAR, usu_datref) 
		,DATEPART(MONTH, usu_datref)
		,usu_codcvn
		,usu_codcrt
		,usu_datref
		
		
		select usu_codcrt, usu_vlrtit, count (*) qtd
		FROM usu_tlogtit
WHERE usu_codcvn IN (21)
and usu_docpag like '%7008607022'
group by usu_codcrt, usu_vlrtit
order by qtd

use Sapiens

select usu_codcvn, usu_ocratu, usu_codcrt, usu_docpag, usu_datref
from sapiens.dbo.usu_tlogtit -- tit
where usu_codcvn in (9)
and usu_docpag like '%00743226767'
--and usu_ocratu = '053'
and usu_datref >= '2020-11-01'
order by usu_datref desc


SELECT *
FROM [SolloBrasil_CVT].[EDP].[MotivoBloqueioEDP]
WHERE CodConvenio IN (9)
AND Instalacao LIKE '743226767'



*/