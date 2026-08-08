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
| Neovim ≥ 0.11.2 | Editor runtime |
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
git clone https://github.com/Lee-W/nvim-config.git ~/.config/nvim

# Launch — lazy.nvim bootstraps itself on first run
nvim
```

### Key Mappings

| Key | Action |
|-----|--------|
| `<leader>e` | File explorer toggle |
| `<leader>us` | Spell check toggle |
| `<leader>ft` / `<C-/>` | Terminal toggle |
| `<leader>cn` | Symbol navigation (Navbuddy) |
| `<leader>cs` | Code outline (Aerial) |
| `<C-P>` | Fuzzy file search |
| `<leader>/` | Search text across the project |
| `<leader>sr` | Search and replace across files (Grug Far) |
| `<leader>sR` | Resume the last Snacks picker |
| `` ` `` | Toggle comment |
| `,v` | Python venv selector |
| `gb` / `gB` | Next / previous buffer |
| `<leader>db` | Toggle DAP breakpoint |
| `<leader>dc` | DAP continue |
| `<leader>tr` | Run nearest test |
| `<leader>tf` | Run test file |
| `<leader>td` | Debug nearest test |

### Project-wide Search

`<leader>` is `Space`. For everyday searching, use Snacks:

1. Press `<Space>/`.
2. Type the text to search for.
3. Select a result with `<C-N>` / `<C-P>` and press `<Enter>` to open it.

Append ripgrep options after ` -- ` to limit the files being searched (do not
quote the glob):

```text
windowCreationCommand -- -g=*.lua
useEffect -- -g=*.{ts,tsx}
TODO -- -g=!**/tests/**
```

Inside the picker, `<A-R>` toggles regular expressions, `<A-H>` includes hidden
files, and `<C-Q>` sends the results to the quickfix list.

Use `<Space>sr` only when a persistent search panel or cross-file replacement is
needed. Grug Far opens in a full-page tab and has these inputs:

- `Search`: text or regular expression to find.
- `Replacement`: replacement text; leave it empty for search only.
- `Files Filter`: file glob such as `*.lua` or `*.{ts,tsx}`. LazyVim initially
  fills this with the current file's extension; delete it to search all files.
- `Flags`: additional ripgrep flags such as `-i` or `-w`.
- `Paths`: directory to search, such as `lua/`.

Press `<Esc>` to run the search, `<Tab>` / `<S-Tab>` in normal mode to move
between inputs, and `<Enter>` on a result to open it. Press `\c` to close the
panel. If replacement text is present, `\r` applies the replacement.

### Plugin Overview

#### LSP & Language Tools

| Plugin | Role |
|--------|------|
| mason.nvim + mason-lspconfig | Language server installer |
| nvim-lspconfig | LSP client configuration |
| basedpyright | Basic Python type checking (diagnostics: open files only) |
| ruff | Python linting & formatting |
| jinja_lsp | Jinja2 template intellisense |
| yamlls + SchemaStore | YAML with schema validation |
| jsonls + SchemaStore | JSON with schema validation |
| taplo | TOML LSP |
| conform.nvim | Automatic formatting on save (Ruff, rustfmt, Prettier, rumdl) |
| nvim-navbuddy | Symbol navigation UI (`<leader>cn`) |

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
| nvim-tree.lua | File explorer (`<leader>e`) |
| aerial.nvim | Code outline (`<leader>cs`) |
| flash.nvim | Jump-to-anywhere motions |

#### UI

| Plugin | Role |
|--------|------|
| catppuccin (mocha) | Color scheme |
| lualine.nvim | Status line |
| ring.nvim | RiNG waiting-session count in the status line |
| bufferline.nvim | Buffer tabs |
| snacks.nvim | Project-root terminal (`<leader>ft` or `<C-/>`) |
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
| grug-far.nvim | Find & replace UI (`<leader>sr`) |
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
| Neovim ≥ 0.11.2 | 編輯器主體 |
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
git clone https://github.com/Lee-W/nvim-config.git ~/.config/nvim

# 啟動 Neovim，lazy.nvim 會自動初始化並安裝所有 plugin
nvim
```

### 快捷鍵一覽

| 按鍵 | 功能 |
|------|------|
| `<leader>e` | 開關檔案總管 |
| `<leader>us` | 開關拼字檢查 |
| `<leader>ft` / `<C-/>` | 開關終端機 |
| `<leader>cn` | 符號導覽（Navbuddy） |
| `<leader>cs` | 程式碼大綱（Aerial） |
| `<C-P>` | 模糊搜尋檔案 |
| `<leader>/` | 搜尋整個專案的文字 |
| `<leader>sr` | 跨檔搜尋與取代（Grug Far） |
| `<leader>sR` | 繼續上一次 Snacks picker |
| `` ` `` | 切換註解 |
| `,v` | Python 虛擬環境選擇器 |
| `gb` / `gB` | 下一個 / 上一個 buffer |
| `<leader>db` | 切換 DAP 中斷點 |
| `<leader>dc` | DAP 繼續執行 |
| `<leader>tr` | 執行最近的測試 |
| `<leader>tf` | 執行整個測試檔案 |
| `<leader>td` | 除錯最近的測試 |

### 專案全文搜尋

`<leader>` 是空白鍵。平常搜尋請使用 Snacks：

1. 按 `<Space>/`。
2. 輸入要搜尋的文字。
3. 用 `<C-N>` / `<C-P>` 選擇結果，再按 `<Enter>` 開啟。

若要限制搜尋的檔案，請在 ` -- ` 後面附加 ripgrep 選項（glob 不要加引號）：

```text
windowCreationCommand -- -g=*.lua
useEffect -- -g=*.{ts,tsx}
TODO -- -g=!**/tests/**
```

在 picker 裡，`<A-R>` 可切換正規表示式、`<A-H>` 可包含隱藏檔，`<C-Q>`
則會把結果送到 quickfix list。

只有需要保留搜尋面板或進行跨檔取代時，才使用 `<Space>sr`。Grug Far 會在
獨立的全頁 tab 開啟，欄位用途如下：

- `Search`：要尋找的文字或正規表示式。
- `Replacement`：取代文字；只搜尋時留白。
- `Files Filter`：檔案 glob，例如 `*.lua` 或 `*.{ts,tsx}`。LazyVim 一開始會
  自動填入目前檔案的副檔名；刪除即可搜尋所有檔案。
- `Flags`：額外的 ripgrep 選項，例如 `-i` 或 `-w`。
- `Paths`：搜尋目錄，例如 `lua/`。

按 `<Esc>` 執行搜尋；在 normal mode 用 `<Tab>` / `<S-Tab>` 切換欄位；移到
搜尋結果後按 `<Enter>` 開啟。按 `\c` 關閉面板；有填取代文字時，按 `\r`
執行取代。

### Plugin 說明

#### LSP 與程式輔助

| Plugin | 用途 |
|--------|------|
| mason.nvim + mason-lspconfig | Language server 安裝管理器 |
| nvim-lspconfig | LSP 客戶端設定 |
| basedpyright | Python 基本型別檢查（僅開啟中的檔案） |
| ruff | Python lint 與格式化 |
| jinja_lsp | Jinja2 模板補全 |
| yamlls + SchemaStore | YAML 含 schema 驗證 |
| jsonls + SchemaStore | JSON 含 schema 驗證 |
| taplo | TOML LSP |
| conform.nvim | 存檔時自動格式化（Ruff、rustfmt、Prettier、rumdl） |
| nvim-navbuddy | 符號導覽 UI（`<leader>cn`） |

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
| nvim-tree.lua | 檔案總管（`<leader>e`） |
| aerial.nvim | 程式碼大綱（`<leader>cs`） |
| flash.nvim | 跳躍動作，按字元標籤定位 |

#### 介面

| Plugin | 用途 |
|--------|------|
| catppuccin（mocha） | 色彩主題 |
| lualine.nvim | 狀態列 |
| ring.nvim | 在狀態列顯示等待回應的 RiNG session 數量 |
| bufferline.nvim | buffer 分頁列 |
| snacks.nvim | 專案根目錄終端機（`<leader>ft` 或 `<C-/>`） |
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
| grug-far.nvim | 尋找與取代 UI（`<leader>sr`） |
| ts-comments.nvim / 內建 `gc` | 切換註解（`` ` ``） |

### 支援的語言

透過 LazyVim extras 啟用：

- Python、Rust、TypeScript、SQL、CMake
- Docker、Git、Markdown、JSON、TOML
