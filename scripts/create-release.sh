#!/bin/bash

# Release Helper Script for Bash Escape Room
# This script helps create versioned releases with proper Docker image builds

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_usage() {
    echo "Usage: $0 <version> [release-notes]"
    echo ""
    echo "Examples:"
    echo "  $0 v1.0.0"
    echo "  $0 v1.2.3 \"Added new escape room challenges\""
    echo "  $0 v2.0.0-beta \"Beta release with experimental features\""
    echo ""
    echo "Version format: vX.Y.Z or vX.Y.Z-suffix"
}

validate_version() {
    local version="$1"
    if [[ ! "$version" =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9]+)?$ ]]; then
        echo -e "${RED}Error: Invalid version format. Use vX.Y.Z or vX.Y.Z-suffix${NC}"
        print_usage
        exit 1
    fi
}

check_git_status() {
    if [[ -n $(git status --porcelain) ]]; then
        echo -e "${YELLOW}Warning: You have uncommitted changes.${NC}"
        echo "Uncommitted files:"
        git status --porcelain
        read -p "Continue anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Aborted."
            exit 1
        fi
    fi
}

create_tag_and_release() {
    local version="$1"
    local notes="$2"
    
    echo -e "${BLUE}Creating git tag: $version${NC}"
    git tag -a "$version" -m "Release $version${notes:+: $notes}"
    
    echo -e "${BLUE}Pushing tag to origin...${NC}"
    git push origin "$version"
    
    echo -e "${GREEN}✅ Tag created and pushed successfully!${NC}"
    echo -e "${BLUE}GitHub Actions will now build and publish Docker images.${NC}"
    echo ""
    echo -e "${YELLOW}Monitor the build progress at:${NC}"
    echo "https://github.com/$(git remote get-url origin | sed 's/.*github.com[:/]\([^.]*\).*/\1/')/actions"
    echo ""
    echo -e "${YELLOW}Once built, your Docker images will be available at:${NC}"
    echo "ghcr.io/nirgeier/bash-escaperoom:$version"
    echo "ghcr.io/nirgeier/bash-escaperoom:latest"
}

main() {
    if [[ $# -lt 1 ]]; then
        print_usage
        exit 1
    fi
    
    local version="$1"
    local notes="$2"
    
    validate_version "$version"
    check_git_status
    
    echo -e "${GREEN}🚀 Creating release: $version${NC}"
    [[ -n "$notes" ]] && echo -e "${BLUE}Release notes: $notes${NC}"
    echo ""
    
    # Confirm before proceeding
    read -p "Proceed with release creation? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 1
    fi
    
    create_tag_and_release "$version" "$notes"
    
    echo -e "${GREEN}🎉 Release $version created successfully!${NC}"
    echo ""
    echo -e "${BLUE}Next steps:${NC}"
    echo "1. Monitor GitHub Actions for build completion"
    echo "2. Test the Docker image: docker run -it ghcr.io/nirgeier/bash-escaperoom:$version"
    echo "3. Create a GitHub release (optional) at: https://github.com/$(git remote get-url origin | sed 's/.*github.com[:/]\([^.]*\).*/\1/')/releases/new?tag=$version"
}

# Run main function
main "$@"
