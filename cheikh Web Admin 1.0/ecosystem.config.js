module.exports = {
  apps : [{
    name: "appconfig",                          // Name of your app
    script: "./app.js",                   // Entry point of your app
    watch: [                              // Watch specific directories/files
      "./public",
      "./route_function", 
      "./route_mobile", 
      "./router", 
      "./views"
    ],
    watch_delay: 1000,                    // Optional: Delay before restart to prevent multiple restarts
    ignore_watch: ["node_modules", "logs"], // Optional: Ignore unnecessary directories
  }]
}
