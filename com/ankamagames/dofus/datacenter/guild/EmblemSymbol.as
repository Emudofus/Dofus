package com.ankamagames.dofus.datacenter.guild
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class EmblemSymbol extends Object implements IDataCenter
   {
      
      public function EmblemSymbol() {
         super();
      }
      
      public static const MODULE:String = "EmblemSymbols";
      
      protected static const _log:Logger;
      
      public static function getEmblemSymbolById(id:int) : EmblemSymbol {
         return GameData.getObject(MODULE,id) as EmblemSymbol;
      }
      
      public static function getEmblemSymbols() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var iconId:int;
      
      public var skinId:int;
      
      public var order:int;
      
      public var categoryId:int;
      
      public var colorizable:Boolean;
   }
}
