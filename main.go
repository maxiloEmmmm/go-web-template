package main

import (
	"fmt"
	"github.com/maxiloEmmmm/go-web/contact"
)

func main() {
	contact.InitConfig()

	// option
	contact.InitLog()
	defer contact.LogClose()

	// option
	contact.InitDB()
	defer contact.Db.Close()

	// option
	contact.InitRedis()
	defer contact.RedisClose()

	contact.InitGin()

	InitRoute().Run(fmt.Sprintf(":%d", contact.Config.App.Port))
}
