INSERT INTO fips_dimension
SELECT  DISTINCT
         fips
       , state
       , county
FROM
         OUTCOMES_FACTORS_SUBRANKINGS_STG
GROUP BY
         fips 
       , state
       , county
;


INSERT INTO OUTCOMES_FACTORS_SUBRANKINGS_FACT
SELECT DISTINCT
       A.fips
     , A.lngth_of_lf_z_2019_score
     , A.lngth_of_lf_2019_rank
     , A.qlty_of_lf_z_2019_score
     , A.qlty_of_lf_2019_rank
     , A.hlth_of_bhvr_z_2019_score
     , A.hlth_of_bhvr_2019_rank
     , A.clncl_cr_z_2019_score
     , A.clncl_cr_2019_rank
     , A.soc_eco_fctrs_z_2019_score
     , A.soc_eco_fctrs_2019_rank
     , A.phys_en_z_2019_score
     , A.phys_en_2019_rank
	 ,B.TOT_RLS_CUMUL_2016
	 ,B.TOT_RLS_2016
	 ,B.TOT_RLS_SITE_COUNTS
FROM public.outcomes_factors_subrankings_stg A
LEFT JOIN 
	(
	SELECT column8 AS FIPS
		 , SUM(column12) AS TOT_RLS_CUMUL_2016
		 , SUM(CASE WHEN column13 = -1
		   THEN NULL
		   ELSE column13
		   END) AS TOT_RLS_2016
		,COUNT(*) AS TOT_RLS_SITE_COUNTS
	FROM public.tri_facilities_all_stg
	GROUP BY column8
	) B ON(A.FIPS = B.FIPS)