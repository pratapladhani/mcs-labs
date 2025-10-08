# 🎮 Basic Lab Tracker - MVP

This is a minimal viable product (MVP) for gamifying the Copilot Studio labs experience. It focuses on the core loop of tracking lab completion and awarding XP points.

## ✨ Features

- **🏆 XP System**: Earn points for completing labs (100-300 XP based on difficulty)
- **📊 Progress Tracking**: Visual progress bars and completion statistics  
- **🎯 Level System**: Progress through Beginner → Intermediate → Advanced → Expert
- **💾 Local Storage**: Progress saved in browser (no external dependencies)
- **📱 Responsive**: Works on desktop and mobile devices
- **🔄 Reset Option**: Start over anytime

## 🎯 Current Labs & XP Values

| Lab | Level | Duration | XP Value |
|-----|-------|----------|----------|
| Web-based AI Assistant | 100 | 30 min | 100 XP |
| Enterprise Data Assistant | 100 | 45 min | 150 XP |
| ALM Best Practices | 200 | 40 min | 200 XP |
| Autonomous Agent with CUA | 300 | 30 min | 300 XP |
| Ask Me Anything Agent | 200 | 60 min | 250 XP |
| Autonomous Support Agent | 300 | 20 min | 300 XP |

**Total Available XP: 1,300**

## 🏅 Level System

- **Beginner** (0-499 XP) - Learning the basics
- **Intermediate** (500-1,199 XP) - Building expertise  
- **Advanced** (1,200-2,499 XP) - Mastering complex scenarios
- **Expert** (2,500+ XP) - Maximum level achieved

## 🚀 Quick Start

1. Open `simple-tracker.html` in any modern browser
2. Click "Mark Complete" on labs you've finished
3. Watch your XP and level progress!
4. Use the reset button to start over if needed

## 📱 How It Works

### Data Storage
- **Local Storage**: All progress stored in browser's localStorage
- **No External Dependencies**: Works completely offline
- **Privacy Friendly**: No data sent anywhere

### XP Calculation
```javascript
// XP awarded based on lab difficulty level
Level 100 labs: 100-150 XP
Level 200 labs: 200-250 XP  
Level 300 labs: 300 XP
```

### Progress Persistence
```javascript
// Data structure stored in localStorage
{
  totalXP: 450,
  completedLabs: ['agent-builder-web', 'setup-for-success'],
  completedAt: {
    'agent-builder-web': '2025-10-08T10:30:00.000Z',
    'setup-for-success': '2025-10-08T11:45:00.000Z'
  }
}
```

## 🔮 Future Enhancements

This MVP can be enhanced with:

- **Achievements/Badges**: Unlock rewards for specific milestones
- **Detailed Analytics**: Time tracking, completion patterns
- **Social Features**: Leaderboards, sharing progress
- **Advanced Challenges**: Speed runs, perfect scores
- **GitHub Integration**: Connect with repository activity

## 🛠️ Technical Details

- **Size**: ~15KB total (HTML + CSS + JS)
- **Dependencies**: None (vanilla JavaScript)
- **Browser Support**: Chrome 60+, Firefox 55+, Safari 12+, Edge 79+
- **Storage**: localStorage (5-10MB available)

## 🧪 Testing the MVP

1. **Complete a few labs** - Click the "Mark Complete" buttons
2. **Check XP gain** - Notice the XP notification in top-right
3. **Watch level progression** - Progress bar updates automatically
4. **Test persistence** - Refresh page, progress should remain
5. **Try reset** - Use reset button to clear all progress

This simple tracker provides immediate gamification value while being easy to deploy and maintain!