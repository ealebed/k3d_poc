package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func getRoot(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "This is test website!")
}
func getHostname(w http.ResponseWriter, r *http.Request) {
	name, err := os.Hostname()
	if err != nil {
		panic(err)
	}

	fmt.Fprintf(w, "Hello from: %s\n", name)
}

func main() {
	http.HandleFunc("/", getRoot)
	http.HandleFunc("/hostname", getHostname)

	// Determine port for HTTP service.
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
		log.Printf("defaulting to port %s", port)
	}

	// Start HTTP server.
	log.Printf("listening on port %s", port)
	http.ListenAndServe("0.0.0.0:"+port, nil)
}
