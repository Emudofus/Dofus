package com.ankamagames.dofus.datacenter.communication
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   
   public class Smiley extends Object implements IDataCenter
   {
      
      public function Smiley() {
         super();
      }
      
      public static const MODULE:String = "Smileys";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Smiley));
      
      public static function getSmileyById(id:int) : Smiley {
         return GameData.getObject(MODULE,id) as Smiley;
      }
      
      public static function getSmileys() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
      
      public var order:uint;
      
      public var gfxId:String;
      
      public var forPlayers:Boolean;
      
      public var triggers:Vector.<String>;
   }
}
