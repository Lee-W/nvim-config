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
| Neovim ≥ 0.12.0 (LuaJIT; CI uses 0.12.5) | Required by [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter#requirements) and `diffopt=inline:char` |
| Git | Plugin manager bootstrap |
| Node.js + Yarn | Several LSP servers; build the Markdown preview server |
| Python 3 + `uv` | Python toolchain (ruff, basedpyright) |
| `fd` / `ripgrep` | File/content search |
| C compiler, `tree-sitter` CLI ≥ 0.26.1, `curl`, `tar` | Build/install Treesitter parsers; install the CLI through your system package manager |
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

Install the tools that this config expects outside Mason:

```bash
uv tool install basedpyright
uv tool install rumdl
```

Ensure these executables are on `PATH`. BasedPyright explicitly bypasses Mason;
Markdown formatting calls `rumdl`. Python debugging starts the adapter through
`uv`, which may download `debugpy` on first use. Install `pytest` and your project
dependencies in the project's virtualenv. Rust formatting requires `rustfmt`.

The optional Claude panel requires the `claude` CLI, and RiNG integration requires
the `ring` CLI. Use `:checkhealth` and `:ConformInfo` to diagnose missing tools.

### Key Mappings

`<leader>` is `Space`; `<localleader>` is `\`. Unless noted, these are normal-mode
keys. Buffer-local mappings (for example, in Diffview) take precedence.

| Key | Action |
|-----|--------|
| `<leader>e` | File explorer toggle |
| `<leader>us` | Spell check toggle |
| `<leader>ft` | Toggle the project-root terminal |
| `<C-/>` | Open/focus the project-root terminal; hide it when already focused (normal or terminal mode) |
| `<Esc><Esc>` | Leave terminal-input mode in Snacks terminals (other terminals use `<Esc>`) |
| `<leader>cn` | Symbol navigation (Navbuddy) |
| `<leader>cN` | Generate annotations/docstrings (Neogen) |
| `<leader>cs` | Code outline (Aerial) |
| `<C-P>` / `<leader>ff` | Find files in the current directory / project root |
| `<leader>/` | Search text across the project |
| `<leader>sr` | Search and replace across files (Grug Far) |
| `<leader>sR` | Resume the last Snacks picker |
| `gcc` | Toggle the current line's comment |
| `gc{motion}` / visual `gc` | Toggle comments over a motion / selection |
| `,v` / `<leader>cv` | Python venv selector (`<leader>cv` in Python buffers) |
| `gb` / `gB` | Next / previous buffer |
| `<leader>cf` | Format buffer / visual selection |
| `<leader>uf` / `<leader>uF` | Toggle autoformat globally / for the buffer |
| `<leader>cp` | Toggle browser Markdown preview (Markdown buffers) |
| `zR` / `zM` | Open / close all folds (UFO) |
| `<leader>db` | Toggle DAP breakpoint |
| `<leader>dc` | DAP continue |
| `<leader>tr` | Run nearest test |
| `<leader>tf` | Run test file |
| `<leader>td` | Debug nearest test |
| `<leader>ta` / `<leader>tl` | Run all tests under cwd / rerun the last test |
| `<leader>ts` / `<leader>tx` | Toggle test summary / stop tests |

Commenting uses Neovim's built-in `gc` mappings, enhanced by `ts-comments.nvim`.
For example, `gcap` comments a paragraph, `3gcc` comments three lines, and `Vjjgc`
comments a three-line selection. `gco` / `gcO` insert a comment below / above.
The backtick is a native mark jump again: `` `a `` jumps to mark `a`'s exact
position, while `'a` jumps to its line.

Use `<leader>sk` to search active keymaps, or `:verbose nmap <Space>cn` to find
which mapping owns a key. For visual-mode mappings, use `:verbose xmap gc`.

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
| basedpyright | Basic Python type checking (open files only); prefers the nearest `uv.lock` workspace and its `.venv` |
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
| venv-selector.nvim | Switch/cache Python virtualenvs with Snacks (`,v` / `<leader>cv`) |
| nvim-dap + nvim-dap-python | Python debugger; `uv` runs debugpy, selected `$VIRTUAL_ENV` runs the program |
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
| `<leader>af` / `<leader>ao` / `<leader>aq` | Focus / open / close Claude panel |
| `<leader>ar` / `<leader>aC` | Resume a selected session / continue the last session |
| `<leader>as` | Add buffer / send visual selection |
| `<leader>aa` / `<leader>ad` | Accept / deny diff |
| `<leader>am` | Select model |
| `<leader>ai` | Show Claude status |

In NvimTree, `<leader>as` adds the file under the cursor to Claude's context.

#### Git

| Plugin | Role |
|--------|------|
| vim-fugitive | Full git workflow |
| neogit | Interactive git TUI |
| diffview.nvim | Diff viewer, stacked panes by default |
| blame.nvim | Blame window (`<leader>gB`) and virtual text (`<leader>gV`) |
| git-conflict.nvim | Conflict resolution helpers |
| gitsigns.nvim | Gutter signs & hunk operations (`]c` / `[c`, `]h` / `[h`) |

Diffview workflow:

| Key / command | Action |
|---------------|--------|
| `<leader>gvv` | Review working-tree changes |
| `<leader>gvb` | Review the branch against its upstream (or origin) base |
| `<leader>gvf` / `<leader>gvF` | File history for the current file / the whole repo |
| `<leader>gvq` | Close Diffview |
| `<leader>b` / `:DiffviewToggleFiles` | Hide or show the file panel |
| `<leader>e` | Show and focus the file panel |
| `<Tab>` / `<S-Tab>` | Open the next / previous changed file |
| `]c` / `[c` | Jump to the next / previous change; git hunks outside a diff window |
| `gw` | Toggle wrap in both diff panes at once |
| `<C-f>` / `<C-b>` | From the file panel, scroll the diff without leaving it |
| `g<C-x>` | Cycle diff layouts |

`<leader>gvb` tries `upstream/HEAD`, `origin/HEAD`, `origin/main`, then `origin/master`.
If none exists, it warns and falls back to `HEAD~1`. This branch comparison uses
`--imply-local`, so the HEAD side shows editable working-tree files with LSP support.
`<leader>gvv` compares the index with the working tree. File history opens historical
revisions; use `gf` on a diff to open the local file when you want to edit it.

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
| ring.nvim | RiNG waiting-session count in the status line, plus a notification when one starts waiting |
| bufferline.nvim | Buffer tabs |
| snacks.nvim | Project-root terminal (`<leader>ft` toggles; `<C-/>` opens/focuses) |
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
| ts-comments.nvim / built-in `gc` | Comment lines (`gcc`), motions (`gc{motion}`), or visual selections (`gc`) |
| neogen | Generate annotations/docstrings (`<leader>cN`) |

### Language Support

Enabled via LazyVim extras:

- Python, Rust, TypeScript, SQL, CMake
- Docker, Git, Markdown, JSON, TOML

Jinja2, Handlebars, YAML, and Just have additional local configuration.

### Configuration & Maintenance

| File | What to change |
|------|----------------|
| `lua/config/lazy.lua` | LazyVim extras and plugin-manager settings |
| `lua/config/options.lua` | Editor defaults, diff behavior, Python LSP and picker selection |
| `lua/config/keymaps.lua` | Global custom keymaps |
| `lua/config/autocmds.lua` | Filetype indentation and highlight overrides |
| `lua/plugins/*.lua` | Plugin options and plugin-specific keymaps |
| `lua/plugins/_disabled.lua` | Explicitly disabled plugins and retained old settings |
| `lazy-lock.json` | Exact plugin revisions |

Indentation defaults to four spaces; web/template filetypes use two. Makefiles
keep literal tabs. Autoformat is enabled by LazyVim; `:ConformInfo` shows the
formatters selected for the current buffer.

Background plugin update checks are disabled. Use `:Lazy update` deliberately,
review `lazy-lock.json`, then run `:TSUpdate` after a Treesitter update. To reproduce
the checked-in plugin versions, use `:Lazy restore` (also used in CI).

Run these checks from this repository after changing configuration:

```bash
stylua --check .
nvim --clean --headless -l scripts/check_lua.lua
nvim --headless "+lua local ok, err = pcall(dofile, 'scripts/check_config.lua'); if not ok then vim.api.nvim_err_writeln(err); vim.cmd('cquit 1') end" +qa
```

The smoke checks require installed plugins and check effective keymaps, virtualenv
options, filetype loading, and formatter configuration. They do not run external
language servers, tests, or Claude sessions end to end.

---

## 台灣漢語

### 系統需求

| 工具 | 用途 |
|------|------|
| Neovim ≥ 0.12.0（LuaJIT；CI 使用 0.12.5） | [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter#requirements) 與 `diffopt=inline:char` 所需版本 |
| Git | Plugin 管理器自動啟動 |
| Node.js + Yarn | 部分 LSP server 依賴，以及建置 Markdown 預覽伺服器 |
| Python 3 + `uv` | Python 工具鏈（ruff、basedpyright） |
| `fd` / `ripgrep` | 檔案與內容搜尋 |
| C 編譯器、`tree-sitter` CLI ≥ 0.26.1、`curl`、`tar` | 建置／安裝 Treesitter parser；CLI 請透過系統套件管理器安裝 |
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

另外安裝這份配置預期由 Mason 以外提供的工具：

```bash
uv tool install basedpyright
uv tool install rumdl
```

請確認執行檔都在 `PATH` 上。BasedPyright 已明確停用 Mason 安裝；Markdown
格式化使用 `rumdl`。Python 除錯透過 `uv` 啟動 adapter，第一次使用時可能下載
`debugpy`。`pytest` 與專案依賴請裝在專案的虛擬環境中；Rust 格式化需要 `rustfmt`。

Claude 面板需要另外安裝 `claude` CLI，RiNG 整合需要 `ring` CLI。
可用 `:checkhealth` 與 `:ConformInfo` 確認缺少哪些工具。

### 快捷鍵一覽

`<leader>` 是空白鍵，`<localleader>` 是 `\`。未特別註明時皆為 normal mode
快捷鍵；Diffview 等 buffer 的專用快捷鍵優先。

| 按鍵 | 功能 |
|------|------|
| `<leader>e` | 開關檔案總管 |
| `<leader>us` | 開關拼字檢查 |
| `<leader>ft` | 開關專案根目錄的終端機 |
| `<C-/>` | 開啟／聚焦專案根目錄的終端機，已聚焦時則隱藏（normal 或 terminal mode） |
| `<Esc><Esc>` | 在 Snacks 終端機中離開輸入模式（其他終端機使用 `<Esc>`） |
| `<leader>cn` | 符號導覽（Navbuddy） |
| `<leader>cN` | 產生型別註記／docstring（Neogen） |
| `<leader>cs` | 程式碼大綱（Aerial） |
| `<C-P>` / `<leader>ff` | 搜尋目前目錄／專案根目錄的檔案 |
| `<leader>/` | 搜尋整個專案的文字 |
| `<leader>sr` | 跨檔搜尋與取代（Grug Far） |
| `<leader>sR` | 繼續上一次 Snacks picker |
| `gcc` | 切換目前這行的註解 |
| `gc{motion}` / visual mode 的 `gc` | 切換動作範圍／選取範圍的註解 |
| `,v` / `<leader>cv` | Python 虛擬環境選擇器（`<leader>cv` 限 Python buffer） |
| `gb` / `gB` | 下一個 / 上一個 buffer |
| `<leader>cf` | 格式化 buffer／選取範圍 |
| `<leader>uf` / `<leader>uF` | 切換全域／目前 buffer 的自動格式化 |
| `<leader>cp` | 開關瀏覽器 Markdown 預覽（Markdown buffer） |
| `zR` / `zM` | 展開／收合所有摺疊（UFO） |
| `<leader>db` | 切換 DAP 中斷點 |
| `<leader>dc` | DAP 繼續執行 |
| `<leader>tr` | 執行最近的測試 |
| `<leader>tf` | 執行整個測試檔案 |
| `<leader>td` | 除錯最近的測試 |
| `<leader>ta` / `<leader>tl` | 執行目前目錄下所有測試／重跑上次測試 |
| `<leader>ts` / `<leader>tx` | 開關測試摘要／停止測試 |

註解使用 Neovim 內建的 `gc` 系列快捷鍵，搭配 `ts-comments.nvim` 改善語法判斷。
例如 `gcap` 註解一個段落、`3gcc` 註解三行、`Vjjgc` 註解選取的三行。
`gco`／`gcO` 在下方／上方插入註解。反引號已恢復原生 mark 跳轉：
`` `a `` 跳到 mark `a` 的精確位置，`'a` 則跳到該行。

可用 `<leader>sk` 搜尋目前快捷鍵，或用 `:verbose nmap <Space>cn` 查出按鍵由誰設定；
visual mode 的快捷鍵則用 `:verbose xmap gc` 查詢。

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
| basedpyright | Python 基本型別檢查（僅開啟中的檔案）；優先採用最近的 `uv.lock` workspace 與其 `.venv` |
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
| venv-selector.nvim | 透過 Snacks 切換／快取 Python 虛擬環境（`,v` / `<leader>cv`） |
| nvim-dap + nvim-dap-python | 由 `uv` 執行 debugpy，使用選定的 `$VIRTUAL_ENV` 執行受測程式 |
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
| `<leader>af` / `<leader>ao` / `<leader>aq` | 聚焦／開啟／關閉 Claude 面板 |
| `<leader>ar` / `<leader>aC` | 選擇 session 繼續／繼續上次 session |
| `<leader>as` | 加入目前 buffer / 傳送選取範圍 |
| `<leader>aa` / `<leader>ad` | 接受 / 拒絕 diff |
| `<leader>am` | 選擇模型 |
| `<leader>ai` | 顯示 Claude 狀態 |

在 NvimTree 中，`<leader>as` 會將游標所在的檔案加入 Claude 的上下文。

#### Git

| Plugin | 用途 |
|--------|------|
| vim-fugitive | 完整 git 工作流程 |
| neogit | 互動式 git TUI |
| diffview.nvim | diff 檢視器，預設上下堆疊 |
| blame.nvim | Blame 視窗（`<leader>gB`）與虛擬文字（`<leader>gV`） |
| git-conflict.nvim | 衝突解決輔助 |
| gitsigns.nvim | 行號欄 git 標記與 hunk 操作（`]c`／`[c`、`]h`／`[h`） |

Diffview 操作：

| 按鍵／命令 | 功能 |
|------------|------|
| `<leader>gvv` | 審閱工作目錄的變更 |
| `<leader>gvb` | 以 upstream（或 origin）為基準審閱整條 branch |
| `<leader>gvf`／`<leader>gvF` | 當前檔案／整個 repo 的檔案歷史 |
| `<leader>gvq` | 關閉 Diffview |
| `<leader>b`／`:DiffviewToggleFiles` | 隱藏或顯示檔案面板 |
| `<leader>e` | 顯示檔案面板並將焦點移入 |
| `<Tab>`／`<S-Tab>` | 開啟下一個／上一個變更檔案 |
| `]c`／`[c` | 跳到下一個／上一個變更；在 diff 視窗外則跳 git hunk |
| `gw` | 同時切換兩側 diff 的自動換行 |
| `<C-f>`／`<C-b>` | 游標留在檔案面板，直接捲動右側 diff |
| `g<C-x>` | 循環切換 diff 版面 |

`<leader>gvb` 依序嘗試 `upstream/HEAD`、`origin/HEAD`、`origin/main`、`origin/master`；
都不存在時會顯示警告並退回 `HEAD~1`。這個 branch 比較入口帶有 `--imply-local`，
HEAD 那一側會顯示可編輯的工作目錄檔案，並保留 LSP。
`<leader>gvv` 比較 index 與工作目錄；檔案歷史則開啟歷史版本，需要編輯時可在 diff 中
按 `gf` 開啟本機檔案。

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
| ring.nvim | 在狀態列顯示等待回應的 RiNG session 數量，並在有 session 開始等待時發出通知 |
| bufferline.nvim | buffer 分頁列 |
| snacks.nvim | 專案根目錄終端機（`<leader>ft` 開關；`<C-/>` 開啟／聚焦） |
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
| ts-comments.nvim / 內建 `gc` | 註解目前行（`gcc`）、動作範圍（`gc{motion}`）或選取範圍（`gc`） |
| neogen | 產生型別註記／docstring（`<leader>cN`） |

### 支援的語言

透過 LazyVim extras 啟用：

- Python、Rust、TypeScript、SQL、CMake
- Docker、Git、Markdown、JSON、TOML

Jinja2、Handlebars、YAML 與 Just 另有本機配置。

### 配置與維護

| 檔案 | 修改內容 |
|------|----------|
| `lua/config/lazy.lua` | LazyVim extras 與外掛管理器設定 |
| `lua/config/options.lua` | 編輯器預設值、diff 行為、Python LSP 與 picker 選擇 |
| `lua/config/keymaps.lua` | 全域自訂快捷鍵 |
| `lua/config/autocmds.lua` | 各 filetype 的縮排與顏色覆寫 |
| `lua/plugins/*.lua` | 外掛選項與專用快捷鍵 |
| `lua/plugins/_disabled.lua` | 明確停用的外掛與保留的舊設定 |
| `lazy-lock.json` | 外掛的固定版本 |

預設使用四格空白縮排，網頁／模板使用兩格；Makefile 保留 tab。
LazyVim 預設啟用自動格式化，可用 `:ConformInfo` 查看目前 buffer 選用的 formatter。

已停用背景外掛更新檢查。需要更新時執行 `:Lazy update`，檢查 `lazy-lock.json` 的變更，
並在更新 Treesitter 後執行 `:TSUpdate`。要還原至版本控制內的外掛版本，使用
`:Lazy restore`（CI 也使用這個命令）。

修改配置後，在 repo 根目錄執行：

```bash
stylua --check .
nvim --clean --headless -l scripts/check_lua.lua
nvim --headless "+lua local ok, err = pcall(dofile, 'scripts/check_config.lua'); if not ok then vim.api.nvim_err_writeln(err); vim.cmd('cquit 1') end" +qa
```

冒煙測試需要先安裝外掛，會檢查實際生效的快捷鍵、虛擬環境選項、filetype 載入與
formatter 配置；不會完整執行外部 LSP、專案測試或 Claude session。
