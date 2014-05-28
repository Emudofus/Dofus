package com.ankamagames.dofus.datacenter.communication
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class InfoMessage extends Object implements IDataCenter
   {
      
      public function InfoMessage() {
         super();
      }
      
      public static const MODULE:String = "InfoMessages";
      
      private static var _log:Logger;
      
      public static function getInfoMessageById(id:uint) : InfoMessage {
         var t:* = GameData.getObject(MODULE,id);
         var tt:* = GameData.getObject(MODULE,id) as InfoMessage;
         return GameData.getObject(MODULE,id) as InfoMessage;
      }
      
      public static function getInfoMessages() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var typeId:uint;
      
      public var messageId:uint;
      
      public var textId:uint;
      
      private var _text:String;
      
      public function get text() : String {
         if(!this._text)
         {
            this._text = I18n.getText(this.textId);
         }
         return this._text;
      }
   }
}
