# 🚀 SIMPLE GitHub Pages Deployment Guide

## 🎯 **The Reality: One URL Per Repository**

GitHub Pages gives you **one website URL per repository**. Here's the **simplest approach**:

## 🔄 **Branch Switching Method (Recommended)**

### **How It Works:**
- **Same URL**: `https://username.github.io/mcs-labs`
- **Different content** based on which branch GitHub Pages is set to use
- **Easy switching** through GitHub settings

### **Current State:**
```
main branch           → Lab Portal System (current)
jekyll-lab-browser   → Jekyll Journey System (new)
```

### **Deployment Steps:**

#### **Step 1: Push Your Jekyll Branch**
```powershell
# Make sure you're on Jekyll branch
git checkout jekyll-lab-browser

# Deploy Jekyll system
.\deploy-jekyll.ps1 -Execute
```

#### **Step 2: Switch GitHub Pages Source**
1. Go to your GitHub repository
2. Click **Settings** tab
3. Scroll to **Pages** section
4. Under **Source**, change from `main` to `jekyll-lab-browser`
5. Click **Save**

#### **Step 3: Test Your Jekyll System**
- Visit: `https://username.github.io/mcs-labs`
- You'll now see the **Jekyll Journey System**! 🎮

### **🔄 Rollback Anytime:**

#### **Option A: GitHub Settings (Web)**
1. Go to **Settings** → **Pages**
2. Change **Source** back to `main` branch
3. Your original lab portal is restored!

#### **Option B: Command Line**
```powershell
# Switch back to main branch
git checkout main

# Push any updates to main
git push origin main

# The go to GitHub Settings → Pages → Switch source to 'main'
```

## ✅ **Why This Works Best:**

1. **Same URL** - No confusion for users
2. **Easy switching** - Just change branch in GitHub settings  
3. **No complex setup** - Uses standard GitHub Pages
4. **Safe rollback** - Switch back anytime
5. **Both branches preserved** - Your work is safe

## 🎯 **Testing Workflow:**

```
1. Deploy Jekyll → Switch Pages to jekyll-lab-browser
2. Test thoroughly → Get feedback  
3. If good → Keep Jekyll active
4. If issues → Switch Pages back to main
5. Perfect system → Eventually merge Jekyll to main
```

## 🆘 **Emergency Rollback:**
If anything goes wrong:
1. GitHub Settings → Pages → Source → `main`
2. Your original system is back in 30 seconds!

---

**Ready to test?** This is the **simplest, safest way** to deploy your Jekyll system! 🚀