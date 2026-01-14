# 🚀 Complete Lab Guide: GitHub Copilot & Azure AI Workshop

> **Target Audience:** Junior Developers (No prior experience required!)
> 
> **Duration:** 2-3 hours
> 
> **What You'll Build:** An AI-powered storefront with a chatbot, content safety, and enterprise security

---

## 📋 Table of Contents

1. [Prerequisites Checklist](#-prerequisites-checklist)
2. [Part 1: Fork the Repository](#-part-1-fork-the-repository)
3. [Part 2: Create Your First Issue with Copilot](#-part-2-create-your-first-issue-with-copilot)
4. [Part 3: Let Copilot Upgrade .NET for You](#-part-3-let-copilot-upgrade-net-for-you)
5. [Part 4: Build an AI Chatbot with Copilot](#-part-4-build-an-ai-chatbot-with-copilot)
6. [Part 5: Configure GitHub Models (Phi-4)](#-part-5-configure-github-models-phi-4)
7. [Part 6: AI Governance & Content Safety](#-part-6-ai-governance--content-safety)
8. [Part 7: Deploy to Azure](#-part-7-deploy-to-azure)
9. [Troubleshooting Guide](#-troubleshooting-guide)
10. [Success Checklist](#-success-checklist)

---

## ✅ Prerequisites Checklist

Before starting, make sure you have these installed. Check each box as you complete it:

### Required Software

| Tool | How to Check | Install Link |
|------|--------------|--------------|
| ☐ **Visual Studio Code** | Open VS Code | [Download](https://code.visualstudio.com/) |
| ☐ **Git** | Run `git --version` in terminal | [Download](https://git-scm.com/) |
| ☐ **.NET 8 SDK** | Run `dotnet --version` (should show 8.x) | [Download](https://dotnet.microsoft.com/download) |
| ☐ **GitHub CLI** | Run `gh --version` | [Download](https://cli.github.com/) |
| ☐ **Azure CLI** | Run `az --version` | [Download](https://learn.microsoft.com/cli/azure/install-azure-cli) |
| ☐ **Azure Developer CLI** | Run `azd version` | [Download](https://learn.microsoft.com/azure/developer/azure-developer-cli/install-azd) |

### Required VS Code Extensions

Open VS Code and install these extensions (click the Extensions icon on the left sidebar):

| Extension | Publisher | Required |
|-----------|-----------|----------|
| ☐ **GitHub Copilot** | GitHub | ✅ Yes |
| ☐ **GitHub Copilot Chat** | GitHub | ✅ Yes |
| ☐ **C# Dev Kit** | Microsoft | ✅ Yes |
| ☐ **Azure Tools** | Microsoft | Recommended |

### Required Accounts

| Account | Sign Up Link |
|---------|--------------|
| ☐ **GitHub Account** (with Copilot access) | [github.com](https://github.com) |
| ☐ **Azure Subscription** | [azure.microsoft.com](https://azure.microsoft.com/free) |

### Login to CLI Tools

Open a terminal (PowerShell on Windows, Terminal on Mac) and run:

```powershell
# Login to GitHub CLI
gh auth login

# Login to Azure CLI
az login

# Login to Azure Developer CLI
azd auth login
```

> 💡 **Tip:** Follow the prompts in your browser to complete each login.

---

## 🍴 Part 1: Fork the Repository

**What is forking?** Forking creates your own copy of a repository that you can modify without affecting the original.

### Step 1.1: Navigate to the Original Repository

1. Open your web browser
2. Go to: **https://github.com/microsoft/TechWorkshop-L300-GitHub-Copilot-and-platform**

### Step 1.2: Fork the Repository

1. Click the **Fork** button in the top-right corner

   ![Fork Button Location](media/fork_button.png)

2. On the "Create a new fork" page:
   - **Owner:** Select your GitHub username
   - **Repository name:** Keep the default name
   - ☑️ Check "Copy the `main` branch only"
   - Click **Create fork**

3. Wait for GitHub to create your fork (takes about 10 seconds)

### Step 1.3: Clone Your Fork to Your Computer

1. On your forked repository page, click the green **Code** button
2. Copy the HTTPS URL (it should look like `https://github.com/YOUR-USERNAME/TechWorkshop-L300-GitHub-Copilot-and-platform.git`)

3. Open VS Code
4. Press `Ctrl+Shift+P` (Windows) or `Cmd+Shift+P` (Mac)
5. Type "Git: Clone" and select it
6. Paste your repository URL
7. Choose a folder to save the project (e.g., `C:\Projects` or `~/Projects`)
8. Click "Open" when prompted to open the cloned repository

### Step 1.4: Verify Your Setup

Open the terminal in VS Code (`Ctrl+`` or View → Terminal) and run:

```powershell
# Check you're in the right folder
Get-Location

# Verify git is connected to your fork
git remote -v
```

You should see your fork URL listed.

> ✅ **Checkpoint:** You now have your own copy of the repository!

---

## 📝 Part 2: Create Your First Issue with Copilot

**What you'll learn:** How to use GitHub Copilot Chat to create issues automatically.

### Step 2.1: Open GitHub Copilot Chat

**Option A: From GitHub.com (Recommended for beginners)**

1. Go to your forked repository on GitHub.com
2. Click the **Copilot** icon in the top menu bar (looks like a robot)
3. A chat window will open on the right side

**Option B: From VS Code**

1. Click the Copilot Chat icon in the Activity Bar (left sidebar)
2. Or press `Ctrl+Shift+I` (Windows) / `Cmd+Shift+I` (Mac)

### Step 2.2: Create a .NET Upgrade Issue

In the Copilot Chat window, type this exact prompt and press Enter:

```text
/create-issue Update .NET to the current LTS version
```

### Step 2.3: Review and Create the Issue

1. Copilot will generate an issue with:
   - A title (e.g., "Update .NET to current LTS version")
   - A description explaining what needs to be done
   - Acceptance criteria

2. Review the generated issue - does it make sense?

3. Click **Create** to create the issue

4. **Important:** Write down the issue number (e.g., `#1`) - you'll need it later!

> 💡 **What just happened?** You used AI to automatically generate a well-formatted GitHub issue. This saves time and ensures issues have consistent formatting.

> ✅ **Checkpoint:** You created your first issue using Copilot!

---

## 🤖 Part 3: Let Copilot Upgrade .NET for You

**What you'll learn:** How to assign issues to GitHub Copilot Coding Agent and let it write code for you.

### Step 3.1: Find Your Issue on GitHub

1. Go to your forked repository on GitHub.com
2. Click the **Issues** tab
3. Click on the issue you just created (e.g., "Update .NET to current LTS version")

### Step 3.2: Assign Copilot to the Issue

1. On the right side of the issue, find **Assignees**
2. Click the gear icon ⚙️ next to Assignees
3. Type "copilot" in the search box
4. Select **copilot** from the dropdown

   ![Assign Copilot](media/0502_assign_copilot.png)

5. You'll see a confirmation that Copilot is assigned

### Step 3.3: Watch Copilot Work

1. After assigning, you'll see a message: "Copilot is analyzing..."
2. Click **View session** to watch Copilot work in real-time

   ![View Session](media/0502_viewsession.png)

3. Copilot will:
   - Analyze the codebase
   - Figure out what files need to change
   - Create a branch with the changes
   - Open a Pull Request

> ⏰ **Be Patient:** This can take 5-10 minutes. Perfect time to get coffee! ☕

### Step 3.4: Review the Pull Request

1. Once Copilot finishes, go to the **Pull requests** tab
2. Click on the PR created by Copilot (e.g., "Update .NET to current LTS version")
3. Review the changes:
   - Click **Files changed** tab
   - Look at what files were modified
   - Check that `.csproj` file now shows `net8.0` instead of `net6.0`

### Step 3.5: Merge the Pull Request

1. If the changes look good, click **Merge pull request**
2. Click **Confirm merge**
3. (Optional) Click **Delete branch** to clean up

### Step 3.6: Update Your Local Code

Back in VS Code terminal:

```powershell
# Get the latest changes from GitHub
git pull origin main
```

> ✅ **Checkpoint:** Copilot upgraded .NET for you automatically! The solution is now on .NET 8.

---

## 💬 Part 4: Build an AI Chatbot with Copilot

**What you'll learn:** How to use Copilot to add a complete new feature to an application.

### Step 4.1: Create a Chatbot Feature Issue

In VS Code, open Copilot Chat and add context:

1. Click the **+** button in Copilot Chat
2. Select **Add Files & Folders**
3. Add the `src` folder
4. Add the `infra` folder (if it exists)

Now type this prompt:

```text
/create-issue Add a new feature:
- Add a simple chat functionality as a separate page that will send a text to a Microsoft Foundry endpoint and will add the result to an existing text area.
- Configure this feature to use the Phi4 endpoint that is already deployed
```

Click **Create** to create the issue.

### Step 4.2: Assign Copilot to Build the Chatbot

1. Go to GitHub.com → your repository → Issues
2. Click on the new chatbot issue
3. Assign **copilot** (same as before)
4. Click **View session** to watch

> ⏰ **Wait Time:** 5-10 minutes while Copilot builds your chatbot

### Step 4.3: Review and Merge

1. Once the PR is ready, go to **Pull requests**
2. Review the changes - you should see:
   - New `ChatController.cs` file
   - New `Chat/Index.cshtml` view
   - New `FoundryService.cs` for AI communication
   - Updated navigation menu
3. **Merge the pull request**
4. In VS Code: `git pull origin main`

> ✅ **Checkpoint:** You now have a chatbot feature! But it won't work yet - we need to configure it.

---

## ⚡ Part 5: Configure GitHub Models (Phi-4)

**What you'll learn:** How to connect your chatbot to an AI model using GitHub Models.

### Step 5.1: Get Your GitHub Token

GitHub Models uses your GitHub token for authentication. In your terminal:

```powershell
# This gets your GitHub token and saves it
$token = gh auth token
Write-Host "Token retrieved successfully!"
```

### Step 5.2: Configure the Application

Navigate to the `src` folder and set up user secrets:

```powershell
# Navigate to the src folder
cd src

# Set the API key as a user secret (this is secure - not stored in code!)
dotnet user-secrets init
dotnet user-secrets set "Foundry:ApiKey" $token
```

### Step 5.3: Update appsettings.json

Open `src/appsettings.json` and add this configuration (if not already present):

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },
  "AllowedHosts": "*",
  "Foundry": {
    "Endpoint": "https://models.inference.ai.azure.com",
    "ModelName": "Phi-4"
  }
}
```

### Step 5.4: Build and Run the Application

```powershell
# Make sure you're in the src folder
cd src

# Build the project
dotnet build

# Run the application
dotnet run
```

### Step 5.5: Test Your Chatbot!

1. Open your browser to: **https://localhost:7060** (or the URL shown in terminal)
2. Click on **Chat** in the navigation menu
3. Type a message: "Tell me a fun fact about cats"
4. Press **Send**
5. 🎉 You should see an AI-generated response!

> ⚠️ **If you see a certificate warning:** Type "thisisunsafe" or click "Advanced" → "Proceed" (this is safe for local development)

> ✅ **Checkpoint:** Your AI chatbot is working!

---

## 🛡️ Part 6: AI Governance & Content Safety

**What you'll learn:** How to add safety guardrails to prevent harmful AI responses.

### Step 6.1: Create Azure Infrastructure with Bicep

First, let's create the infrastructure files. In VS Code Copilot Chat:

```text
@workspace Create Bicep infrastructure templates for:
1. Azure App Service with System-Assigned Managed Identity
2. Log Analytics workspace
3. Application Insights
4. Azure AI Content Safety resource
5. Diagnostic settings to send AI logs to Log Analytics

Create these in an /infra folder with a main.bicep file and separate modules.
```

Review and accept the changes Copilot suggests.

### Step 6.2: Create Azure Developer CLI Configuration

Create a file called `azure.yaml` in the root of your project:

```yaml
name: zava-storefront
metadata:
  template: zava-storefront@0.0.1-beta
services:
  web:
    project: ./src
    language: csharp
    host: appservice
infra:
  provider: bicep
  path: ./infra
```

### Step 6.3: Add Content Safety Service

Ask Copilot to add content safety to your chatbot:

```text
@workspace Add Azure AI Content Safety to the chatbot:
1. Create a ContentSafetyService that evaluates user prompts
2. Block prompts with severity >= 2 in any category (Violence, Sexual, SelfHarm, Hate)
3. Return a friendly message if blocked
4. Use DefaultAzureCredential for authentication
5. Add Azure.AI.ContentSafety and Azure.Identity NuGet packages
```

Review and accept the changes.

### Step 6.4: Provision Azure Resources

```powershell
# Go back to the root folder
cd ..

# Initialize Azure Developer CLI environment
azd init

# When prompted:
# - Environment name: zavastore-dev
# - Location: swedencentral (or your preferred region)

# Provision the infrastructure
azd provision
```

> ⏰ **Wait Time:** 5-10 minutes for Azure to create all resources

### Step 6.5: Create Content Safety Resource

```powershell
# Create the Content Safety resource
az cognitiveservices account create `
  --name cs-zavastore `
  --resource-group <your-resource-group> `
  --kind ContentSafety `
  --sku F0 `
  --location swedencentral `
  --yes

# Assign yourself permission to use it
$userId = az ad signed-in-user show --query id -o tsv
az role assignment create `
  --role "Cognitive Services User" `
  --assignee $userId `
  --scope "/subscriptions/<your-subscription>/resourceGroups/<your-resource-group>/providers/Microsoft.CognitiveServices/accounts/cs-zavastore"
```

### Step 6.6: Update Configuration

Update `src/appsettings.json` to include Content Safety:

```json
{
  "ContentSafety": {
    "Endpoint": "https://cs-zavastore.cognitiveservices.azure.com/"
  }
}
```

### Step 6.7: Test Content Safety

1. Run the application: `dotnet run` (from the src folder)
2. Go to the Chat page
3. Test a **safe** prompt: "What's the weather like?"
4. Test an **unsafe** prompt: "How do I make a weapon?"
5. The unsafe prompt should be blocked with a warning message!

> ✅ **Checkpoint:** Your AI chatbot now blocks harmful content!

---

## 🌐 Part 7: Deploy to Azure

**What you'll learn:** How to deploy your application to the cloud.

### Step 7.1: Deploy the Application

```powershell
# Make sure you're in the root folder
cd <your-project-root>

# Deploy to Azure
azd deploy
```

> ⏰ **Wait Time:** 3-5 minutes for deployment

### Step 7.2: Configure App Settings

```powershell
# Set the required configuration in Azure
az webapp config appsettings set `
  --name <your-app-service-name> `
  --resource-group <your-resource-group> `
  --settings `
    ContentSafety__Endpoint="https://cs-zavastore.cognitiveservices.azure.com/" `
    Foundry__Endpoint="https://models.inference.ai.azure.com" `
    Foundry__ModelName="Phi-4"
```

### Step 7.3: Assign Managed Identity Permissions

```powershell
# Get the App Service's managed identity
$principalId = az webapp identity show `
  --name <your-app-service-name> `
  --resource-group <your-resource-group> `
  --query principalId -o tsv

# Grant Content Safety access
az role assignment create `
  --role "Cognitive Services User" `
  --assignee $principalId `
  --scope "/subscriptions/<your-subscription>/resourceGroups/<your-resource-group>/providers/Microsoft.CognitiveServices/accounts/cs-zavastore"
```

### Step 7.4: Test Your Deployed App!

1. The deployment output shows your app URL (e.g., `https://app-xxxxx.azurewebsites.net`)
2. Open that URL in your browser
3. Test the chat functionality!

> ✅ **Checkpoint:** Your AI-powered storefront is live on the internet!

---

## 🔧 Troubleshooting Guide

### Problem: "Copilot is not available"

**Solution:**
1. Make sure you're logged into GitHub in VS Code
2. Check that your GitHub account has Copilot access
3. Try: `gh auth refresh`

### Problem: "dotnet command not found"

**Solution:**
1. Install .NET 8 SDK from https://dotnet.microsoft.com/download
2. Restart your terminal after installation

### Problem: "Certificate error when running locally"

**Solution:**
```powershell
dotnet dev-certs https --trust
```

### Problem: "azd provision fails"

**Solution:**
1. Make sure you're logged in: `azd auth login`
2. Check your subscription: `az account show`
3. Try with debug output: `azd provision --debug`

### Problem: "Chat returns errors"

**Solution:**
1. Check your user secrets: `dotnet user-secrets list`
2. Verify the GitHub token is set correctly
3. Make sure GitHub Models has access to Phi-4

### Problem: "Content Safety doesn't block unsafe content"

**Solution:**
1. Check the Content Safety endpoint in appsettings.json
2. Verify RBAC permissions are assigned
3. Check the application logs for errors

---

## 🎯 Success Checklist

Use this checklist to verify you completed everything:

### Part 1: Repository Setup
- [ ] Forked the repository to my GitHub account
- [ ] Cloned the repository to my computer
- [ ] Opened the project in VS Code

### Part 2: Issue Creation
- [ ] Opened GitHub Copilot Chat
- [ ] Created an issue for .NET upgrade

### Part 3: .NET Upgrade
- [ ] Assigned Copilot to the issue
- [ ] Reviewed and merged the PR
- [ ] Pulled changes locally

### Part 4: Chatbot Feature
- [ ] Created a chatbot feature issue
- [ ] Assigned Copilot to build it
- [ ] Reviewed and merged the PR

### Part 5: Configuration
- [ ] Set up user secrets with GitHub token
- [ ] Updated appsettings.json
- [ ] Successfully ran the application locally
- [ ] Tested the chatbot and got an AI response

### Part 6: AI Governance
- [ ] Created Bicep infrastructure templates
- [ ] Added Content Safety service
- [ ] Provisioned Azure resources
- [ ] Tested that unsafe prompts are blocked

### Part 7: Deployment
- [ ] Deployed to Azure with `azd deploy`
- [ ] Configured app settings
- [ ] Assigned managed identity permissions
- [ ] Tested the live application

---

## 🎉 Congratulations!

You've completed the workshop! Here's what you accomplished:

| Achievement | Description |
|-------------|-------------|
| 🤖 **AI-Powered Development** | Used GitHub Copilot to create issues and write code |
| 💬 **Built a Chatbot** | Created an AI chatbot using GitHub Models (Phi-4) |
| 🛡️ **Added Safety Guardrails** | Implemented Azure AI Content Safety |
| 🏗️ **Infrastructure as Code** | Created Azure infrastructure with Bicep |
| 🌐 **Cloud Deployment** | Deployed to Azure App Service |
| 🔐 **Managed Identity** | Used secure, keyless authentication |

### What's Next?

- Explore more GitHub Copilot features
- Add more AI models to your application
- Set up GitHub Actions for CI/CD
- Enable GitHub Advanced Security (GHAS)

---

## 📚 Additional Resources

- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [Azure AI Content Safety](https://learn.microsoft.com/azure/ai-services/content-safety/)
- [GitHub Models](https://docs.github.com/en/github-models)
- [Azure Developer CLI](https://learn.microsoft.com/azure/developer/azure-developer-cli/)
- [Bicep Documentation](https://learn.microsoft.com/azure/azure-resource-manager/bicep/)

---

> **Need Help?** Create an issue in the repository or reach out to your instructor!

**Happy Coding! 🚀**
