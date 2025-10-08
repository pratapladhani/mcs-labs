// =============================================================================
// COPILOT STUDIO LABS - GAMIFICATION DATA STORAGE ARCHITECTURE
// =============================================================================
// This file outlines our hybrid data storage strategy for GitHub Pages

const CONFIG = {
    // =============================================================================
    // DATA STORAGE LAYERS
    // =============================================================================
    
    storage: {
        // LAYER 1: Static Configuration Data (Repository JSON files)
        static: {
            location: './data/',
            files: {
                'labs.json': 'Lab metadata, XP values, learning paths',
                'achievements.json': 'Achievement definitions and requirements', 
                'challenges.json': 'Special challenges and events',
                'leaderboard.json': 'Sample leaderboard data for development'
            },
            updateFrequency: 'On repository updates',
            caching: 'localStorage with version checking'
        },
        
        // LAYER 2: User Progress Data (Client-side localStorage)
        client: {
            location: 'localStorage',
            prefix: 'copilot-labs-',
            data: {
                'userData': 'Personal progress, XP, achievements',
                'preferences': 'UI settings, theme, notifications',
                'labProgress': 'Completion status, scores, timestamps',
                'tempData': 'Session-specific data'
            },
            persistence: 'Permanent (until user clears browser data)',
            backup: 'Export/import JSON functionality'
        },
        
        // LAYER 3: Community Data (GitHub API integration)  
        github: {
            endpoints: {
                user: 'https://api.github.com/users/{username}',
                repos: 'https://api.github.com/repos/{owner}/{repo}',
                contributions: 'Custom service or GitHub GraphQL',
                activity: 'https://api.github.com/users/{username}/events'
            },
            rateLimits: '60 requests/hour (unauthenticated)',
            caching: '30 minutes for user data, 5 minutes for activity'
        }
    },

    // =============================================================================
    // GAMIFICATION MECHANICS
    // =============================================================================
    
    gamification: {
        xp: {
            labCompletion: {
                level100: 100,
                level200: 200, 
                level300: 300
            },
            bonuses: {
                speedBonus: 50,      // Complete under target time
                perfectScore: 25,    // Zero errors
                creativity: 75,      // Custom implementations
                helping: 25,         // Community assistance
                innovation: 200      // Exceptional solutions
            },
            achievements: {
                common: 50,
                uncommon: 100,
                rare: 200,
                epic: 350,
                legendary: 500
            }
        },
        
        levels: {
            thresholds: [
                { name: 'Copilot Cadet', min: 0, max: 499, color: '#4CAF50' },
                { name: 'Agent Architect', min: 500, max: 1499, color: '#2196F3' },
                { name: 'Automation Expert', min: 1500, max: 2999, color: '#FF9800' },
                { name: 'AI Innovation Leader', min: 3000, max: Infinity, color: '#9C27B0' }
            ]
        },

        streaks: {
            dailyBonus: 10,      // XP for consecutive days
            weeklyBonus: 100,    // XP for 7-day streak
            monthlyBonus: 500    // XP for 30-day streak
        }
    },

    // =============================================================================
    // PRIVACY AND DATA HANDLING
    // =============================================================================
    
    privacy: {
        dataCollection: {
            personal: 'Only what user explicitly provides',
            tracking: 'Local progress only, no external analytics',
            sharing: 'Opt-in for public leaderboards'
        },
        
        storage: {
            location: 'User\'s browser localStorage only',
            duration: 'Until user clears browser data',
            deletion: 'Full reset option available',
            export: 'JSON export for data portability'
        },
        
        github: {
            permissions: 'Read-only public profile data',
            optional: 'GitHub connection is completely optional',
            revocable: 'User can disconnect anytime'
        }
    },

    // =============================================================================
    // TECHNICAL IMPLEMENTATION
    // =============================================================================
    
    technical: {
        compatibility: {
            browsers: ['Chrome 80+', 'Firefox 75+', 'Safari 13+', 'Edge 80+'],
            storage: 'localStorage (5-10MB limit)',
            fallback: 'Graceful degradation without localStorage'
        },
        
        performance: {
            bundleSize: '<100KB total JavaScript',
            loadTime: '<2s on 3G connection',
            caching: 'Aggressive caching of static data',
            lazy: 'Lazy load non-critical features'
        },
        
        security: {
            xss: 'Content Security Policy headers',
            data: 'No sensitive data storage',
            apis: 'Rate limiting on GitHub API calls',
            validation: 'Input sanitization and validation'
        }
    },

    // =============================================================================
    // DEPLOYMENT STRATEGY
    // =============================================================================
    
    deployment: {
        hosting: 'GitHub Pages',
        domain: 'Custom domain support available',
        ssl: 'Automatic HTTPS',
        cdn: 'GitHub\'s global CDN',
        
        cicd: {
            trigger: 'Push to main branch',
            build: 'Automated via GitHub Actions',
            deployment: 'Automatic to gh-pages branch',
            rollback: 'Git-based version control'
        },
        
        monitoring: {
            uptime: 'GitHub Pages SLA',
            errors: 'Console logging for development',
            performance: 'Lighthouse CI integration',
            usage: 'Optional privacy-friendly analytics'
        }
    },

    // =============================================================================
    // FUTURE ENHANCEMENTS
    // =============================================================================
    
    roadmap: {
        phase1: {
            features: ['Basic XP/Achievement system', 'Lab progress tracking'],
            timeline: 'Week 1-2',
            storage: 'localStorage only'
        },
        
        phase2: {
            features: ['GitHub integration', 'Community leaderboards'],
            timeline: 'Week 3-4', 
            storage: 'localStorage + GitHub API'
        },
        
        phase3: {
            features: ['Advanced challenges', 'Team competitions'],
            timeline: 'Month 2',
            storage: 'Consider external service integration'
        },
        
        advanced: {
            features: ['Real-time collaboration', 'Mentorship matching'],
            timeline: 'Future consideration',
            storage: 'May require backend service'
        }
    }
};

// =============================================================================
// DATA FLOW DIAGRAM
// =============================================================================
/*

    📊 STATIC DATA (Repository)
           ↓ (fetch on load)
    🌐 GITHUB PAGES APP  
           ↓ (user interactions)
    💾 LOCALSTORAGE (Browser)
           ↓ (optional connection)
    🐙 GITHUB API (Community)
           ↓ (aggregation)
    📈 LEADERBOARDS & SOCIAL

    Data Flow:
    1. App loads static configuration from JSON files
    2. User progress stored locally in browser
    3. Optional GitHub integration for community features
    4. Real-time leaderboards generated from public data
    5. Export/import for data portability

*/

// Export configuration
window.CONFIG = CONFIG;