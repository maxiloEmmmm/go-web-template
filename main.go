package main

import (
	"fmt"
	//_ "example/docs"
	"github.com/maxiloEmmmm/go-web/contact"
)

// @title project-name
// @version version
// @BasePath /api/v1/
// @securityDefinitions.apikey ApiKeyAuth
// @in header
// @name Authorization
func main() {
	contact.InitConfig()

	contact.InitDB()
	defer contact.Db.Close()

	contact.InitGin()

	InitRoute().Run(fmt.Sprintf(":%d", contact.Config.App.Port))
}
