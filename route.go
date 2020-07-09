package main

import (
	"github.com/gin-gonic/gin"
	"github.com/maxiloEmmmm/go-web/contact"
)

func InitRoute() *gin.Engine {
	r := gin.Default()
	r.Use(contact.GinCors())
	return r
}
