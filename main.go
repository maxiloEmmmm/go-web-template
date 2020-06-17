package main

import (
	"fmt"
	"github.com/maxiloEmmmm/go-web/contact"
)

func main() {
	contact.InitConfig()

	contact.InitDB()
	defer contact.Db.Close()

	contact.InitGin()

	InitRoute().Run(fmt.Sprintf(":%d", contact.Config.App.Port))
}
