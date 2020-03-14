module main

import cjson  // import lydiandy.cjson


fn main() {
	// print json 
	user := cjson.obj()
	user.set("name", cjson.str("Tom"))
	user.set("age", cjson.num(18))
	user.set("score", cjson.num(6.2))
	user.set("gender", cjson.boolean(true))
	user.set("password", cjson.null())

	friends := cjson.list()
	friend := cjson.obj()
	friend.set("name", cjson.str("Jack"))
	friends.add(friend)
	user.set("friends", friends)

	leader := cjson.obj()
	leader.set("name", cjson.str("Mike"))
	user.set("leader", leader)

	json_str := user.dump()
	println(json_str)

	// parse json 
	json_content := '{
        "name": "Tom",
        "age": 18,
        "score": 6.2,
        "gender": true,
        "password": null,
        "friends": [
			{
				"name": "Jack"
			}
		],
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
	rs := obj.get("friends")
	println(rs)
	println(rs)
	println(obj.get("leader"))
}
