package com.ankamagames.dofus.datacenter.externalnotifications
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class ExternalNotification extends Object implements IDataCenter
   {
      
      public function ExternalNotification() {
         super();
      }
      
      public static const MODULE:String = "ExternalNotifications";
      
      protected static const _log:Logger;
      
      public static function getExternalNotificationById(pId:int) : ExternalNotification {
         return GameData.getObject(MODULE,pId) as ExternalNotification;
      }
      
      public static function getExternalNotifications() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var categoryId:int;
      
      public var iconId:int;
      
      public var colorId:int;
      
      public var descriptionId:uint;
      
      public var defaultEnable:Boolean;
      
      public var defaultSound:Boolean;
      
      public var defaultNotify:Boolean;
      
      public var defaultMultiAccount:Boolean;
      
      public var name:String;
      
      public var messageId:uint;
      
      private var _description:String;
      
      private var _message:String;
      
      public function get description() : String {
         if(!this._description)
         {
            this._description = I18n.getText(this.descriptionId);
         }
         return this._description;
      }
      
      public function get message() : String {
         if(!this._message)
         {
            this._message = I18n.getText(this.messageId);
         }
         return this._message;
      }
   }
}
