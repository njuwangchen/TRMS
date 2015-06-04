# TRMS

## 部署说明：

###1. 安装依赖环境：
   - virtualenv env #在目录下新建虚拟环境
   - . env/bin/activate #打开虚拟环境
   - pip install -r requirement.txt #读取文件，从中安装本项目所有依赖的环境

###2. 导入数据库文件

###3. 运行：
   + //在虚拟环境打开的情况下
   + python run.py

###4. API说明（以用户操作为例，其余类似）：
   <table>
    <tbody>
        <tr>
            <td>../api/v1/users</td>
            <td>post</td>
            <td>新建一个用户（参数要放在request的parameters中）</td>
        </tr>
        <tr>
            <td>../api/v1/users</td>
            <td>get</td>
            <td>得到所有用户列表</td>
        </tr>
         <tr>
            <td>../api/v1/users/<int:user_id></td>
            <td>get</td>
            <td>根据user_id得到当前用户</td>
        </tr>
         <tr>
            <td>../api/v1/users/<int:user_id></td>
            <td>put</td>
            <td>根据user_id得到当前用户，并根据request中的参数修改用户数据</td>
        </tr>
         <tr>
            <td>../api/v1/users/<int:user_id></td>
            <td>delete</td>
            <td>根据user_id得到当前用户，并从数据库删除</td>
        </tr>
    </tbody>
   </table>

