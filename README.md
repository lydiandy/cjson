## cjson

wrap cJSON for vlang.

V already has the standard json module base on cJSON,but only public json.encode() and json.decode(). 

sometimes we may need to use [cJSON](https://github.com/DaveGamble/cJSON) directly.

## Installation

- via vpm

  ```
  v install lydiandy.cjson
  ```

- via source

  ```
  git clone git@github.com:lydiandy/cjson.git
  ln -s your/path ~/.vmodules/cjson
  ```

## usage

```v
module main

import lydiandy.cjson
// import cjson

struct User {
	name string
	age  int
}

fn main() {
	//cjson print
	u:=User {name:'tom',age:18}
	root:=cjson.create_object()
	cjson.add_item_to_object(root,"name",cjson.create_string(u.name))
	cjson.add_item_to_object(root,"age",cjson.create_number(u.age))
	json_str:=cjson.json_print(root)
	println(json_str)

	//cjson parse
	json_content:='{"name":"jack","age":22}'
	res:=cjson.json_parse(json_content)
	
	name:=cjson.get_object_item(res,'name')
	age:=cjson.get_object_item(res,'age')
	println(name.valuestring)
	println(age.valueint)
```

## License

MIT

## Contributors

pull request is welcome ~