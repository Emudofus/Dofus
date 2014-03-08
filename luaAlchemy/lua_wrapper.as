package luaAlchemy
{
   import cmodule.lua_wrapper.CLibInit;
   
   public class lua_wrapper extends Object
   {
      
      public function lua_wrapper() {
         super();
      }
      
      protected static const _lib_init:CLibInit = new CLibInit();
      
      protected static const _lib = _lib_init.init();
      
      public static function luaInitializeState() : uint {
         return _lib.luaInitializeState();
      }
      
      public static function luaClose(param1:uint) : void {
         _lib.luaClose(param1);
      }
      
      public static function doFile(param1:uint, param2:*) : Array {
         return _lib.doFile(param1,param2);
      }
      
      public static function doFileAsync(param1:Function, param2:uint, param3:*) : void {
         _lib.doFileAsync(param1,param2,param3);
      }
      
      public static function luaDoString(param1:uint, param2:*) : Array {
         return _lib.luaDoString(param1,param2);
      }
      
      public static function luaDoStringAsync(param1:Function, param2:uint, param3:*) : void {
         _lib.luaDoStringAsync(param1,param2,param3);
      }
      
      public static function setGlobal(param1:uint, param2:String, param3:*) : void {
         _lib.setGlobal(param1,param2,param3);
      }
      
      public static function setGlobalLuaValue(param1:uint, param2:String, param3:*) : void {
         _lib.setGlobalLuaValue(param1,param2,param3);
      }
      
      public static function callGlobal(param1:uint, param2:*, param3:Array) : Array {
         return _lib.callGlobal(param1,param2,param3);
      }
   }
}
