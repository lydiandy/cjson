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

import cjson  // import lydiandy.cjson


struct User {
	name string
	age  int
}


fn main() {
	// cjson print
	u := User{name:'tom', age:18}
	root := cjson.create_object()
	cjson.add_item_to_object(root, "name", cjson.create_string(u.name))
	cjson.add_item_to_object(root, "age", cjson.create_number(u.age))
	json_str := cjson.json_print(root)
	println(json_str)

	// cjson parse
	json_content:='{"name":"jack","age":22}'
	res := cjson.json_parse(json_content)
	
	name := cjson.get_object_item(res, 'name')
	age := cjson.get_object_item(res, 'age')
	println(name.valuestring)
	println(age.valueint)

	// simple way to use cjson
	simple_example()
}


fn simple_example() {
	println('======== simple print json =========')
	user := cjson.obj()
	user.set("name", cjson.str("Tom"))
	user.set("age", cjson.num(18))
	user.set("score", cjson.num(6.2))
	user.set("gender", cjson.boolean(true))
	user.set("password", cjson.null())

	friend := cjson.obj()
	friend.set("name", cjson.str("Jack"))
	friends := cjson.list()
	friends.add(friend)
	user.set("friends", friends)

	leader := cjson.obj()
	leader.set("name", cjson.str("Mike"))
	user.set("leader", leader)

	json_str := user.dump()
	println(json_str)

	println('======== simple parse json =========')
	json_content := '{
        "name": "Tom",
        "age": 18,
        "score": 6.2,
        "gender": true,
        "password": null,
        "friends": [{
			"name": "Jack"
		}],
        "leader": {
			"name": "Mike"
        }
	}'
	obj := cjson.load(json_content)
	println(obj.get_str("name"))
	println(obj.get_int("age"))
	println(obj.get_num("score"))
	println(obj.get_boolean("gender"))
	println(obj.is_null("password"))
	println(obj.get("leader").get_str("name"))
}
```

## License

MIT

## Contributors

pull request is welcome ~