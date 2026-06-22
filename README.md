# Neovim Config

A personal Neovim configuration built on [LazyVim](https://github.com/LazyVim/LazyVim), tuned for Python / Airflow development, with AI assistance via Claude Code.

---

## Table of Contents / 目錄

- [English](#english)
- [台灣漢語](#台灣漢語)

---

## English

### Requirements

| Tool | Purpose |
|------|---------|
| Neovim ≥ 0.10 | Editor runtime |
| Git | Plugin manager bootstrap |
| Node.js | Several LSP servers |
| Python 3 + `uv` | Python toolchain (ruff, basedpyright) |
| `fd` / `ripgrep` | File/content search |
| A [Nerd Font](https://www.nerdfonts.com/) | Icons |

### Installation

```bash
# Back up existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone
git clone https://github.com/<your-username>/nvim-config ~/.config/nvim

# Launch — lazy.nvim bootstraps itself on first run
nvim
```

### Key Mappings

| Key | Action |
|-----|--------|
| `<F2>` | File explorer toggle |
| `<F7>` | Spell check toggle |
| `<F8>` | Terminal toggle |
| `<F9>` | Symbol navigation (Navbuddy) |
| `<F10>` | Code outline (Aerial) |
| `<C-P>` | Fuzzy file search |
| `` ` `` | Toggle comment |
| `,v` | Python venv selector |
| `gb` / `gB` | Next / previous buffer |
| `<leader>db` | Toggle DAP breakpoint |
| `<leader>dc` | DAP continue |
| `<leader>tr` | Run nearest test |
| `<leader>tf` | Run test file |
| `<leader>td` | Debug nearest test |

### Plugin Overview

#### LSP & Language Tools

| Plugin | Role |
|--------|------|
| mason.nvim + mason-lspconfig | Language server installer |
| nvim-lspconfig | LSP client configuration |
| basedpyright | Python type checking (diagnostics: open files only) |
| ruff | Python linting & formatting |
| jinja_lsp | Jinja2 template intellisense |
| yamlls + SchemaStore | YAML with schema validation |
| jsonls + SchemaStore | JSON with schema validation |
| taplo | TOML LSP |
| conform.nvim | Format-on-demand (ruff → rustfmt → prettier → rumdl) |
| nvim-navbuddy | Symbol navigation UI (`<F9>`) |

#### Python / Airflow Toolchain

| Plugin | Role |
|--------|------|
| venv-selector.nvim | Switch Python virtualenvs (`,v`) |
| nvim-dap + nvim-dap-python | Python debugger with `$VIRTUAL_ENV` support |
| nvim-dap-ui | Debugger UI |
| neotest + neotest-python | Run/debug pytest from inside nvim |
| vim-dadbod + UI | SQL client — useful for querying Airflow metadata DB |
| Vim-Jinja2-Syntax | Jinja2 syntax highlighting (DAG templates) |

#### AI

| Plugin | Role |
|--------|------|
| claudecode.nvim | Claude Code terminal integration |

Key shortcuts (`<leader>a`):

| Key | Action |
|-----|--------|
| `<leader>ac` | Toggle Claude panel |
| `<leader>as` | Add buffer / send visual selection |
| `<leader>aa` / `<leader>ad` | Accept / deny diff |
| `<leader>am` | Select model |

#### Git

| Plugin | Role |
|--------|------|
| vim-fugitive | Full git workflow |
| neogit | Interactive git TUI |
| diffview.nvim | Side-by-side diff viewer |
| blame.nvim | Blame window (`<leader>gB`) and virtual text (`<leader>gV`) |
| git-conflict.nvim | Conflict resolution helpers |
| gitsigns.nvim | Gutter signs & hunk operations |

#### Fuzzy Finding & Navigation

| Plugin | Role |
|--------|------|
| snacks.nvim | Primary file/buffer/grep picker (`<C-P>`) |
| fzf-lua | Secondary picker used by integrations |
| nvim-tree.lua | File explorer (`<F2>`) |
| aerial.nvim | Code outline (`<F10>`) |
| flash.nvim | Jump-to-anywhere motions |

#### UI

| Plugin | Role |
|--------|------|
| catppuccin (mocha) | Color scheme |
| lualine.nvim | Status line |
| bufferline.nvim | Buffer tabs |
| toggleterm.nvim | Terminal toggle (`<F8>`) |
| noice.nvim | Prettier command-line / notifications |
| nvim-ufo | Code folding with preview |
| render-markdown.nvim | In-editor Markdown rendering |
| rainbow-delimiters | Rainbow bracket colors |

#### Editing

| Plugin | Role |
|--------|------|
| blink.cmp | Completion engine |
| LuaSnip | Snippet engine |
| mini.surround | Surround text objects |
| mini.ai | Extended text objects |
| yanky.nvim | Yank ring |
| grug-far.nvim | Find & replace UI (`<leader>sR`) |
| ts-comments.nvim / built-in `gc` | Toggle comment (`` ` ``) |

### Language Support

Enabled via LazyVim extras:

- Python, Rust, TypeScript, SQL, CMake
- Docker, Git, Markdown, JSON, TOML

---

## 台灣漢語

### 系統需求

| 工具 | 用途 |
|------|------|
| Neovim ≥ 0.10 | 編輯器主體 |
| Git | Plugin 管理器自動啟動 |
| Node.js | 部分 LSP server 依賴 |
| Python 3 + `uv` | Python 工具鏈（ruff、basedpyright） |
| `fd` / `ripgrep` | 檔案與內容搜尋 |
| [Nerd Font](https://www.nerdfonts.com/) | 圖示顯示 |

### 安裝方式

```bash
# 備份現有設定
mv ~/.config/nvim ~/.config/nvim.bak

# 下載設定
git clone https://github.com/<your-username>/nvim-config ~/.config/nvim

# 啟動 Neovim，lazy.nvim 會自動初始化並安裝所有 plugin
nvim
```

### 快捷鍵一覽

| 按鍵 | 功能 |
|------|------|
| `<F2>` | 開關檔案總管 |
| `<F7>` | 開關拼字檢查 |
| `<F8>` | 開關終端機 |
| `<F9>` | 符號導覽（Navbuddy） |
| `<F10>` | 程式碼大綱（Aerial） |
| `<C-P>` | 模糊搜尋檔案 |
| `` ` `` | 切換註解 |
| `,v` | Python 虛擬環境選擇器 |
| `gb` / `gB` | 下一個 / 上一個 buffer |
| `<leader>db` | 切換 DAP 中斷點 |
| `<leader>dc` | DAP 繼續執行 |
| `<leader>tr` | 執行最近的測試 |
| `<leader>tf` | 執行整個測試檔案 |
| `<leader>td` | 除錯最近的測試 |

### Plugin 說明

#### LSP 與程式輔助

| Plugin | 用途 |
|--------|------|
| mason.nvim + mason-lspconfig | Language server 安裝管理器 |
| nvim-lspconfig | LSP 客戶端設定 |
| basedpyright | Python 型別檢查（僅開啟中的檔案） |
| ruff | Python lint 與格式化 |
| jinja_lsp | Jinja2 模板補全 |
| yamlls + SchemaStore | YAML 含 schema 驗證 |
| jsonls + SchemaStore | JSON 含 schema 驗證 |
| taplo | TOML LSP |
| conform.nvim | 手動格式化（ruff → rustfmt → prettier → rumdl） |
| nvim-navbuddy | 符號導覽 UI（`<F9>`） |

#### Python / Airflow 開發工具

| Plugin | 用途 |
|--------|------|
| venv-selector.nvim | 切換 Python 虛擬環境（`,v`） |
| nvim-dap + nvim-dap-python | Python 除錯器，自動偵測 `$VIRTUAL_ENV` |
| nvim-dap-ui | 除錯器圖形介面 |
| neotest + neotest-python | 在編輯器內執行 / 除錯 pytest |
| vim-dadbod + UI | SQL 客戶端，可直接查詢 Airflow metadata DB |
| Vim-Jinja2-Syntax | Jinja2 語法高亮（DAG 模板使用） |

#### AI 輔助

| Plugin | 用途 |
|--------|------|
| claudecode.nvim | Claude Code 終端機整合 |

快捷鍵（`<leader>a` 命名空間）：

| 按鍵 | 功能 |
|------|------|
| `<leader>ac` | 開關 Claude 面板 |
| `<leader>as` | 加入目前 buffer / 傳送選取範圍 |
| `<leader>aa` / `<leader>ad` | 接受 / 拒絕 diff |
| `<leader>am` | 選擇模型 |

#### Git

| Plugin | 用途 |
|--------|------|
| vim-fugitive | 完整 git 工作流程 |
| neogit | 互動式 git TUI |
| diffview.nvim | 並排 diff 檢視器 |
| blame.nvim | Blame 視窗（`<leader>gB`）與虛擬文字（`<leader>gV`） |
| git-conflict.nvim | 衝突解決輔助 |
| gitsigns.nvim | 行號欄 git 標記與 hunk 操作 |

#### 模糊搜尋與導覽

| Plugin | 用途 |
|--------|------|
| snacks.nvim | 主要檔案 / buffer / grep 搜尋（`<C-P>`） |
| fzf-lua | integrations 使用的次要 picker |
| nvim-tree.lua | 檔案總管（`<F2>`） |
| aerial.nvim | 程式碼大綱（`<F10>`） |
| flash.nvim | 跳躍動作，按字元標籤定位 |

#### 介面

| Plugin | 用途 |
|--------|------|
| catppuccin（mocha） | 色彩主題 |
| lualine.nvim | 狀態列 |
| bufferline.nvim | buffer 分頁列 |
| toggleterm.nvim | 終端機開關（`<F8>`） |
| noice.nvim | 命令列與通知美化 |
| nvim-ufo | 程式碼摺疊與預覽 |
| render-markdown.nvim | 編輯器內 Markdown 渲染 |
| rainbow-delimiters | 彩虹括號 |

#### 編輯

| Plugin | 用途 |
|--------|------|
| blink.cmp | 補全引擎 |
| LuaSnip | Snippet 引擎 |
| mini.surround | 包圍文字操作 |
| mini.ai | 擴充文字物件 |
| yanky.nvim | 複製歷史環 |
| grug-far.nvim | 尋找與取代 UI（`<leader>sR`） |
| ts-comments.nvim / 內建 `gc` | 切換註解（`` ` ``） |

### 支援的語言

透過 LazyVim extras 啟用：

- Python、Rust、TypeScript、SQL、CMake
- Docker、Git、Markdown、JSON、TOML
