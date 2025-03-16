#!/bin/bash

# Plugin Manager for Minecraft Server
# This script manages the enabling and disabling of plugins

SERVER_PROPERTIES="server.properties"
PLUGIN_DIR="plugins"
ENABLED_PLUGINS_FILE="plugins/enabled_plugins.txt"

# Function to read a property from server.properties
get_property() {
    local property=$1
    grep "^$property=" "$SERVER_PROPERTIES" | cut -d'=' -f2
}

# Function to enable a plugin
enable_plugin() {
    local plugin=$1
    if [ -f "$PLUGIN_DIR/$plugin" ]; then
        echo "Enabling plugin: $plugin"
        grep -q "^$plugin$" "$ENABLED_PLUGINS_FILE" || echo "$plugin" >> "$ENABLED_PLUGINS_FILE"
    else
        echo "Plugin not found: $plugin"
    fi
}

# Function to disable a plugin
disable_plugin() {
    local plugin=$1
    echo "Disabling plugin: $plugin"
    if [ -f "$ENABLED_PLUGINS_FILE" ]; then
        sed -i "/^$plugin$/d" "$ENABLED_PLUGINS_FILE"
    fi
}

# Function to list all plugins
list_plugins() {
    echo "Available plugins:"
    find "$PLUGIN_DIR" -maxdepth 1 -name "*.jar" -type f | while read plugin; do
        plugin_name=$(basename "$plugin")
        if grep -q "^$plugin_name$" "$ENABLED_PLUGINS_FILE" 2>/dev/null; then
            echo "  [ENABLED] $plugin_name"
        else
            echo "  [DISABLED] $plugin_name"
        fi
    done
}

# Function to enable all plugins
enable_all_plugins() {
    echo "Enabling all plugins..."
    find "$PLUGIN_DIR" -maxdepth 1 -name "*.jar" -type f | while read plugin; do
        plugin_name=$(basename "$plugin")
        enable_plugin "$plugin_name"
    done
    echo "All plugins enabled."
}

# Create enabled_plugins.txt if it doesn't exist
if [ ! -f "$ENABLED_PLUGINS_FILE" ]; then
    touch "$ENABLED_PLUGINS_FILE"
fi

# Check if auto-enable-all-plugins is set to true
auto_enable=$(get_property "auto-enable-all-plugins")
if [ "$auto_enable" = "true" ]; then
    echo "Auto-enable all plugins is set to true."
    enable_all_plugins
fi

# Process command line arguments
case "$1" in
    enable)
        if [ "$2" = "all" ]; then
            enable_all_plugins
        else
            enable_plugin "$2"
        fi
        ;;
    disable)
        if [ "$2" = "all" ]; then
            echo "Disabling all plugins..."
            > "$ENABLED_PLUGINS_FILE"
            echo "All plugins disabled."
        else
            disable_plugin "$2"
        fi
        ;;
    list)
        list_plugins
        ;;
    *)
        echo "Usage: $0 {enable|disable} {plugin_name|all} | list"
        echo "  enable plugin_name - Enable a specific plugin"
        echo "  enable all - Enable all plugins"
        echo "  disable plugin_name - Disable a specific plugin"
        echo "  disable all - Disable all plugins"
        echo "  list - List all plugins and their status"
        ;;
esac

exit 0