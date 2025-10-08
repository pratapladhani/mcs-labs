# Docker Setup Instructions for Jekyll Lab Testing

## After Docker Desktop Installation:

1. **Start Docker Desktop** (should auto-start after install)
2. **Wait for Docker to be ready** (green light in system tray)
3. **Run these commands in PowerShell:**

```powershell
# Verify Docker is working
docker --version

# Test Docker with a simple container
docker run hello-world
```

## Once Docker is Ready:

We'll use this command to run Jekyll locally:

```powershell
# Navigate to your labs directory
cd "c:\Users\pladhani\Source\Repos\mcs-labs"

# Run Jekyll in Docker container
docker run --rm -it -p 4000:4000 -v "${PWD}:/srv/jekyll" jekyll/jekyll:latest jekyll serve --host 0.0.0.0
```

## What This Does:
- `--rm` = Remove container when done
- `-it` = Interactive terminal
- `-p 4000:4000` = Map port 4000 (localhost:4000)
- `-v "${PWD}:/srv/jekyll"` = Mount current directory
- `jekyll serve --host 0.0.0.0` = Start Jekyll server

## Expected Result:
- Jekyll will install dependencies automatically
- Site will be available at: http://localhost:4000
- No Windows gem compilation issues!

## Alternative Quick Test:
If you want to test immediately while Docker installs, we can push to GitHub and test the live deployment.