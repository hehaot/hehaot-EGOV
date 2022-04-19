package bean;

import java.util.ArrayList;
import java.util.List;

/*
* 分页对象，封装了分页查询的相关信息：页码、每页显示记录条数、总页数。。。。
* */
public class Page<T> {
    /*
    * 页码，当前第几页*/
    private Integer pageno;
    /*
    * 每页显示的记录条数*/
    private Integer pagesize;
    /*
    * 总条数*/
    private Integer totalsize;

    private List<T> dataList;

    private Integer beginIdex;

    public Page(String pageno) {
        if (pageno!=null) {
            this.pageno = Integer.parseInt(pageno);
        }else{
            this.pageno=1;
        }
        this.pagesize=3;
        this.beginIdex=(this.pageno-1)*pagesize;
        this.dataList =new ArrayList<T>();
    }

    public Integer getPageno() {
        return pageno;
    }

    public Integer getPagesize() {
        return pagesize;
    }

    public Integer getPagecount() {
        return totalsize%pagesize==0 ? totalsize/pagesize : totalsize/pagesize+1 ;
    }

    public Integer getTotalsize() {
        return totalsize;
    }

    public void setTotalsize(Integer totalsize) {
        this.totalsize = totalsize;
    }

    public List<T> getDataList() {
        return dataList;
    }

    public void setDataList(List<T> dataList) {
        this.dataList = dataList;
    }

    /*获取通用的分页SQL语句
        sql1:表名
        sql2：查询的列名
        sql3：按照谁排序
        select top "+pagesize+" usercode,username,orgtype from( select ROW_NUMBER()\n" +
                    "over (order by regdate desc) as rownumber,*from t_user)temp_row where rownumber >"+beginIdex+";"
        * */
    public String getSql(String sql1,String sql2,String sql3){
        return "select top "+pagesize+" "+sql2+" from( select ROW_NUMBER() " +
                "over ("+sql3+") as rownumber,*from "+sql1+")temp_row where rownumber >"+beginIdex;
    }
/*Select top 3 * From (
                  Select
                      Row_Number() Over(Order By t_invest.regdate desc) as rowId,
                      t_invest.invregnum,
                      t_invest.invname,
                      t_invest.regdate,
                      t_invest.cty,
                      t_user.username
                  From

                    t_invest INNER JOIN t_user  ON t_invest.usercode = t_user.usercode

                  Where t_invest.cty ='000'
              ) as MyTable

Where rowId > 0*/

    public String getSql(String sql1){
        return "Select top "+pagesize+" * From ( Select Row_Number() Over(Order By t_invest.regdate desc ,t_invest.invname) as rowId,t_invest.invregnum," +
                "t_invest.invname,\n" +
                "t_invest.regdate,\n" +
                "t_invest.cty,\n" +
                "t_user.username From t_invest INNER JOIN t_user ON t_invest.usercode = t_user.usercode Where 0=0"+sql1+" \n" +
                ") as MyTable Where rowId >"+beginIdex;

    }
    /*两表联合通用分页查询
    * Order By t_invest.regdate desc ,t_invest.invname
    * t_invest.invregnum,t_invest.invname,t_invest.regdate,t_invest.cty,t_user.username
    * sql1:按照什么排序
    * sql2:查询什么字段
    * sql3:表1
    * sql4:表2
    * sql5:两表的相同字段
    * sql6:查询条件
    * */
    public String getSql(String sql1,String sql2,String sql3,String sql4,String sql5,String sql6){
        return "Select top "+pagesize+" * From ( Select Row_Number() Over("+sql1+") as rowId,"+sql2+" From "+sql3+" INNER JOIN "+sql4+" ON "+sql5+" Where 0=0 "+sql6+") as MyTable Where rowId >"+beginIdex;

    }
    /*通用给totalsize赋值*/
    public String getSql(String sql1,String sql2,String sql3,String sql4,String sql5,String sql6,String sql7){
        return "Select "+sql7+" From ( Select Row_Number() Over("+sql1+") as rowId,"+sql2+" From "+sql3+" INNER JOIN "+sql4+" ON "+sql5+" Where 0=0 "+sql6+") as MyTable Where rowId >"+beginIdex;

    }

    public String getSql(String sql1,String sql2){
        return "Select count(*) as totalsize From ( Select Row_Number() Over(Order By t_invest.regdate desc) as rowId, t_invest.regdate From t_invest INNER JOIN t_user ON t_invest.usercode = t_user.usercode Where 0=0 "+sql1+") as MyTable Where rowId >0";

    }
}
