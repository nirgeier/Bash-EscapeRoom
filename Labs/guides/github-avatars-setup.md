# GitHub Avatars Setup Guide

This guide explains how to add GitHub avatars of committers to your MkDocs site.

## Overview

The GitHub avatars feature displays profile pictures of contributors who have committed changes to each page in your documentation. This helps readers see who has worked on specific content.

## Current Setup

Your MkDocs site is already configured with GitHub avatars! Here's what's implemented:

### 1. Plugin Configuration

In your `mkdocs.yml`, the `git-committers` plugin is configured:

```yaml
plugins:
  - git-committers:
      branch: main
      docs_path: Labs # set if your docs folder is not root
      enabled: true
      repository: nirgeier/mkdocs
```

### 2. Template Integration

The `overrides/partials/source-file.html` template includes the `render_committers` macro that:

- Shows up to 4 GitHub avatars per page
- Displays a "+X" indicator for additional contributors
- Links avatars to contributor GitHub profiles
- Shows tooltips with GitHub usernames

### 3. CSS Styling

Custom CSS styles in `Labs/assets/stylesheets/theme.css` provide:

- Circular avatar styling
- Hover effects with scaling
- Dark/light mode support
- Responsive design for mobile devices
- Tooltip functionality

## Features

### Avatar Display

- **Circular avatars**: 1.6rem (25.6px) diameter by default
- **Hover effects**: Slight scale animation on hover
- **Tooltips**: Show GitHub username on hover
- **Responsive**: Smaller on mobile devices

### GitHub Integration

- **Auto-fetching**: Automatically fetches contributor data from GitHub
- **Rate limiting**: Handles GitHub API rate limits gracefully
- **Caching**: Caches avatar data for performance

### Customization Options

- **Size variants**: Support for larger avatars with `.md-source-file--large` class
- **Color themes**: Automatic adaptation to light/dark themes
- **Border styling**: Subtle borders that adapt to the theme

## Advanced Configuration

### Adding GitHub Token

To avoid API rate limits, you can add a GitHub token:

1. **In mkdocs.yml:**

```yaml
plugins:
  - git-committers:
      token: your_github_token_here
      # ... other config
```

2. **Or as environment variable:**

```bash
export MKDOCS_GIT_COMMITTERS_APIKEY=your_github_token_here
```

### Customizing Avatar Count

To show more than 4 avatars, modify the template in `overrides/partials/source-file.html`:

```jinja2
{% for author in authors[:6] %}  <!-- Change 4 to 6 for more avatars -->
```

### Custom Avatar Sizes

Add these CSS classes to customize avatar sizes:

```css
/* Large avatars for important pages */
.md-source-file--large .md-author {
  height: 3rem;
  width: 3rem;
}

/* Small avatars for compact layouts */
.md-source-file--compact .md-author {
  height: 1.2rem;
  width: 1.2rem;
}
```

## Troubleshooting

### Avatars Not Showing

1. **Check plugin status**: Look for "git-committers plugin ENABLED" in build output
2. **Verify repository**: Ensure the repository name in config matches GitHub
3. **Check branch**: Verify the branch name is correct
4. **API limits**: Add a GitHub token if you see rate limit warnings

### Styling Issues

1. **CSS not loading**: Verify `extra_css` path in mkdocs.yml
2. **Dark mode**: Check that dark mode styles are defined
3. **Mobile display**: Test responsive behavior on different screen sizes

## Example Output

When working correctly, you'll see:

- Small circular avatars at the bottom of each page
- Hover effects when mousing over avatars
- Clickable links to contributor profiles
- Proper scaling on different devices

## Next Steps

1. **Test the setup**: Visit your site and check avatar display
2. **Add GitHub token**: To avoid API rate limits
3. **Customize styling**: Adjust sizes and colors to match your theme
4. **Monitor performance**: Check build times and API usage

The GitHub avatars feature is now active on your site and will automatically display contributor information for all pages in your documentation!
