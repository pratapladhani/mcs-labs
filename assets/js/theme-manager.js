/* ============================================================================
   Theme Configuration and Loader
   
   This file defines available themes and provides the theme loading system.
   ============================================================================ */

window.ThemeManager = (function() {
    const THEMES = {
        'rich-light': {
            name: 'Rich Light',
            file: '/assets/css/themes/theme-rich.css',
            dataTheme: 'light',
            icon: '🎨',
            description: 'Colorful, engaging design with gradients and rich colors'
        },
        'rich-dark': {
            name: 'Rich Dark',
            file: '/assets/css/themes/theme-rich.css',
            dataTheme: 'dark',
            icon: '🌙',
            description: 'Dark mode with vibrant colors and rich design elements'
        },
        'minimal': {
            name: 'Minimal',
            file: '/assets/css/themes/theme-minimal.css',
            dataTheme: 'minimal',
            icon: '📄',
            description: 'Clean, minimal blog-style design focused on content'
        }
    };

    const DEFAULT_THEME = 'rich-light';
    let currentTheme = DEFAULT_THEME;
    let loadedThemeLink = null;

    // Get theme preference from localStorage
    function getStoredTheme() {
        return localStorage.getItem('theme') || DEFAULT_THEME;
    }

    // Store theme preference in localStorage
    function storeTheme(themeId) {
        localStorage.setItem('theme', themeId);
    }

    // Load theme CSS file
    function loadThemeCSS(themePath) {
        return new Promise((resolve, reject) => {
            // Remove existing theme CSS if present
            if (loadedThemeLink) {
                loadedThemeLink.remove();
                loadedThemeLink = null;
            }

            // Create and load new theme CSS
            const link = document.createElement('link');
            link.rel = 'stylesheet';
            link.href = themePath;
            link.onload = () => {
                loadedThemeLink = link;
                resolve();
            };
            link.onerror = reject;
            
            // Insert before the main stylesheet to allow overrides
            const mainStylesheet = document.querySelector('link[href*="style.css"]');
            if (mainStylesheet) {
                mainStylesheet.parentNode.insertBefore(link, mainStylesheet.nextSibling);
            } else {
                document.head.appendChild(link);
            }
        });
    }

    // Apply theme
    async function applyTheme(themeId) {
        const theme = THEMES[themeId];
        if (!theme) {
            console.warn(`Theme "${themeId}" not found, falling back to default`);
            themeId = DEFAULT_THEME;
        }

        try {
            // Load theme CSS
            await loadThemeCSS(theme.file);
            
            // Set data-theme attribute
            document.documentElement.setAttribute('data-theme', theme.dataTheme);
            
            // Update current theme
            currentTheme = themeId;
            
            // Store preference
            storeTheme(themeId);
            
            // Dispatch theme change event
            window.dispatchEvent(new CustomEvent('themeChanged', {
                detail: { themeId, theme }
            }));
            
            return true;
        } catch (error) {
            console.error(`Failed to load theme "${themeId}":`, error);
            return false;
        }
    }

    // Get next theme in cycle
    function getNextTheme() {
        const themeIds = Object.keys(THEMES);
        const currentIndex = themeIds.indexOf(currentTheme);
        const nextIndex = (currentIndex + 1) % themeIds.length;
        return themeIds[nextIndex];
    }

    // Initialize theme system
    function init() {
        const savedTheme = getStoredTheme();
        applyTheme(savedTheme);
    }

    // Public API
    return {
        themes: THEMES,
        getCurrentTheme: () => currentTheme,
        getCurrentThemeInfo: () => THEMES[currentTheme],
        applyTheme,
        cycleTheme: () => applyTheme(getNextTheme()),
        init,
        
        // Backward compatibility
        get: getStoredTheme,
        set: applyTheme,
        toggle: () => applyTheme(getNextTheme())
    };
})();