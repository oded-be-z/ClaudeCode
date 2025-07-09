#!/bin/bash
# claude-workflow.sh - Smart Claude Code Workflow Management

# Color codes for pretty output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to create a new project with Claude
claude_new_project() {
    local project_name=$1
    local project_type=$2
    
    echo -e "${BLUE}🚀 Creating new project: $project_name${NC}"
    
    # Create project directory
    mkdir -p ~/projects/$project_name
    cd ~/projects/$project_name
    
    # Initialize git
    git init
    
    # Copy claude.md to new project
    cp ~/Seekapa-AI-Assistance/claude.md .
    
    # Start Claude Code with project-specific prompt
    case $project_type in
        "video")
            claude "Create a video automation project structure with:
            - Script generation module
            - InVideo API integration
            - Multi-language support (AR, EN, ES, PT)
            - A/B testing framework
            - Azure deployment ready"
            ;;
        "trading")
            claude "Create a trading bot enhancement with:
            - Strategy optimization module
            - Risk management system
            - Performance analytics
            - Azure deployment configuration"
            ;;
        "content")
            claude "Create a content generation system with:
            - Multi-language article generator
            - SEO optimization
            - Social media formatter
            - Publishing automation"
            ;;
        *)
            claude "Create a basic project structure with TypeScript/Python setup"
            ;;
    esac
}

# Function to save Claude's context before clearing
claude_checkpoint() {
    local checkpoint_name=$1
    echo -e "${YELLOW}📸 Creating checkpoint: $checkpoint_name${NC}"
    
    # Create checkpoints directory
    mkdir -p ~/.claude_checkpoints
    
    # Ask Claude to summarize
    echo "Please summarize everything we've built so far, including:
    - Project structure
    - Key components implemented
    - Decisions made
    - Next steps
    Save this as checkpoint: $checkpoint_name" | claude
    
    echo -e "${GREEN}✓ Checkpoint saved${NC}"
}

# Function to extract code from Claude
claude_extract() {
    local output_dir=${1:-"./extracted_code"}
    
    echo -e "${YELLOW}📂 Extracting code to $output_dir${NC}"
    mkdir -p $output_dir
    
    echo "Extract all code blocks from our conversation and save them as separate files in $output_dir" | claude
    
    echo -e "${GREEN}✓ Code extracted${NC}"
}

# Quick commands
case "$1" in
    "new")
        claude_new_project "$2" "$3"
        ;;
    "checkpoint")
        claude_checkpoint "$2"
        ;;
    "extract")
        claude_extract "$2"
        ;;
    "video")
        cd ~/Seekapa-AI-Assistance
        claude "Let's work on unbranded trading video ads"
        ;;
    "trading")
        cd /mnt/c/Users/oded.be/tradebot_v3
        claude "Let's optimize the trading bot"
        ;;
    *)
        echo -e "${BLUE}Claude Code Workflow Helper${NC}"
        echo "Usage:"
        echo "  ./claude-workflow.sh new <project-name> <type>"
        echo "  ./claude-workflow.sh checkpoint <name>"
        echo "  ./claude-workflow.sh extract [output-dir]"
        echo "  ./claude-workflow.sh video"
        echo "  ./claude-workflow.sh trading"
        ;;
esac
