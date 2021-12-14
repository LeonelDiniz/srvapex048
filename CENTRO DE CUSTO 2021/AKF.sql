select akf_xccust, akf_xano
from protheus_apex.akf010
where d_e_l_e_t_ = ' '
and akf_xano = 2021

select akf_xano from protheus_apex.AKF010
where d_e_l_e_t_ = ' '
GROUP BY akf_xano
/*
2021
2020
*/