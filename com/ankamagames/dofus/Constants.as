package com.ankamagames.dofus
{
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.cache.Cache;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   
   public class Constants extends Object
   {
      
      public function Constants() {
         super();
      }
      
      public static const SIGNATURE_KEY_DATA:Class;
      
      public static const LOG_UPLOAD_MODE:Boolean = false;
      
      public static var EVENT_MODE:Boolean = true;
      
      public static var EVENT_MODE_PARAM:String = "";
      
      public static var CHARACTER_CREATION_ALLOWED:Boolean = true;
      
      public static var FORCE_MAXIMIZED_WINDOW:Boolean = true;
      
      public static const DATASTORE_COMPUTER_OPTIONS:DataStoreType;
      
      public static const DATASTORE_LANG_VERSION:DataStoreType;
      
      public static const DATASTORE_CONSOLE_CMD:DataStoreType;
      
      public static const DATASTORE_MODULE_DEBUG:DataStoreType;
      
      public static const DATASTORE_TCHAT:DataStoreType;
      
      public static const DATASTORE_TCHAT_PRIVATE:DataStoreType;
      
      public static const SCRIPT_CACHE:Cache;
      
      public static const PRE_GAME_MODULE:Array;
      
      public static const COMMON_GAME_MODULE:Array;
      
      public static const ADMIN_MODULE:Array;
      
      public static const DETERMINIST_TACKLE:Boolean = true;
   }
}
