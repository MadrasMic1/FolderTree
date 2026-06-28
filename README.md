

\# Create-From-Tree.ps1



A PowerShell script that creates folder and file structures based on an indented tree diagram.



\## 📋 Overview



`Create-From-Tree.ps1` reads a tree structure from a text file and creates the corresponding directories and files at a specified target location. Perfect for setting up project structures quickly and consistently.



\## ✨ Features



\- 📁 \*\*Tree File Input\*\* - Read structure from text file

\- 🎯 \*\*Target Location\*\* - Specify where to create the structure

\- 🌐 \*\*UTF-8 Support\*\* - Handles Unicode tree characters (├──, │, └──)

\- 🔄 \*\*Idempotent\*\* - Safe to run multiple times

\- ⚠️ \*\*Error Handling\*\* - Reports errors for failed creations

\- 📊 \*\*Progress Output\*\* - Shows what's being created



\## 📦 Installation



1\. Save this script as `Create-From-Tree.ps1`

2\. Create your tree structure in a file called `tree.txt`



\## 🚀 Usage



\### Basic Usage (Current Directory)



```powershell

.\\Create-From-Tree.ps1 -TreeFile "tree.txt"

```



\### Specify Target Location



```powershell

.\\Create-From-Tree.ps1 -TreeFile "tree.txt" -TargetPath "F:\\Openwebui"

```



\### Full Path Example



```powershell

D:\\Scripts\\Create-From-Tree.ps1 -TreeFile "tree.txt" -TargetPath "F:\\Openwebui"

```



\## 📝 Parameters



| Parameter | Required | Description |

|-----------|----------|-------------|

| `-TreeFile` | ✅ Yes | Path to the tree structure file |

| `-TargetPath` | ❌ No | Full absolute path where structure should be created |

| `-RootPath` | ❌ No | Alternative to `-TargetPath` (default: current directory) |



\## 🌲 Creating the Tree File



\### Option 1: Simple Tree (Spaces Only)



```powershell

cat > tree.txt << 'EOF'

OpenWebUI/

&#x20;   frontend/

&#x20;   backend/

&#x20;   docs/

&#x20;   docker/

&#x20;   scripts/

&#x20;   .env.example

&#x20;   docker-compose.yml

&#x20;   README.md

&#x20;   LICENSE

EOF

```



\### Option 2: Visual Tree (With Characters)



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



\## 💻 Command Line Examples



```powershell

\# Create in current directory

.\\Create-From-Tree.ps1 -TreeFile "tree.txt"



\# Create in specific location

.\\Create-From-Tree.ps1 -TreeFile "tree.txt" -TargetPath "F:\\Openwebui"



\# Create in nested directory

.\\Create-From-Tree.ps1 -TreeFile "tree.txt" -TargetPath "D:\\Projects\\OpenWebUI"

```



\## 📤 Expected Output



```

Reading tree file: tree.txt



Parsing tree structure...



Found 10 items in tree



Creating structure at: F:\\Openwebui

&#x20; ✓ Directory: F:\\Openwebui\\frontend

&#x20; ✓ Directory: F:\\Openwebui\\backend

&#x20; ✓ Directory: F:\\Openwebui\\docs

&#x20; ✓ Directory: F:\\Openwebui\\docker

&#x20; ✓ Directory: F:\\Openwebui\\scripts

&#x20; ✓ File: F:\\Openwebui\\.env.example

&#x20; ✓ File: F:\\Openwebui\\docker-compose.yml

&#x20; ✓ File: F:\\Openwebui\\README.md

&#x20; ✓ File: F:\\Openwebui\\LICENSE



=== Summary ===

Target location: F:\\Openwebui

Total items created: 9



✓ Structure created successfully at: F:\\Openwebui

```



\## 📁 Resulting Structure



```

F:\\Openwebui\\

├── frontend/

├── backend/

├── docs/

├── docker/

├── scripts/

├── .env.example

├── docker-compose.yml

├── README.md

└── LICENSE

```



\## ⚠️ Troubleshooting



| Issue | Solution |

|-------|----------|

| \*\*"Tree file not found"\*\* | Ensure the tree file path is correct and the file exists |

| \*\*"Illegal characters in path"\*\* | Use proper paths (e.g., `F:\\Openwebui` not `F:/Openwebui`) |

| \*\*"Cannot convert value"\*\* | Save the tree file with UTF-8 encoding |

| \*\*Structure not created\*\* | Use absolute path for `-TargetPath` parameter |



\## 📂 File Structure



```

D:\\Scripts\\

├── Create-From-Tree.ps1    # Main script

└── tree.txt                 # Tree structure definition

```



\## 📄 License



This script is provided as-is for personal and educational use.



\## 📌 Version



\- \*\*Version:\*\* 1.0

\- \*\*Last Updated:\*\* 2024

\- \*\*PowerShell Version:\*\* 5.0+



\---



\*For questions or issues, please check the error messages in the console output.\*

