-- local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
-- local workspace_dir = vim.fn.expand("~/Dev/personal/") .. project_name

local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local config = {
	cmd = {
		-- vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls"),
		"java", -- or '/path/to/java17_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/lombok.jar"),
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- 💀
		"-jar",
		-- "/home/energia/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_VERSION_NUMBER.jar",
		"/home/energia/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar",
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
		-- Must point to the                                                     Change this to
		-- eclipse.jdt.ls installation                                           the actual version

		-- 💀
		"-configuration",
		"/home/energia/.local/share/nvim/mason/packages/jdtls/config_linux",
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
		-- Must point to the                      Change to one of `linux`, `win` or `mac`
		-- eclipse.jdt.ls installation            Depending on your system.

		-- 💀
		-- See `data directory configuration` section in the README
		"-data",
		vim.fn.expand("~/.cache/jdtls-workspace/") .. workspace_dir,
	},
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
}

require("jdtls").start_or_attach(config)
