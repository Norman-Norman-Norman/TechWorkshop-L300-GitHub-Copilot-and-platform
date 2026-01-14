# Exercise 05: Implementation Plan - Integrate GitHub Copilot for Developer Productivity

## Overview

This plan implements the complete Exercise 05 workshop tasks for the Zava Storefront application, leveraging GitHub MCP and Azure MCP capabilities.

**Estimated Time:** 45 minutes  
**Organization:** Norman-Norman-Norman  
**Repository:** [Norman-Norman-Norman/TechWorkshop-L300-GitHub-Copilot-and-platform](https://github.com/Norman-Norman-Norman/TechWorkshop-L300-GitHub-Copilot-and-platform)  
**Forked From:** microsoft/TechWorkshop-L300-GitHub-Copilot-and-platform

---

## ✅ Pre-requisite: Enable Issues on the Fork - COMPLETED

Issues have been enabled in the repository settings.

---

## Task 1: Create GitHub Issue for .NET Upgrade ✅ COMPLETED

| Status | Description |
|--------|-------------|
| ✅ Done | Created [Issue #1](https://github.com/Norman-Norman-Norman/TechWorkshop-L300-GitHub-Copilot-and-platform/issues/1) in Norman-Norman-Norman org |

**GitHub MCP Tools Used:**
- `mcp_github_issue_write` - Created the issue with full requirements

**Issue Details:**
- **Owner:** Norman-Norman-Norman
- **Repo:** TechWorkshop-L300-GitHub-Copilot-and-platform
- **Title:** Update .NET to the current LTS version
- **Issue URL:** https://github.com/Norman-Norman-Norman/TechWorkshop-L300-GitHub-Copilot-and-platform/issues/1

---

## Task 2: Assign Copilot to Implement .NET Upgrade ✅ COMPLETED

| Status | Description |
|--------|-------------|
| ✅ Done | Assigned GitHub Copilot coding agent to Issue #1 |
| 🤖 In Progress | [PR #2](https://github.com/Norman-Norman-Norman/TechWorkshop-L300-GitHub-Copilot-and-platform/pull/2) - Copilot is working on the .NET upgrade |

**Actions Completed:**

### 2.1 Assign Copilot to the Issue ✅
```
GitHub MCP Tool: mcp_github_assign_copilot_to_issue
- owner: Norman-Norman-Norman
- repo: TechWorkshop-L300-GitHub-Copilot-and-platform
- issue_number: 1
- Result: Successfully assigned
```

### 2.2 Pull Request Created by Copilot 🤖
- **PR #2:** [WIP] Update .NET to the current LTS version
- **Branch:** `copilot/update-dotnet-to-lts-version`
- **Status:** Draft - Copilot is working
- **URL:** https://github.com/Norman-Norman-Norman/TechWorkshop-L300-GitHub-Copilot-and-platform/pull/2

**Files to be Modified:**
- `src/ZavaStorefront.csproj` - TargetFramework: net6.0 → net8.0
- Potentially `global.json` if present
- Any package references requiring updates

---

## Task 3: Create Chatbot Feature Issue ✅ COMPLETED

| Status | Description |
|--------|-------------|
| ✅ Done | Created [Issue #3](https://github.com/Norman-Norman-Norman/TechWorkshop-L300-GitHub-Copilot-and-platform/issues/3) for AI Chatbot feature |

**GitHub MCP Tools Used:**
- `mcp_github_issue_write` - Created the chatbot feature issue

**Issue Details:**
- **Owner:** Norman-Norman-Norman
- **Repo:** TechWorkshop-L300-GitHub-Copilot-and-platform
- **Title:** Add Chatbot Feature with Microsoft Foundry Integration
- **Issue URL:** https://github.com/Norman-Norman-Norman/TechWorkshop-L300-GitHub-Copilot-and-platform/issues/3

---

## Task 4: Assign Copilot to Implement Chatbot Feature ✅ COMPLETED

| Status | Description |
|--------|-------------|
| ✅ Done | Assigned GitHub Copilot coding agent to Issue #3 |
| 🤖 Pending | Waiting for Copilot to start working on chatbot implementation |

**Actions Completed:**

### 4.1 Assign Copilot to the Issue ✅
```
GitHub MCP Tool: mcp_github_assign_copilot_to_issue
- owner: Norman-Norman-Norman
- repo: TechWorkshop-L300-GitHub-Copilot-and-platform
- issue_number: 3
- Result: Successfully assigned
```

### 4.2 Expected New Files (to be created by Copilot)

| File | Purpose |
|------|---------|
| `src/Controllers/ChatController.cs` | Handle chat requests and Foundry API calls |
| `src/Views/Chat/Index.cshtml` | Chat page UI with input and response area |
| `src/Services/FoundryService.cs` | Service to interact with Microsoft Foundry API |
| `src/Models/ChatMessage.cs` | Model for chat messages |

### 4.3 Expected Modified Files (to be updated by Copilot)

| File | Changes |
|------|---------|
| `src/appsettings.json` | Add Foundry configuration section |
| `src/Program.cs` | Register FoundryService in DI container |
| `src/Views/Shared/_Layout.cshtml` | Add Chat link to navigation |
| `src/ZavaStorefront.csproj` | Add Azure.AI.Inference NuGet package |

**Available Phi-4 Models:**
- `Phi-4` - Main model (serverless endpoint + managed compute)
- `Phi-4-mini-instruct` - Smaller variant
- `Phi-4-multimodal-instruct` - Multimodal capabilities
- `Phi-4-reasoning` - Enhanced reasoning
- `Phi-4-mini-reasoning` - Mini reasoning variant

---

## Task 5: Review and Merge Pull Requests ⏳ WAITING

| Status | Description |
|--------|-------------|
| ⏳ Waiting | Wait for Copilot to complete PRs, then review and merge |

**Pull Requests to Review:**

| PR | Issue | Description | Status |
|----|-------|-------------|--------|
| [#2](https://github.com/Norman-Norman-Norman/TechWorkshop-L300-GitHub-Copilot-and-platform/pull/2) | #1 | .NET 6 → .NET 8 Upgrade | 🤖 In Progress |
| TBD | #3 | Chatbot Feature | 🤖 Pending |

**Actions Required (when PRs are ready):**
```
GitHub MCP Tools:
- mcp_github_pull_request_read - Review the changes
- mcp_github_request_copilot_review - Get automated code review
- mcp_github_merge_pull_request - Merge approved changes
```

---

## Task 6: Compile, Test, and Validate ⏳ PENDING

| Status | Description |
|--------|-------------|
| ⏳ Pending | After PRs are merged, build and test the application |

**Actions Required:**

### 6.1 Build the Solution
```powershell
cd d:\l300\TechWorkshop-L300-GitHub-Copilot-and-platform\src
dotnet build
```

### 6.2 Run the Application
```powershell
dotnet run
```

### 6.3 Configure Foundry Credentials
```powershell
# Option 1: User Secrets
dotnet user-secrets set "Foundry:Endpoint" "<your-endpoint>"
dotnet user-secrets set "Foundry:ApiKey" "<your-api-key>"

# Option 2: Environment Variables
$env:Foundry__Endpoint = "<your-endpoint>"
$env:Foundry__ApiKey = "<your-api-key>"
```

---

## Summary of GitHub MCP Tools Used

| Tool | Purpose | Status |
|------|---------|--------|
| `mcp_github_fork_repository` | Fork repo to org | ✅ Done |
| `mcp_github_issue_write` | Create issues | ✅ Done (2 issues) |
| `mcp_github_assign_copilot_to_issue` | Assign Copilot | ✅ Done (2 issues) |
| `mcp_github_list_pull_requests` | List PRs | ✅ Done |
| `mcp_github_pull_request_read` | Review changes | ⏳ Pending |
| `mcp_github_merge_pull_request` | Merge PRs | ⏳ Pending |

## Summary of Azure MCP Tools

| Tool | Purpose |
|------|---------|
| `mcp_com_microsoft_foundry` | Microsoft Foundry operations |
| `mcp_com_microsoft_azureaibestpractices` | AI development best practices |

---

## Current Status Summary

```
┌─────────────────────────────────────────────────────────────────┐
│                    EXERCISE 05 PROGRESS                         │
├─────────────────────────────────────────────────────────────────┤
│ ✅ Task 1: Create .NET Upgrade Issue          → Issue #1        │
│ ✅ Task 2: Assign Copilot to .NET Issue       → PR #2 (WIP)     │
│ ✅ Task 3: Create Chatbot Feature Issue       → Issue #3        │
│ ✅ Task 4: Assign Copilot to Chatbot Issue    → PR Pending      │
│ ⏳ Task 5: Review & Merge PRs                 → Waiting         │
│ ⏳ Task 6: Build, Test & Validate             → Pending         │
└─────────────────────────────────────────────────────────────────┘
```

---

## Links

| Resource | URL |
|----------|-----|
| **Repository** | https://github.com/Norman-Norman-Norman/TechWorkshop-L300-GitHub-Copilot-and-platform |
| **Issue #1** (.NET Upgrade) | https://github.com/Norman-Norman-Norman/TechWorkshop-L300-GitHub-Copilot-and-platform/issues/1 |
| **Issue #3** (Chatbot) | https://github.com/Norman-Norman-Norman/TechWorkshop-L300-GitHub-Copilot-and-platform/issues/3 |
| **PR #2** (.NET Upgrade) | https://github.com/Norman-Norman-Norman/TechWorkshop-L300-GitHub-Copilot-and-platform/pull/2 |
| **PR #4** (Chatbot) | https://github.com/Norman-Norman-Norman/TechWorkshop-L300-GitHub-Copilot-and-platform/pull/4 |

---

## Next Actions

1. 🤖 **Monitor:** Watch [PR #2](https://github.com/Norman-Norman-Norman/TechWorkshop-L300-GitHub-Copilot-and-platform/pull/2) for Copilot to complete .NET upgrade
2. 🤖 **Monitor:** Watch for Copilot to create PR for Issue #3 (Chatbot)
3. ✅ **Review:** Review and merge PRs when ready
4. 🔧 **Test:** Build and run the application
5. ⚙️ **Configure:** Set up Foundry credentials for the chatbot
