# init_site.sh Script

The `init_site.sh` script is the heart of this MkDocs template's automation. It intelligently sets up your documentation site by detecting your repository information and configuring everything automatically.

## Script Overview

The script performs a complete setup workflow:

1. **Environment Detection** - Identifies your Git repository and GitHub information
2. **Configuration Management** - Updates MkDocs configuration with your specific details
3. **Environment Setup** - Creates Python virtual environment and installs dependencies
4. **Navigation Building** - Generates dynamic navigation based on your content
5. **Site Building** - Builds and serves your documentation

## Core Functions Breakdown

### 1. Git Repository Detection

```bash
parse_git_remote() {
    local remote_url
    
    if ! remote_url=$(git remote get-url origin 2>/dev/null); then
        print_error "Could not get git remote URL"
        exit 1
    fi
    
    # Parse different URL formats:
    # SSH: git@github.com:owner/repo.git
    # HTTPS: https://github.com/owner/repo.git
    if [[ $remote_url =~ git@github\.com:([^/]+)/([^.]+)\.git ]]; then
        REPO_OWNER="${BASH_REMATCH[1]}"
        REPO_NAME="${BASH_REMATCH[2]}"
    # ... additional format handling
}
```

**What it does:**
- Extracts GitHub repository information from your Git remote URL
- Supports both SSH and HTTPS Git URL formats
- Automatically determines repository owner and name
- Provides fallback values if parsing fails

### 2. Dynamic URL Generation

```bash
generate_urls() {
    SITE_URL="https://${REPO_OWNER}.github.io/${REPO_NAME}/"
    REPO_URL="https://github.com/${REPO_OWNER}/${REPO_NAME}"
}
```

**What it does:**
- Generates GitHub Pages URL automatically
- Creates repository URL for documentation links
- Ensures consistent URL formatting

### 3. Configuration File Updates

```bash
update_yaml_field_if_empty() {
    local field_name="$1"
    local field_value="$2"
    local config_file="$3"
    
    if grep -q "^${field_name}:$" "$config_file"; then
        sed -i.bak "s|^${field_name}:$|${field_name}: ${field_value}|g" "$config_file"
    else
        print_warning "$field_name already has a value, skipping"
    fi
}
```

**What it does:**
- Only updates empty configuration fields
- Preserves existing custom configurations
- Creates backup files automatically
- Uses safe sed operations for cross-platform compatibility

### 4. Modular Configuration Assembly

```bash
build_mkdocs_config() {
    print_info "Building final mkdocs.yml from individual config files..."
    
    if ! cat mkdocs/*.yml > mkdocs.yml 2>/dev/null; then
        print_error "Failed to concatenate mkdocs config files"
        exit 1
    fi
}
```

**What it does:**
- Combines all modular configuration files into final `mkdocs.yml`
- Maintains separation of concerns (site info, theme, plugins, etc.)
- Enables easy customization of individual aspects

### 5. Dynamic Navigation Integration

```bash
build_dynamic_navigation() {
    print_info "Building dynamic navigation structure..."
    
    if [[ -f "build_nav.sh" ]]; then
        if ./build_nav.sh --sort numeric; then
            print_success "Dynamic navigation built successfully"
        else
            print_warning "Dynamic navigation build failed, using existing navigation"
        fi
    fi
}
```

**What it does:**
- Automatically generates navigation based on content structure
- Uses numeric sorting for ordered content
- Gracefully handles navigation build failures
- Integrates with the separate navigation builder script

## Configuration Files Logic

The script works with 6 modular configuration files:

| Configuration File         | Category             | Description                                                                                                     |
| -------------------------- | -------------------- | --------------------------------------------------------------------------------------------------------------- |
| `01-mkdocs-site.yml`       | Site Basics          | • Site name, URL, and description<br>• Repository information<br>• Basic metadata                               |
| `02-mkdocs-theme.yml`      | Theme Configuration  | • Material theme settings<br>• Color schemes and palettes<br>• Navigation features<br>• Fonts and icons         |
| `03-mkdocs-extra.yml`      | Extra Features       | • Social media links<br>• GitHub integration buttons<br>• Custom CSS and JavaScript<br>• Additional metadata    |
| `04-mkdocs-plugins.yml`    | Plugin Configuration | • Search functionality<br>• Git integration plugins<br>• PDF export capabilities<br>• Site optimization plugins |
| `05-mkdocs-extensions.yml` | Markdown Extensions  | • Code highlighting<br>• Admonitions and callouts<br>• Table enhancements<br>• Diagram support                  |
| `06-mkdocs-nav.yml`        | Navigation Structure | • Site navigation hierarchy<br>• Page organization<br>• Menu structure                                          |

## Environment Setup Logic

### Virtual Environment Management

```bash
setup_python_env() {
    if [[ -d "$VENV_DIR" ]]; then
        print_info "Virtual environment found, activating..."
        source "$VENV_DIR/bin/activate"
    else
        print_info "Creating new virtual environment..."
        python3 -m venv "$VENV_DIR"
        source "$VENV_DIR/bin/activate"
        
        pip install --upgrade pip
        pip install -r "$REQUIREMENTS_FILE"
    fi
}
```

**Benefits:**
- Isolated Python environment for your documentation
- Automatic dependency installation
- Reuses existing environments when available
- Upgrades pip to latest version

## Error Handling and Safety

### Robust Error Management

```bash
set -euo pipefail  # Exit on error, undefined vars, pipe failures

# Validation functions
validate_yaml() {
    # YAML validation with fallbacks
}

# Cleanup on exit
cleanup() {
    if [[ -f "$TEMP_NAV" ]]; then
        rm -f "$TEMP_NAV"
    fi
}
trap cleanup EXIT
```

**Safety Features:**
- Strict error handling with immediate exit on failures
- Automatic cleanup of temporary files
- YAML validation before applying changes
- Backup creation before modifications

## Command Line Options

The script supports several options for different use cases:

```bash
./init_site.sh                  # Full setup and serve
./init_site.sh --no-serve       # Setup and build only  
./init_site.sh --clean          # Clean build and serve
./init_site.sh --verbose        # Detailed output
./init_site.sh --help           # Show usage information
```

## Workflow Sequence

1. **Parse Arguments** - Process command line options
2. **Load Environment** - Source `.env` file if present
3. **Initialize Workspace** - Change to Git root directory
4. **Parse Git Remote** - Extract repository information
5. **Generate URLs** - Create GitHub Pages and repository URLs
6. **Update Configuration** - Modify only empty configuration fields
7. **Build Configuration** - Combine modular config files
8. **Build Navigation** - Generate dynamic navigation structure
9. **Setup Environment** - Create/activate Python virtual environment
10. **Build Documentation** - Generate the documentation site
11. **Serve Documentation** - Start development server (unless `--no-serve`)

## Customization Points

### Environment Variables
Create a `.env` file to override defaults:

```bash
REPO_OWNER=your-username
REPO_NAME=your-repo-name
SITE_URL=https://your-custom-domain.com
```

### Configuration Override
The script only updates empty fields, so you can pre-configure:

```yaml
# In mkdocs/01-mkdocs-site.yml
site_name: My Custom Site Name  # Won't be overridden
site_url:                       # Will be auto-generated
```

## Best Practices

1. **Run from Git Repository Root** - Script validates Git context
2. **Commit Changes First** - Script assumes clean Git state
3. **Review Generated Config** - Check `mkdocs.yml` after first run
4. **Test Locally First** - Use `--no-serve` for CI/CD environments
5. **Keep Backups** - Script creates `.backup` files automatically

## Troubleshooting

### Common Issues

**Git Remote Not Found:**
```bash
# Ensure you have a GitHub remote configured
git remote add origin https://github.com/username/repo.git
```

**Python Environment Issues:**
```bash
# Clear virtual environment and restart
rm -rf .venv
./init_site.sh
```

**Configuration Conflicts:**
```bash
# Restore from backup
cp mkdocs/06-mkdocs-nav.yml.backup mkdocs/06-mkdocs-nav.yml
```

The `init_site.sh` script embodies the "convention over configuration" principle, providing intelligent defaults while remaining fully customizable for advanced use cases.
