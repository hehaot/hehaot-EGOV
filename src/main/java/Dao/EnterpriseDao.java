package Dao;

import bean.EnInv;
import bean.Enterprise;
import bean.Page;

import java.util.List;
import java.util.Map;

public interface EnterpriseDao {
    int insert(Enterprise en, List<EnInv> enInvList);

    Page<Enterprise> pageQuery(Map<String,String> conditionMap);

    Enterprise selectByCode(String orgcode);
}
