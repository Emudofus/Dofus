package com.ankamagames.dofus.datacenter.sounds
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class SoundUi extends Object implements IDataCenter
   {
      
      public function SoundUi() {
         super();
      }
      
      public static var MODULE:String = "SoundUi";
      
      public static function getSoundUiById(id:uint) : SoundUi {
         var sb:SoundUi = GameData.getObject(MODULE,id) as SoundUi;
         return sb;
      }
      
      public static function getSoundUis() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
      
      public var uiName:String;
      
      public var openFile:String;
      
      public var closeFile:String;
      
      public var subElements:Vector.<SoundUiElement>;
   }
}
