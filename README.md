# Minecraft Server with Plugin Management

This project provides a Minecraft server setup with automatic plugin management. It allows you to easily enable all plugins at once, making server management more efficient.

## Features

- Automatic plugin detection and enabling
- Support for up to 100+ plugins
- Simple command-line interface for plugin management
- Server startup script with plugin integration

## Getting Started

### Prerequisites

- Java Runtime Environment (JRE) 8 or higher
- Bash shell (for Linux/Mac) or Git Bash (for Windows)

### Installation

1. Clone this repository to your server:
   ```
   git clone https://github.com/yourusername/minecraft-server.git
   cd minecraft-server
   ```

2. Make the scripts executable:
   ```
   chmod +x *.sh
   ```

3. Install sample plugins (for demonstration):
   ```
   ./install_plugins.sh
   ```
   This will create 100 sample plugin placeholders. In a real environment, you would download actual plugin JAR files.

### Usage

#### Managing Plugins

- **Enable all plugins:**
  ```
  ./plugin_manager.sh enable all
  ```

- **Enable a specific plugin:**
  ```
  ./plugin_manager.sh enable PluginName.jar
  ```

- **Disable a specific plugin:**
  ```
  ./plugin_manager.sh disable PluginName.jar
  ```

- **Disable all plugins:**
  ```
  ./plugin_manager.sh disable all
  ```

- **List all plugins and their status:**
  ```
  ./plugin_manager.sh list
  ```

#### Starting the Server

To start the server with all plugins enabled:
```
./start_server.sh
```

The server will automatically enable all plugins if `auto-enable-all-plugins=true` is set in the `server.properties` file.

### Configuration

The main configuration file is `server.properties`. Key plugin-related settings include:

- `enable-plugins=true` - Enables plugin support
- `auto-enable-all-plugins=true` - Automatically enables all plugins on server startup
- `plugin-directory=plugins/` - Directory where plugins are stored

## Adding Real Plugins

To add real plugins:

1. Download plugin JAR files from trusted sources
2. Place the JAR files in the `plugins/` directory
3. Enable them using the plugin manager or let the server auto-enable them on startup

## License

This project is licensed under the terms of the license included in the repository.