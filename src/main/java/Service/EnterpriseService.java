package Service;

import bean.EnInv;
import bean.Enterprise;
import bean.Page;

import java.util.List;
import java.util.Map;

public interface EnterpriseService {
    /*
    * */
    boolean save(Enterprise en, List<EnInv> enInvList);

    /*
    * */
    Page<Enterprise> pageQuery(Map<String,String> conditionMap);

    /*
    * */
    Enterprise findByCode(String orgcode);
}
