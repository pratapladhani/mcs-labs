# 🚀 GitHub Deployment Strategy

## 📋 **Overview**
This document outlines how to safely test the new Jekyll Journey System on GitHub while preserving your ability to rollback to the current lab portal system.

## 🏗️ **Architecture Options**

GitHub Pages gives you **one URL per repository**. Here are your realistic options:

### **Option A: Branch Switching (Safest)**
- **Current**: `main` branch → `https://username.github.io/mcs-labs` (lab portal)
- **Testing**: Switch GitHub Pages source to `jekyll-lab-browser` branch
- **Same URL, different system based on active branch**

### **Option B: Subdirectory Deployment**
- **Main**: `https://username.github.io/mcs-labs/` (lab portal)
- **Jekyll**: `https://username.github.io/mcs-labs/jekyll/` (journey system)
- **Both systems live at same time, different paths**

### **Option C: Two Repositories**
- **Current**: `https://username.github.io/mcs-labs` (this repo)
- **Jekyll**: `https://username.github.io/mcs-labs-jekyll` (new repo)
- **Completely separate systems**

## 🛡️ **Safety Features**

✅ **Branch Isolation**: Each system deploys from different branches  
✅ **URL Separation**: Different URLs prevent conflicts  
✅ **Automatic Rollback**: Switch branches to change active system  
✅ **Preserved Work**: All your Jekyll work stays safe  

## 🚀 **Deployment Steps**

### **Step 1: Push to GitHub**
```powershell
# Ensure you're on the jekyll-lab-browser branch
git checkout jekyll-lab-browser

# Push your Jekyll system
git add .
git commit -m "🎮 Add gamified Jekyll journey system"
git push origin jekyll-lab-browser
```

### **Step 2: Watch Deployment**
1. Go to **Actions** tab in GitHub
2. Look for "🚀 Deploy Jekyll Journey System" workflow
3. Monitor the deployment progress

### **Step 3: Test Your System**
- **Jekyll Preview**: `https://yourusername.github.io/mcs-labs-jekyll`
- **Main System**: `https://yourusername.github.io/mcs-labs` *(unchanged)*

## 🔄 **Rollback Options**

### **Option 1: Branch Switch (Instant)**
```powershell
# Rollback to main system
git checkout main

# Or use the rollback script
.\rollback-to-main.ps1 -Execute
```

### **Option 2: Keep Both Systems**
- Main system: `main` branch → production URL
- Jekyll system: `jekyll-lab-browser` branch → preview URL
- Test both systems in parallel!

## 🎯 **Migration Plan (Future)**

When you're ready to make Jekyll the main system:

1. **Test thoroughly** on preview URL
2. **Backup main branch**: `git checkout -b backup-main-system`
3. **Merge Jekyll to main**: 
   ```powershell
   git checkout main
   git merge jekyll-lab-browser
   git push origin main
   ```

## 🆘 **Emergency Procedures**

### **If Jekyll Deployment Breaks**
```powershell
# Quick rollback to working system
git checkout main
# Main system is still working!
```

### **If You Need to Disable Jekyll Workflow**
1. Go to `.github/workflows/deploy-jekyll-labs.yml`
2. Add `# ` at the start of the `on:` section to comment it out

### **Complete Reset to Main System**
```powershell
# Delete Jekyll branch (DANGER: You'll lose Jekyll work!)
git checkout main
git branch -D jekyll-lab-browser
git push origin --delete jekyll-lab-browser
```

## 🎮 **Expected Outcomes**

### **After Deployment**
- ✅ Jekyll system live at preview URL
- ✅ Main system unchanged at production URL  
- ✅ Both systems working independently
- ✅ Easy switching between systems

### **User Experience**
- **Testers** can use preview URL for gamified experience
- **Production users** keep using main URL (no disruption)
- **You** can compare both systems easily

## 📞 **Support Commands**

```powershell
# Check current status
git status
git branch

# See both URLs
echo "Main: https://yourusername.github.io/mcs-labs"
echo "Jekyll: https://yourusername.github.io/mcs-labs-jekyll"

# Quick rollback
.\rollback-to-main.ps1

# Switch to Jekyll
git checkout jekyll-lab-browser
```

---

🎯 **Ready to deploy?** Push your `jekyll-lab-browser` branch and watch the magic happen!