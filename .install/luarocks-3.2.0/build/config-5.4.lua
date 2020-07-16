-- LuaRocks configuration

rocks_trees = {
   { name = "user", root = home .. "/.luarocks" };
   { name = "system", root = "/home/runner/work/JoelEllis/JoelEllis/.luarocks" };
}
lua_interpreter = "lua";
variables = {
   LUA_DIR = "/home/runner/work/JoelEllis/JoelEllis/.lua";
   LUA_BINDIR = "/home/runner/work/JoelEllis/JoelEllis/.lua/bin";
}
