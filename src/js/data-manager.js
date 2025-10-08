// Data Manager - Handles all data storage and retrieval
class DataManager {
    constructor() {
        this.storagePrefix = 'copilot-labs-';
        this.userDataKey = 'userData';
        this.labsDataKey = 'labsData'; 
        this.achievementsDataKey = 'achievementsData';
        
        this.initializeUserData();
    }

    // ===== USER DATA MANAGEMENT =====
    
    initializeUserData() {
        const defaultUserData = {
            username: 'Anonymous Learner',
            githubUsername: null,
            totalXP: 0,
            currentLevel: 'Copilot Cadet',
            joinDate: new Date().toISOString(),
            lastActiveDate: new Date().toISOString(),
            consecutiveDays: 0,
            
            completedLabs: [],
            earnedAchievements: [],
            currentStreak: 0,
            labProgress: {},
            
            stats: {
                labsCompleted: 0,
                badgesEarned: 0,
                speedBonuses: 0,
                perfectScores: 0,
                creativityBonuses: 0,
                communityActions: 0,
                connectorsUsed: [],
                bonusesCompleted: 0
            },
            
            preferences: {
                theme: 'auto',
                notifications: true,
                publicProfile: false
            }
        };

        const existingData = this.getUserData();
        if (!existingData) {
            this.setUserData(defaultUserData);
        } else {
            // Update last active date
            existingData.lastActiveDate = new Date().toISOString();
            this.updateConsecutiveDays(existingData);
            this.setUserData(existingData);
        }
    }

    getUserData() {
        const data = localStorage.getItem(this.storagePrefix + this.userDataKey);
        return data ? JSON.parse(data) : null;
    }

    setUserData(userData) {
        localStorage.setItem(this.storagePrefix + this.userDataKey, JSON.stringify(userData));
        this.dispatchDataUpdate('userData', userData);
    }

    updateUserData(updates) {
        const userData = this.getUserData();
        const updatedData = { ...userData, ...updates };
        this.setUserData(updatedData);
        return updatedData;
    }

    // ===== XP AND LEVEL MANAGEMENT =====
    
    addXP(amount, source = 'unknown') {
        const userData = this.getUserData();
        userData.totalXP += amount;
        
        // Check for level up
        const newLevel = this.calculateLevel(userData.totalXP);
        const leveledUp = newLevel !== userData.currentLevel;
        
        if (leveledUp) {
            userData.currentLevel = newLevel;
            this.dispatchLevelUp(newLevel, userData.totalXP);
        }
        
        this.setUserData(userData);
        this.dispatchXPGain(amount, source, leveledUp);
        
        return { leveledUp, newLevel, totalXP: userData.totalXP };
    }

    calculateLevel(totalXP) {
        if (totalXP < 500) return 'Copilot Cadet';
        if (totalXP < 1500) return 'Agent Architect';
        if (totalXP < 3000) return 'Automation Expert';
        return 'AI Innovation Leader';
    }

    getLevelProgress(totalXP) {
        let currentThreshold = 0;
        let nextThreshold = 500;
        
        if (totalXP >= 500 && totalXP < 1500) {
            currentThreshold = 500;
            nextThreshold = 1500;
        } else if (totalXP >= 1500 && totalXP < 3000) {
            currentThreshold = 1500;
            nextThreshold = 3000;
        } else if (totalXP >= 3000) {
            currentThreshold = 3000;
            nextThreshold = 5000; // Future expansion
        }
        
        const progress = ((totalXP - currentThreshold) / (nextThreshold - currentThreshold)) * 100;
        return {
            current: totalXP - currentThreshold,
            needed: nextThreshold - currentThreshold,
            progress: Math.min(progress, 100),
            nextThreshold
        };
    }

    // ===== LAB PROGRESS MANAGEMENT =====
    
    markLabCompleted(labId, completionData = {}) {
        const userData = this.getUserData();
        
        if (!userData.completedLabs.includes(labId)) {
            userData.completedLabs.push(labId);
            userData.stats.labsCompleted++;
            
            // Record completion details
            userData.labProgress[labId] = {
                completedAt: new Date().toISOString(),
                timeTaken: completionData.timeTaken || null,
                score: completionData.score || null,
                bonusesEarned: completionData.bonusesEarned || [],
                ...completionData
            };
            
            this.setUserData(userData);
            this.checkAchievements(labId);
            this.dispatchLabCompleted(labId, completionData);
            
            return true;
        }
        
        return false;
    }

    getLabProgress(labId) {
        const userData = this.getUserData();
        return userData.labProgress[labId] || null;
    }

    isLabCompleted(labId) {
        const userData = this.getUserData();
        return userData.completedLabs.includes(labId);
    }

    // ===== ACHIEVEMENT MANAGEMENT =====
    
    async checkAchievements(triggeredByLab = null) {
        const userData = this.getUserData();
        const achievements = await this.loadAchievementsData();
        const newAchievements = [];

        for (const achievement of achievements.achievements) {
            if (userData.earnedAchievements.includes(achievement.id)) {
                continue; // Already earned
            }

            if (this.meetsAchievementRequirements(achievement, userData)) {
                this.unlockAchievement(achievement.id);
                newAchievements.push(achievement);
            }
        }

        return newAchievements;
    }

    meetsAchievementRequirements(achievement, userData) {
        const req = achievement.requirements;
        
        switch (req.type) {
            case 'labsCompleted':
                if (req.tags) {
                    // Count labs with specific tags
                    // This would need lab data to check tags
                    return userData.stats.labsCompleted >= req.count;
                }
                return userData.stats.labsCompleted >= req.count;
                
            case 'totalXP':
                return userData.totalXP >= req.amount;
                
            case 'speedBonuses':
                return userData.stats.speedBonuses >= req.count;
                
            case 'perfectScores':
                return userData.stats.perfectScores >= req.count;
                
            case 'consecutiveDays':
                return userData.consecutiveDays >= req.count;
                
            case 'connectorsUsed':
                return userData.stats.connectorsUsed.length >= req.count;
                
            case 'manual':
                return false; // Manually awarded achievements
                
            default:
                return false;
        }
    }

    unlockAchievement(achievementId) {
        const userData = this.getUserData();
        
        if (!userData.earnedAchievements.includes(achievementId)) {
            userData.earnedAchievements.push(achievementId);
            userData.stats.badgesEarned++;
            this.setUserData(userData);
            
            // Find achievement data for XP reward
            this.loadAchievementsData().then(achievementsData => {
                const achievement = achievementsData.achievements.find(a => a.id === achievementId);
                if (achievement) {
                    this.addXP(achievement.xpReward, `achievement:${achievementId}`);
                    this.dispatchAchievementUnlocked(achievement);
                }
            });
        }
    }

    // ===== CONSECUTIVE DAYS TRACKING =====
    
    updateConsecutiveDays(userData) {
        const today = new Date().toDateString();
        const lastActive = new Date(userData.lastActiveDate).toDateString();
        const yesterday = new Date(Date.now() - 24 * 60 * 60 * 1000).toDateString();
        
        if (lastActive === today) {
            // Same day, no change
            return;
        } else if (lastActive === yesterday) {
            // Consecutive day
            userData.consecutiveDays++;
        } else {
            // Streak broken
            userData.consecutiveDays = 1;
        }
        
        userData.currentStreak = userData.consecutiveDays;
    }

    // ===== DATA LOADING =====
    
    async loadLabsData() {
        try {
            const response = await fetch('./data/labs.json');
            const data = await response.json();
            localStorage.setItem(this.storagePrefix + this.labsDataKey, JSON.stringify(data));
            return data;
        } catch (error) {
            console.error('Error loading labs data:', error);
            // Return cached data if available
            const cached = localStorage.getItem(this.storagePrefix + this.labsDataKey);
            return cached ? JSON.parse(cached) : { labs: [], learningPaths: {} };
        }
    }

    async loadAchievementsData() {
        try {
            const response = await fetch('./data/achievements.json');
            const data = await response.json();
            localStorage.setItem(this.storagePrefix + this.achievementsDataKey, JSON.stringify(data));
            return data;
        } catch (error) {
            console.error('Error loading achievements data:', error);
            const cached = localStorage.getItem(this.storagePrefix + this.achievementsDataKey);
            return cached ? JSON.parse(cached) : { achievements: [] };
        }
    }

    // ===== GITHUB INTEGRATION =====
    
    async connectGitHub(username) {
        try {
            const response = await fetch(`https://api.github.com/users/${username}`);
            if (response.ok) {
                const githubData = await response.json();
                this.updateUserData({
                    githubUsername: username,
                    username: githubData.name || githubData.login,
                    avatarUrl: githubData.avatar_url
                });
                return true;
            }
        } catch (error) {
            console.error('GitHub connection error:', error);
        }
        return false;
    }

    async getGitHubContributions(username) {
        // This would require additional API or service
        // For now, return mock data
        return {
            totalContributions: 0,
            currentStreak: 0,
            repositories: []
        };
    }

    // ===== EVENT DISPATCHING =====
    
    dispatchDataUpdate(type, data) {
        window.dispatchEvent(new CustomEvent('dataUpdate', { 
            detail: { type, data } 
        }));
    }

    dispatchXPGain(amount, source, leveledUp) {
        window.dispatchEvent(new CustomEvent('xpGain', { 
            detail: { amount, source, leveledUp } 
        }));
    }

    dispatchLevelUp(newLevel, totalXP) {
        window.dispatchEvent(new CustomEvent('levelUp', { 
            detail: { newLevel, totalXP } 
        }));
    }

    dispatchLabCompleted(labId, data) {
        window.dispatchEvent(new CustomEvent('labCompleted', { 
            detail: { labId, data } 
        }));
    }

    dispatchAchievementUnlocked(achievement) {
        window.dispatchEvent(new CustomEvent('achievementUnlocked', { 
            detail: { achievement } 
        }));
    }

    // ===== EXPORT/IMPORT =====
    
    exportUserData() {
        const userData = this.getUserData();
        const exportData = {
            ...userData,
            exportedAt: new Date().toISOString(),
            version: '1.0'
        };
        
        const blob = new Blob([JSON.stringify(exportData, null, 2)], { 
            type: 'application/json' 
        });
        
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `copilot-labs-progress-${new Date().toISOString().split('T')[0]}.json`;
        a.click();
        URL.revokeObjectURL(url);
    }

    importUserData(jsonData) {
        try {
            const importedData = JSON.parse(jsonData);
            if (importedData.version && importedData.totalXP !== undefined) {
                this.setUserData(importedData);
                return true;
            }
        } catch (error) {
            console.error('Import error:', error);
        }
        return false;
    }

    // ===== RESET =====
    
    resetAllData() {
        if (confirm('Are you sure you want to reset all progress? This cannot be undone.')) {
            localStorage.removeItem(this.storagePrefix + this.userDataKey);
            this.initializeUserData();
            window.location.reload();
        }
    }
}

// Export for use in other modules
window.DataManager = DataManager;