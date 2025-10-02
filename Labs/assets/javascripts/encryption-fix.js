// Fix for mkdocs-encryptcontent-plugin content display issues
// This script helps ensure content appears after successful decryption

document.addEventListener('DOMContentLoaded', function() {
    // Monitor for password form submissions
    const observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            if (mutation.type === 'childList') {
                // Check if encrypted content container is present
                const encryptedDiv = document.querySelector('.mkdocs-encrypted-content');
                if (encryptedDiv && encryptedDiv.style.display === 'none') {
                    // Content should be visible after decryption
                    setTimeout(function() {
                        const content = document.querySelector('.mkdocs-decrypted-content, .md-content__inner');
                        if (content) {
                            content.style.display = 'block';
                            content.style.visibility = 'visible';
                        }
                    }, 500);
                }
            }
        });
    });

    // Start observing
    observer.observe(document.body, {
        childList: true,
        subtree: true
    });

    // Also add a click handler for password buttons
    document.addEventListener('click', function(e) {
        if (e.target && (e.target.id === 'mkdocs-decrypt-button' || e.target.classList.contains('decrypt-button'))) {
            setTimeout(function() {
                // Force refresh if content doesn't appear within 2 seconds
                const encryptedContent = document.querySelector('.mkdocs-encrypted-content');
                if (encryptedContent && encryptedContent.style.display !== 'none') {
                    console.log('Content not decrypted, consider refreshing the page');
                }
            }, 2000);
        }
    });
});
