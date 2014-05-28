package com.ankamagames.dofus.datacenter.npcs
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class NpcMessage extends Object implements IDataCenter
   {
      
      public function NpcMessage() {
         super();
      }
      
      protected static const _log:Logger;
      
      public static const MODULE:String = "NpcMessages";
      
      public static function getNpcMessageById(id:int) : NpcMessage {
         return GameData.getObject(MODULE,id) as NpcMessage;
      }
      
      public var id:int;
      
      public var messageId:uint;
      
      private var _messageText:String;
      
      public function get message() : String {
         if(!this._messageText)
         {
            this._messageText = I18n.getText(this.messageId);
         }
         return this._messageText;
      }
   }
}
