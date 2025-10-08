// Lab Completion Widget - Embeddable JavaScript for individual labs
// This script creates a completion button and integrates with the central tracking system

class LabCompletionWidget {
    constructor(labId, labTitle, xpValue, level = 100) {
        this.labId = labId;
        this.labTitle = labTitle;
        this.xpValue = xpValue;
        this.level = level;
        this.storageKey = 'copilot-labs-progress';
        
        this.init();
    }

    init() {
        this.createWidget();
        this.updateUI();
        this.loadGlobalStats();
    }

    createWidget() {
        // Create the completion widget HTML
        const widgetHTML = `
            <div id="lab-completion-widget" style="
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 25px;
                border-radius: 15px;
                margin: 30px 0;
                box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                position: relative;
                overflow: hidden;
            ">
                <div style="position: relative; z-index: 2;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                        <div>
                            <h3 style="margin: 0 0 5px 0; font-size: 1.3rem;">🎯 Lab Completion</h3>
                            <p style="margin: 0; opacity: 0.9; font-size: 0.95rem;">${this.labTitle}</p>
                        </div>
                        <div style="text-align: right;">
                            <div style="background: rgba(255,255,255,0.2); padding: 8px 12px; border-radius: 20px; font-size: 0.9rem;">
                                <strong>+${this.xpValue} XP</strong>
                            </div>
                            <div style="font-size: 0.8rem; opacity: 0.8; margin-top: 5px;">Level ${this.level}</div>
                        </div>
                    </div>
                    
                    <div id="completion-status" style="margin-bottom: 20px;">
                        <!-- Status will be populated by JavaScript -->
                    </div>
                    
                    <button id="completion-btn" style="
                        width: 100%;
                        padding: 15px;
                        border: none;
                        border-radius: 10px;
                        font-size: 1.1rem;
                        font-weight: bold;
                        cursor: pointer;
                        transition: all 0.3s ease;
                        background: rgba(255,255,255,0.2);
                        color: white;
                        border: 2px solid rgba(255,255,255,0.3);
                    " onmouseover="this.style.background='rgba(255,255,255,0.3)'; this.style.transform='translateY(-2px)'" 
                       onmouseout="this.style.background='rgba(255,255,255,0.2)'; this.style.transform='translateY(0)'">
                        <!-- Button text will be set by JavaScript -->
                    </button>
                    
                    <div id="user-stats" style="
                        display: grid;
                        grid-template-columns: repeat(3, 1fr);
                        gap: 15px;
                        margin-top: 20px;
                        padding-top: 20px;
                        border-top: 1px solid rgba(255,255,255,0.2);
                        font-size: 0.9rem;
                    ">
                        <div style="text-align: center;">
                            <div id="total-xp" style="font-size: 1.3rem; font-weight: bold;">0</div>
                            <div style="opacity: 0.8;">Total XP</div>
                        </div>
                        <div style="text-align: center;">
                            <div id="completed-count" style="font-size: 1.3rem; font-weight: bold;">0</div>
                            <div style="opacity: 0.8;">Completed</div>
                        </div>
                        <div style="text-align: center;">
                            <div id="current-level" style="font-size: 1.3rem; font-weight: bold;">Beginner</div>
                            <div style="opacity: 0.8;">Level</div>
                        </div>
                    </div>
                </div>
                
                <!-- Decorative background pattern -->
                <div style="position: absolute; top: -50%; right: -20%; width: 200px; height: 200px; background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%); border-radius: 50%;"></div>
                <div style="position: absolute; bottom: -30%; left: -10%; width: 150px; height: 150px; background: radial-gradient(circle, rgba(255,255,255,0.05) 0%, transparent 70%); border-radius: 50%;"></div>
            </div>
            
            <!-- Success notification -->
            <div id="success-notification" style="
                position: fixed;
                top: 20px;
                right: 20px;
                background: linear-gradient(45deg, #4CAF50, #45a049);
                color: white;
                padding: 15px 20px;
                border-radius: 10px;
                box-shadow: 0 4px 20px rgba(76, 175, 80, 0.3);
                transform: translateX(400px);
                transition: transform 0.3s ease;
                z-index: 1000;
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                font-weight: bold;
            ">
                <div id="notification-message">🎉 +${this.xpValue} XP earned!</div>
            </div>
        `;

        // Insert the widget at the end of the document
        document.body.insertAdjacentHTML('beforeend', widgetHTML);
        
        // Add event listener to the completion button
        document.getElementById('completion-btn').addEventListener('click', () => {
            this.toggleCompletion();
        });
    }

    updateUI() {
        const progress = this.getProgress();
        const isCompleted = progress.completedLabs.includes(this.labId);
        
        // Update completion status
        const statusDiv = document.getElementById('completion-status');
        const buttonElement = document.getElementById('completion-btn');
        
        if (isCompleted) {
            const completedDate = new Date(progress.completedAt[this.labId]).toLocaleDateString();
            statusDiv.innerHTML = `
                <div style="display: flex; align-items: center; background: rgba(76, 175, 80, 0.2); padding: 12px; border-radius: 8px; border: 1px solid rgba(76, 175, 80, 0.3);">
                    <span style="font-size: 1.5rem; margin-right: 10px;">✅</span>
                    <div>
                        <div style="font-weight: bold;">Completed!</div>
                        <div style="font-size: 0.85rem; opacity: 0.9;">Finished on ${completedDate}</div>
                    </div>
                </div>
            `;
            buttonElement.innerHTML = '✓ Mark as Incomplete';
            buttonElement.style.background = 'rgba(76, 175, 80, 0.3)';
            buttonElement.style.borderColor = 'rgba(76, 175, 80, 0.5)';
        } else {
            statusDiv.innerHTML = `
                <div style="display: flex; align-items: center; background: rgba(255, 255, 255, 0.1); padding: 12px; border-radius: 8px; border: 1px solid rgba(255, 255, 255, 0.2);">
                    <span style="font-size: 1.5rem; margin-right: 10px;">⏳</span>
                    <div>
                        <div style="font-weight: bold;">Ready to complete?</div>
                        <div style="font-size: 0.85rem; opacity: 0.9;">Mark this lab as finished to earn ${this.xpValue} XP</div>
                    </div>
                </div>
            `;
            buttonElement.innerHTML = '🚀 Mark Lab Complete';
            buttonElement.style.background = 'rgba(255,255,255,0.2)';
            buttonElement.style.borderColor = 'rgba(255,255,255,0.3)';
        }
    }

    loadGlobalStats() {
        const progress = this.getProgress();
        
        // Update global stats in the widget
        document.getElementById('total-xp').textContent = progress.totalXP;
        document.getElementById('completed-count').textContent = progress.completedLabs.length;
        document.getElementById('current-level').textContent = this.calculateLevel(progress.totalXP);
    }

    toggleCompletion() {
        const progress = this.getProgress();
        const isCompleted = progress.completedLabs.includes(this.labId);
        
        if (isCompleted) {
            // Remove completion
            progress.completedLabs = progress.completedLabs.filter(id => id !== this.labId);
            progress.totalXP -= this.xpValue;
            delete progress.completedAt[this.labId];
            this.showNotification(`-${this.xpValue} XP - Lab marked incomplete`);
        } else {
            // Add completion
            progress.completedLabs.push(this.labId);
            progress.totalXP += this.xpValue;
            progress.completedAt[this.labId] = new Date().toISOString();
            this.showNotification(`🎉 +${this.xpValue} XP - Lab completed!`);
        }
        
        this.saveProgress(progress);
        this.updateUI();
        this.loadGlobalStats();
    }

    showNotification(message) {
        const notification = document.getElementById('success-notification');
        const messageDiv = document.getElementById('notification-message');
        
        messageDiv.textContent = message;
        notification.style.transform = 'translateX(0)';
        
        setTimeout(() => {
            notification.style.transform = 'translateX(400px)';
        }, 3000);
    }

    getProgress() {
        const saved = localStorage.getItem(this.storageKey);
        if (saved) {
            return JSON.parse(saved);
        }
        return {
            totalXP: 0,
            completedLabs: [],
            completedAt: {}
        };
    }

    saveProgress(progress) {
        localStorage.setItem(this.storageKey, JSON.stringify(progress));
    }

    calculateLevel(totalXP) {
        if (totalXP < 500) return 'Beginner';
        if (totalXP < 1200) return 'Intermediate';
        if (totalXP < 2500) return 'Advanced';
        return 'Expert';
    }
}

// Auto-initialize if lab data is provided via meta tags or global variables
document.addEventListener('DOMContentLoaded', function() {
    // Check for lab metadata in meta tags
    const labIdMeta = document.querySelector('meta[name="lab-id"]');
    const labTitleMeta = document.querySelector('meta[name="lab-title"]');
    const labXpMeta = document.querySelector('meta[name="lab-xp"]');
    const labLevelMeta = document.querySelector('meta[name="lab-level"]');
    
    if (labIdMeta && labTitleMeta && labXpMeta) {
        new LabCompletionWidget(
            labIdMeta.content,
            labTitleMeta.content,
            parseInt(labXpMeta.content),
            parseInt(labLevelMeta?.content || 100)
        );
    }
    
    // Or check for global configuration
    if (typeof window.LAB_CONFIG !== 'undefined') {
        new LabCompletionWidget(
            window.LAB_CONFIG.id,
            window.LAB_CONFIG.title,
            window.LAB_CONFIG.xp,
            window.LAB_CONFIG.level
        );
    }
});

// Export for manual initialization
window.LabCompletionWidget = LabCompletionWidget;