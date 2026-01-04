# Tic-Tac-Toe-React

Sample project to play around with React

> **AI Agents**: See [CLAUDE.md](CLAUDE.md) for structured AI context optimized for LLM consumption.

---

## 📋 Project Overview

### Repository Details
- **Project Type**: React Tic-Tac-Toe game (built with Create React App)
- **Tech Stack**: React 17.0.1, Jest (test runner), ESLint, Yarn
- **Purpose**: Simple educational project demonstrating React concepts
- **Note**: This is not a production-scale application

---

## 📁 Architecture & Code Structure

```
react-tic-tac-toe/
├── src/
│   ├── index.js          # Main application (3 React components)
│   ├── index.css         # Styling for game UI
│   └── simple.test.js    # Basic Jest test sample
├── public/               # Static assets (index.html, favicon, etc.)
├── .github/workflows/    # CI/CD pipelines
├── .devcontainer/        # VS Code Remote Container config
└── Dockerfile*           # Docker configurations (dev + prod)
```

### Component Breakdown

**File**: `src/index.js` (156 lines)

1. **Square** (Functional Component)
   - Individual game square button
   - Displays X, O, or empty state
   - Props: `value` (string/null), `onClick` (function)

2. **Board** (Class Component)
   - Renders 3x3 grid of squares
   - Presentational component (no state)
   - Receives `squares` array and `onClick` handler from parent

3. **Game** (Class Component)
   - Top-level component managing all game state
   - State:
     - `history`: Array of board states (time-travel feature)
     - `stepNumber`: Current move index
     - `xIsNext`: Boolean tracking turn
   - Methods:
     - `handleClick(i)`: Handle square clicks
     - `jumpTo(step)`: Navigate to previous moves
   - Renders status, Board, and move history list

### Key Game Logic

**Function**: `calculateWinner(squares)`
- Checks 8 possible winning combinations (3 rows, 3 columns, 2 diagonals)
- Returns winner ("X" or "O") or `null` if no winner yet
- Located at end of `src/index.js`

**State Management Pattern**:
- Immutable state updates using `array.slice()` and `array.concat()`
- History array enables time-travel feature (jump to any previous move)

---

## 🚀 Installation

```bash
npm install
# or
yarn install
```

---

## 💻 Development Commands

| Command | Purpose |
|---------|---------|
| `yarn start` | Start development server on port 3000 |
| `yarn build` | Create production build in `build/` directory |
| `yarn test` | Run Jest tests in watch mode |
| `yarn test:nowatch` | Run tests once (used in CI) |
| `yarn gh-predeploy` | Build for GitHub Pages deployment |
| `yarn gh-deploy` | Deploy to GitHub Pages |

---

## 🧪 Testing Infrastructure

- **Test Runner**: Jest (via react-scripts)
- **Test File**: `src/simple.test.js`
- **Test Environment**: jsdom
- **Test Coverage**: MINIMAL (currently only 1 sample filter test, no game logic tests)
- **Note**: Testing is underdeveloped for this codebase. AI agents should be aware that:
  - No tests exist for `calculateWinner()` function
  - No tests for game state transitions
  - No tests for edge cases (draw, invalid moves)

**Add Tests When**:
- Modifying game logic
- Changing state management
- Updating winning conditions

---

## 🔄 CI/CD Pipelines

Two GitHub Actions workflows:

### 1. Node.js CI (`.github/workflows/node-ci.yml`)
- **Triggers**: Push/PR to `main` branch
- **Matrix**: Tests across Node 18.x, 20.x
- **Steps**:
  - Checkout code
  - Setup Node.js
  - `yarn install`
  - `yarn build`
  - `yarn test:nowatch`
- **Purpose**: Validates build and test stability across Node versions

### 2. Azure Static Web Apps (`.github/workflows/azure-static-web-apps-green-water-03f091310.yml`)
- **Triggers**: Push to `main`, PR events (opened, synchronize, reopened, closed)
- **Features**:
  - Auto-deploys to Azure on push to main
  - Creates preview environments for open PRs
  - Auto-cleans up closed PRs
- **Secret**: `AZURE_STATIC_WEB_APPS_API_TOKEN_GREEN_WATER_03F091310`

---

## ✅ Code Quality & Linting

**Tool**: ESLint with React plugin (`.eslintrc.json`)

**Rules**:
- Warns on strict inequality (`eqeqeq: "warn"`)
- Warns on unused variables (`no-unused-vars: 1`)
- Warns on extra semicolons (`no-extra-semi: "warn"`)
- Allows console statements (`no-console: 0`)
- No TypeScript or strict type checking

**Run Linting**:
```bash
yarn build  # ESLint runs as part of build process
```

---

## 🐳 Docker Support

Two Docker configurations are available:

| Configuration | File | Purpose |
|--------------|------|---------|
| Development | [Dockerfile](Dockerfile) | Runs `yarn start` with hot reload on port 3000 |
| Production | [Dockerfile.prod](Dockerfile.prod) | Multi-stage build with nginx serving static files on port 80 |

### Development Usage
```bash
docker build -t react-tic-tac-toe .
docker run -p 3000:3000 react-tic-tac-toe
```

### Production Usage
```bash
docker build -f Dockerfile.prod -t react-tic-tac-toe-prod .
docker run -p 80:80 react-tic-tac-toe-prod
```

---

## 📦 Development Container

VS Code Remote Container support (`.devcontainer/`)

**Configuration** (`.devcontainer/devcontainer.json`):
- Base: VS Code JavaScript DevContainer (Node.js 14)
- **Extensions Pre-installed**:
  - ESLint
  - Docker
  - GitLens
  - Chrome Debugger
  - Edge Debugger
  - Firefox Debugger
- **Ports**: Automatically forwards port 3000
- **Post-create Command**: `yarn install --dev`

**VS Code Launch Configs** (`.vscode/launch.json`):
- Run `yarn start`, `yarn test`, `yarn build` from VS Code
- Debug in Chrome, Edge, or Firefox

---

## 🚢 Deployment Targets

### 1. GitHub Pages
- **Tool**: `gh-pages` package
- **Command**: `yarn gh-deploy` (runs `yarn gh-predeploy` first)
- **Output**: Deploys `build/` directory to GitHub Pages

### 2. Azure Static Web Apps
- **Method**: Automated via GitHub Actions workflow
- **Trigger**: Push to `main` branch
- **App Location**: `/`
- **Output Location**: `build/`

---

## ⚠️ Known Gaps & Limitations

**Current State** (Brutal Honesty):
- ❌ No TypeScript - plain JavaScript/JSX
- ❌ No comprehensive test suite for game logic
- ⚠️ React 17 - not latest React 18+
- ⚠️ Minimal test coverage - only 1 sample test
- ⚠️ No state management library (Redux, MobX, Context API, etc.)
- ⚠️ No API integration or backend
- ⚠️ Simple single-file architecture - not scaled for large applications
- ⚠️ Basic ESLint configuration - not strict rules

**Recommended Improvements**:
- Add comprehensive Jest tests for game logic
- Upgrade to React 18+ (consider new rendering patterns)
- Add TypeScript for type safety
- Consider state management for more complex features
- Implement keyboard navigation and accessibility improvements
- Add end-to-end testing (Cypress, Playwright)

---

## 🔧 Development Guidelines

### Adding Features
- **Follow existing patterns**: Use class components for stateful components (`Game`, `Board`)
- **State location**: `Game` component holds all game state
- **Presentational components**: `Board` and `Square` receive props, no local state
- **Immutable updates**: Use `slice()` and `concat()` for arrays (no direct mutation)

### Refactoring
- **Component separation**: Keep `Game` as state container, `Board` as renderer
- **Function extraction**: Logic like `calculateWinner` could be moved to separate utilities
- **State shape**: History array structure is crucial for time-travel feature

### Testing
- **Add tests for**: `calculateWinner()`, state transitions, edge cases
- **Use Jest**: Test framework is pre-configured via react-scripts
- **Test location**: Place in `src/` directory with `.test.js` extension

### Updating Dependencies
- **Test across**: Node 18.x, 20.x (CI matrix requirement)
- **Verify**: Build still succeeds, tests still pass
- **Check**: React 17 compatibility before upgrading to 18+

### Modifying Styles
- **File**: `src/index.css`
- **Key measurements**: Squares are 64x68px with 48px font
- **Layout**: Flexbox used for `.game` container
- **Browser support**: Century Gothic font with fallback to Futura, sans-serif

---

## 📝 Quick Reference

**Main Entry Point**: `src/index.js` → `ReactDOM.render(<Game />, document.getElementById("root"))`

**Winning Combinations** (in `calculateWinner`):
```
[0, 1, 2], [3, 4, 5], [6, 7, 8]  // Rows
[0, 3, 6], [1, 4, 7], [2, 5, 8]  // Columns
[0, 4, 8], [2, 4, 6]              // Diagonals
```

**State Transition Flow**:
```
User clicks square → handleClick(i) → 
Check winner/occupied → Update squares array → 
Add to history → setState → Re-render
```

---

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

---

## 📄 License

[MIT](https://choosealicense.com/licenses/mit/)

[License File](LICENSE)
