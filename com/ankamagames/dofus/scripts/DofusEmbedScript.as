package com.ankamagames.dofus.scripts
{
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.script.BinaryScript;
   
   public class DofusEmbedScript extends Object
   {
      
      public function DofusEmbedScript() {
         super();
      }
      
      private static const SCRIPT_1_DATA:Class = DofusEmbedScript_SCRIPT_1_DATA;
      
      private static const SCRIPT_1_URI:String = "spellScripts/1.dx";
      
      private static const SCRIPT_2_DATA:Class = DofusEmbedScript_SCRIPT_2_DATA;
      
      private static const SCRIPT_2_URI:String = "spellScripts/2.dx";
      
      private static const SCRIPT_3_DATA:Class = DofusEmbedScript_SCRIPT_3_DATA;
      
      private static const SCRIPT_3_URI:String = "spellScripts/3.dx";
      
      private static const SCRIPT_5_DATA:Class = DofusEmbedScript_SCRIPT_5_DATA;
      
      private static const SCRIPT_5_URI:String = "spellScripts/5.dx";
      
      private static const SCRIPT_6_DATA:Class = DofusEmbedScript_SCRIPT_6_DATA;
      
      private static const SCRIPT_6_URI:String = "spellScripts/6.dx";
      
      private static const SCRIPT_7_DATA:Class = DofusEmbedScript_SCRIPT_7_DATA;
      
      private static const SCRIPT_7_URI:String = "spellScripts/7.dx";
      
      private static const _cache:Dictionary = new Dictionary();
      
      public static function getScript(id:uint) : BinaryScript {
         if(!_cache[id])
         {
            _cache[id] = new BinaryScript(new DofusEmbedScript["SCRIPT_" + id + "_DATA"](),DofusEmbedScript["SCRIPT_" + id + "_URI"]);
         }
         return _cache[id];
      }
   }
}
