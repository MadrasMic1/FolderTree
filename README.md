# Create-From-Tree.ps1

A PowerShell script that creates folder and file structures based on an indented tree diagram.

---

## 📋 Overview

`Create-From-Tree.ps1` reads a tree structure from a text file and creates the corresponding directories and files at a specified target location. Perfect for setting up project structures quickly and consistently.

## ✨ Features

- 📁 **Tree File Input** - Read structure from text file
- 🎯 **Target Location** - Specify where to create the structure
- 🌐 **UTF-8 Support** - Handles Unicode tree characters (├──, │, └──)
- 🔄 **Idempotent** - Safe to run multiple times
- ⚠️ **Error Handling** - Reports errors for failed creations
- 📊 **Progress Output** - Shows what's being created

## 📦 Installation

1. Save this script as `Create-From-Tree.ps1`
2. Create your tree structure in a file called `tree.txt`

## 🚀 Usage

### Basic Usage (Current Directory)

```powershell
.\Create-From-Tree.ps1 -TreeFile "tree.txt"
```

### Specify Target Location

```powershell
.\Create-From-Tree.ps1 -TreeFile "tree.txt" -TargetPath "F:\Openwebui"
```

### Full Path Example

```powershell
D:\Scripts\Create-From-Tree.ps1 -TreeFile "tree.txt" -TargetPath "F:\Openwebui"
```

## 📝 Parameters

| Parameter | Required | Description |
|------|:---:|-------|
| `-TreeFile` | ✅ Yes | Path to the tree structure file |
| `-TargetPath` | ❌ No | Full absolute path where structure should be created |
| `-RootPath` | ❌ No | Alternative to `-TargetPath` (default: current directory) |

## 🌲 Creating the Tree File

### Option 1: Simple Tree (Spaces Only)

```powershell
cat > tree.txt << 'EOF'
OpenWebUI/
    frontend/
    backend/
    docs/
    docker/
    scripts/
    .env.example
    docker-compose.yml
    README.md
    LICENSE
EOF
```

### Option 2: Visual Tree (With Characters)

```powershell
@"
OpenWebUI/
├── frontend/
├── backend/
├── docs/
├── docker/
├── scripts/
├── .env.example
├── docker-compose.yml
├── README.md
└── LICENSE
"@ | Out-File -FilePath tree.txt -Encoding UTF8
```

## 💻 Command Line Examples

```powershell
# Create in current directory
.\Create-From-Tree.ps1 -TreeFile "tree.txt"

# Create in specific location
.\Create-From-Tree.ps1 -TreeFile "tree.txt" -TargetPath "F:\Openwebui"

# Create in nested directory
.\Create-From-Tree.ps1 -TreeFile "tree.txt" -TargetPath "D:\Projects\OpenWebUI"
```

## 📤 Expected Output

