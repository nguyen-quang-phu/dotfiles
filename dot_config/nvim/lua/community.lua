-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
	"AstroNvim/astrocommunity",
	{ import = "astrocommunity.ai.sidekick-nvim" },
	{ import = "astrocommunity.colorscheme.catppuccin" },
	{ import = "astrocommunity.debugging.nvim-chainsaw" },
	{ import = "astrocommunity.editing-support.auto-save-nvim" },
	{ import = "astrocommunity.editing-support.mini-operators" },
	{ import = "astrocommunity.editing-support.refactoring-nvim" },
	{ import = "astrocommunity.editing-support.treesj" },
	{ import = "astrocommunity.file-explorer.yazi-nvim" },
	{ import = "astrocommunity.git.git-blame-nvim" },
	{ import = "astrocommunity.motion.mini-ai" },
	{ import = "astrocommunity.pack.biome" },
	{ import = "astrocommunity.pack.docker" },
	{ import = "astrocommunity.pack.eslint" },
	{ import = "astrocommunity.pack.html-css" },
	{ import = "astrocommunity.pack.json" },
	{ import = "astrocommunity.pack.just" },
	{ import = "astrocommunity.pack.lua" },
	{ import = "astrocommunity.pack.nix" },
	{ import = "astrocommunity.pack.oxlint" },
	{ import = "astrocommunity.pack.prettier" },
	{ import = "astrocommunity.pack.tailwindcss" },
	{ import = "astrocommunity.pack.typescript-all-in-one" },
	{ import = "astrocommunity.recipes.ai" },
	{ import = "astrocommunity.recipes.heirline-nvchad-statusline" },
	{ import = "astrocommunity.utility.noice-nvim" },
	-- import/override with your plugins folder
}
