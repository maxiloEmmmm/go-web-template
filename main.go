package main

import (
	"fmt"
	"github.com/maxiloEmmmm/go-web/contact"
)

func main() {
	contact.Init()
	defer contact.Close()

	// option
	contact.InitDB()
	defer contact.Db.Close()

	// option
	contact.InitRedis()
	defer contact.RedisClose()

	InitRoute().Run(fmt.Sprintf(":%d", contact.Config.App.Port))
}
