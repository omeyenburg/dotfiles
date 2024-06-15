# Java language server (JTDLS)
1. Download jdtls at https://download.eclipse.org/jdtls/milestones as a tar.gz, unpack it and save it somewhere. Newer versions might be buggy, 1.9.0 works fine.
2. Install https://github.com/mfussenegger/nvim-jdtls using any plugin manager
3. Create the file ~/.config/nvim/ftplugin/java.lua. This script is only executed if the file type (ft) matches java.
4. Insert and adjust the provided script at https://github.com/mfussenegger/nvim-jdtls?tab=readme-ov-file#configuration-verbose to match the location of eclipse.jdt.ls.
