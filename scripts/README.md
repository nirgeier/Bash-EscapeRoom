# Docker Release Process

This directory contains tools and workflows for creating Docker image releases.

## Quick Start

### Creating a Release

Use the provided script to create a new release:

```bash
# Create a new release
./scripts/create-release.sh v1.0.0 "Initial release with all escape room challenges"

# Create a beta release  
./scripts/create-release.sh v1.1.0-beta "Beta release with new features"
```

### Manual Release Process

If you prefer to create releases manually:

1. **Create and push a git tag:**
   ```bash
   git tag -a v1.0.0 -m "Release v1.0.0: Description"
   git push origin v1.0.0
   ```

2. **Monitor the build:**
   - Go to [GitHub Actions](../../actions)
   - Watch the "Docker Release" workflow
   - Wait for completion (usually 5-10 minutes)

3. **Test the release:**
   ```bash
   docker run -it ghcr.io/nirgeier/bash-escaperoom:v1.0.0
   ```

## Release Workflow Features

The automated release workflow (`docker-release.yml`) provides:

### 🏗️ **Multi-Platform Builds**
- `linux/amd64` (Intel/AMD 64-bit)
- `linux/arm64` (ARM 64-bit, including Apple Silicon)

### 🏷️ **Smart Tagging**
- **Version tags**: `v1.2.3`
- **Semantic tags**: `1.2.3`, `1.2`, `1`
- **Latest tag**: `latest` (for stable releases)
- **SHA tags**: `main-abcd1234` (for traceability)

### ⚡ **Performance Optimizations**
- Docker layer caching
- GitHub Actions cache integration
- Efficient multi-stage builds

### 📝 **Rich Metadata**
- Build date and version labels
- Source repository information
- Semantic versioning support
- Build summaries in GitHub Actions

## Docker Image Usage

### Pull and Run
```bash
# Latest version
docker run -it ghcr.io/nirgeier/bash-escaperoom:latest

# Specific version
docker run -it ghcr.io/nirgeier/bash-escaperoom:v1.0.0

# Specific platform
docker run --platform linux/amd64 -it ghcr.io/nirgeier/bash-escaperoom:latest
```

### Environment Variables
The Docker images support these build-time variables:
- `IMAGE`: The image name
- `IMAGE_TAG`: The image tag/version
- `BUILD_TIME`: GitHub Actions run ID
- `SourceRepository`: Source repository name
- `RELEASE_VERSION`: The release version

## Version Numbering

Follow [Semantic Versioning](https://semver.org/):

- **MAJOR** version: incompatible API changes
- **MINOR** version: backwards-compatible functionality
- **PATCH** version: backwards-compatible bug fixes
- **Pre-release**: `-alpha`, `-beta`, `-rc1`, etc.

Examples:
- `v1.0.0` - Initial release
- `v1.1.0` - New features added
- `v1.1.1` - Bug fixes
- `v2.0.0-beta` - Major version preview

## Troubleshooting

### Build Failures
1. Check GitHub Actions logs
2. Verify Dockerfile syntax
3. Ensure all required files are present in `/content`

### Permission Issues
1. Verify GitHub token has `packages: write` permission
2. Check repository settings for GitHub Packages

### Platform Issues
1. Use explicit platform: `docker run --platform linux/amd64 ...`
2. Check if both amd64 and arm64 variants were built successfully

## Manual Testing

Test the release workflow locally with `act`:

```bash
# Test release workflow (dry run)
act release --dryrun

# Test with specific tag
act push --dryrun -e <(echo '{"ref":"refs/tags/v1.0.0"}')
```
