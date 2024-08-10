package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

	// Root endpoint
	r.GET("/", func(c *gin.Context) {
		c.String(http.StatusOK, "Hello, World!")
	})

	// JSON endpoint
	r.GET("/json", func(c *gin.Context) {
		response := gin.H{"message": "Hello, JSON!"}
		c.JSON(http.StatusOK, response)
	})

	// HTML endpoint
	r.GET("/html", func(c *gin.Context) {
		htmlContent := "<html><body><h1>Hello, HTML!</h1></body></html>"
		c.Data(http.StatusOK, "text/html; charset=utf-8", []byte(htmlContent))
	})

	r.Run(":1323")
}
