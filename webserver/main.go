package main

import (
    "fmt"
    "log"
    "net/http"
    "math"
    "github.com/prometheus/client_golang/prometheus"
    "github.com/prometheus/client_golang/prometheus/promhttp"
)

var (
    httpRequestsTotal = prometheus.NewCounterVec(
        prometheus.CounterOpts{
            Name: "http_requests_total",
            Help: "Total number of HTTP requests.",
        },
        []string{"path"},
    )
    httpDuration = prometheus.NewHistogramVec(
        prometheus.HistogramOpts{
            Name: "http_request_duration_seconds",
            Help: "Duration of HTTP requests in seconds.",
        },
        []string{"path"},
    )
)

func cpuIntensiveTask() {
    // More CPU-intensive calculations
    for i := 0; i < 10000000; i++ {
        _ = math.Sqrt(float64(i))
    }
}

func serverInfo(w http.ResponseWriter, r *http.Request) {
    timer := prometheus.NewTimer(httpDuration.WithLabelValues(r.URL.Path))
    defer timer.ObserveDuration()

    log.Printf("Received request for %s\n", r.URL.Path)

    // Artificial CPU load
    cpuIntensiveTask()

    // Set the status code to 200
    w.WriteHeader(http.StatusOK)
    fmt.Fprintf(w, "Web Server is running")
    httpRequestsTotal.WithLabelValues(r.URL.Path).Inc()
}

func main() {
    // Register Prometheus metrics
    prometheus.MustRegister(httpRequestsTotal)
    prometheus.MustRegister(httpDuration)

    // Expose the metrics endpoint
    http.Handle("/metrics", promhttp.Handler())

    http.HandleFunc("/", serverInfo) // setting the route

    fmt.Println("Starting server on port 8080...")
    log.Fatal(http.ListenAndServe(":8080", nil))
}
