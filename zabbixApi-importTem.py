# 导入模板
def import_template(auth, source):
    values ={
                "jsonrpc": "2.0",
                "method": "configuration.import",
                "params": {
                    "format": "xml",
                    "rules": {
                        "templates": {
                            "createMissing": True,
                            "updateExisting": True
                        },
                        "applications": {
                            "createMissing": True,
                            "deleteMissing": True
                        },
                        "items": {
                            "createMissing": True,
                            "updateExisting": True,
                            "deleteMissing": True
                        },
                        "triggers": {
                            "createMissing": True,
                            "updateExisting": True,
                            "deleteMissing": True
                        },
                        "groups": {
                            "createMissing": True,
                        },
                        "hosts": {
                            "createMissing": True,
                            "updateExisting": True
                        },
                    },
                    "source": source
                },
                "auth": auth,
                "id": 1
            }

    output = requestJson(url,values)
    return output

auth = authenticate(url,username,password)
template_filename = 'zbx_export_templates.xml'
with open(template_filename, 'r') as f:   # 从文件中读取刚刚导出的模板
    source = f.read()
print import_template(auth, source=source)

# 注：参数说明
# 1、createMissing：如果设置为true，没有就会创建新的
# 2、deleteMissing：如果设置为true，不在导入数据中的将会从数据库中被删除；
# 3、updateExisting：如何设置为true，已有的将会被更新；

configuration.import
