# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

**Development:**
- `yarn start` - Start the development server on port 3000
- `yarn test` - Run tests in watch mode
- `yarn test:nowatch` - Run tests once without watch mode
- `yarn build` - Create production build in `build/` directory

**Deployment:**
- `yarn gh-deploy` - Deploy to GitHub Pages (runs predeploy build automatically)

## Architecture Overview

This is a React Tic-Tac-Toe game built with Create React App. The game implements the classic tutorial with enhancements.

### Component Structure

The application has three main React components in `src/index.js`:

1. **Square** (Functional Component) - Individual game square that displays X, O, or nothing
2. **Board** (Class Component) - Renders the 3x3 grid of squares
3. **Game** (Class Component) - Top-level component managing:
   - Game state and history (array of board states)
   - Current step number for time travel
   - Turn tracking (xIsNext boolean)
   - Winner calculation logic

### Key Features

- Complete game history with ability to jump to any previous move
- Winner detection for all 8 possible winning combinations
- Move list shows coordinates in (col, row) format
- Large, accessible UI with 64x68px squares and 48px font

### Docker Support

Two Docker configurations are available:

**Development (`Dockerfile`):**
- Base: `node:22-slim` (matches devcontainer Node version)
- Runs `yarn start` with hot reload on port 3000
- Build: `docker build -t react-tictactoe:dev .`
- Run: `docker run -p 3000:3000 react-tictactoe:dev`

**Production (`Dockerfile.prod`):**
- Multi-stage build: `node:22-alpine` → `nginx:1.25-alpine`
- Security hardened: non-root user, health checks
- Custom `nginx.conf` with SPA routing and caching
- Build: `docker build -f Dockerfile.prod -t react-tictactoe:prod .`
- Run: `docker run -p 8080:80 react-tictactoe:prod`

**DevContainer (`.devcontainer/`):**
- Full development environment with Docker-in-Docker
- Resource limits and security options configured