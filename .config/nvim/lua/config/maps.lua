local key = vim.keymap

-- better up/down
key.set("n", "j", "gj")
key.set("n", "k", "gk")

-- focus window
key.set("n", "<A-left>", "<C-w>h")
key.set("n", "<A-down>", "<C-w>j")
key.set("n", "<A-up>", "<C-w>k")
key.set("n", "<A-right>", "<C-w>l")

-- resize window
key.set("n", "<S-Up>", "<cmd>resize +2<cr>")
key.set("n", "<S-Down>", "<cmd>resize -2<cr>")
key.set("n", "<S-Left>", "<cmd>vertical resize -2<cr>")
key.set("n", "<S-Right>", "<cmd>vertical resize +2<cr>")

-- improved indenting
key.set("v", "<", "<gv")
key.set("v", ">", ">gv")

-- windows
key.set("n", "<leader>ww", "<C-W>p", { desc = "other window" })
key.set("n", "<leader>wd", "<C-W>c", { desc = "delete window" })
key.set("n", "<leader>w-", "<C-W>s", { desc = "split window below" })
key.set("n", "<leader>w|", "<C-W>v", { desc = "split window right" })

--Misc QOL maps
key.set("n", "<c-a>", "ggVG", { desc = "Select all" })
key.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save" })
key.set("n", "<Leader><space>", ":nohl<CR>", { desc = "Clear search highlights" })
key.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "quit all" })

--Lazy and Misc plugin maps
key.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy UI" })
key.set("n", "<c-g>", "<cmd>lua _lazygit_toggle()<cr>", { desc = "Lazygit" })
