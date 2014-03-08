package com.ankamagames.dofus.datacenter.livingObjects
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class SpeakingItemText extends Object implements IDataCenter
   {
      
      public function SpeakingItemText() {
         super();
      }
      
      public static const MODULE:String = "SpeakingItemsText";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpeakingItemText));
      
      public static function getSpeakingItemTextById(id:int) : SpeakingItemText {
         return GameData.getObject(MODULE,id) as SpeakingItemText;
      }
      
      public static function getSpeakingItemsText() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var textId:int;
      
      public var textProba:Number;
      
      public var textStringId:uint;
      
      public var textLevel:int;
      
      public var textSound:int;
      
      public var textRestriction:String;
      
      private var _textString:String;
      
      public function get textString() : String {
         if(!this._textString)
         {
            this._textString = I18n.getText(this.textStringId);
         }
         return this._textString;
      }
   }
}
