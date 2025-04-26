package main

import (
	"crypto/tls"
	"log" // Added import
	"net/http"

	"github.com/gin-gonic/gin"
	// "golang.org/x/net/http3" // Removed deprecated import
)

func main() {
	r := gin.Default()
	// Define routes here...
	// Example route:
	r.GET("/", func(c *gin.Context) {
		c.String(http.StatusOK, "Hello from Gin over TLS!")
	})

	// Load TLS certs
	certPath := "certs/server.pem" // Consider making these configurable
	keyPath := "certs/server.key"
	cert, err := tls.LoadX509KeyPair(certPath, keyPath)
	if err != nil {
		log.Fatalf("Failed to load key pair: %v", err) // Added error handling
	}

	// Basic HTTP/1.1 & HTTP/2 server setup with TLS
	server := &http.Server{
		Addr:    ":8443", // Port for HTTPS
		Handler: r,
		TLSConfig: &tls.Config{
			Certificates: []tls.Certificate{cert},
			// Consider adding MinVersion, CipherSuites etc. for better security
		},
	}

	log.Println("Starting HTTPS server on :8443 (HTTP/1.1 & HTTP/2)")
	// ListenAndServeTLS will handle both HTTP/1.1 and HTTP/2 automatically
	if err := server.ListenAndServeTLS(certPath, keyPath); err != nil && err != http.ErrServerClosed {
		log.Fatalf("Server error: %v", err)
	}
}
