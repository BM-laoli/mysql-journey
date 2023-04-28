var mysql  = require('mysql');  
 
var connection = mysql.createConnection({     
  host     : 'localhost',     //本机地址
  user     : 'root',          //用户
  password : '123456',        //密码
  port: '3306',               //端口号
  database: 'RUNOOB'            //要连接的数据库
}); 
 
connection.connect((info,info2)=>{
  console.log('====================================');
  console.log(info,info2);
  console.log('====================================');
});
 
var  sql = 'SELECT * FROM table1';   //查询table1表的所有数据

connection.query(sql,function (err, result) {
        if(err){
          console.log('[SELECT ERROR] - ',err.message);
          return;
        }
 
       console.log('--------------------------SELECT----------------------------');
       console.log(result);
       console.log('------------------------------------------------------------\n\n');  
});
 
connection.end();