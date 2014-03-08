package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationRequest;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationModeEnum;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class ExternalNotificationApi extends Object implements IApi
   {
      
      public function ExternalNotificationApi() {
         this._log = Log.getLogger(getQualifiedClassName(ExternalNotificationApi));
         super();
      }
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      public function set module(param1:UiModule) : void {
         this._module = param1;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function setMaxNotifications(param1:int) : void {
         ExternalNotificationManager.getInstance().setMaxNotifications(param1);
      }
      
      public function setNotificationsMode(param1:int) : void {
         ExternalNotificationManager.getInstance().setNotificationsMode(param1);
      }
      
      public function setDisplayDuration(param1:int) : void {
         ExternalNotificationManager.getInstance().setDisplayDuration(param1);
      }
      
      public function isExternalNotificationTypeIgnored(param1:int) : Boolean {
         return ExternalNotificationManager.getInstance().isExternalNotificationTypeIgnored(param1);
      }
      
      public function areExternalNotificationsEnabled() : Boolean {
         return ExternalNotificationManager.getInstance().notificationsEnabled;
      }
      
      public function getShowMode() : int {
         return ExternalNotificationManager.getInstance().showMode;
      }
      
      public function canAddExternalNotification(param1:int) : Boolean {
         return ExternalNotificationManager.getInstance().canAddExternalNotification(param1);
      }
      
      public function addExternalNotification(param1:int, param2:String, param3:String, param4:String, param5:String, param6:String, param7:int, param8:String, param9:String="normal", param10:String="p", param11:Object=null, param12:String="16011", param13:Boolean=false, param14:String=null, param15:Array=null) : String {
         var _loc16_:Object = 
            {
               "title":param4,
               "message":param5,
               "iconPath":param6,
               "icon":param7,
               "iconBg":param8,
               "css":param9,
               "cssClass":param10,
               "entityContactData":param11
            };
         var _loc17_:ExternalNotificationRequest = new ExternalNotificationRequest(param1,ExternalNotificationManager.getInstance().clientId,ExternalNotificationManager.getInstance().otherClientsIds,param2,param13?ExternalNotificationModeEnum.ALWAYS:ExternalNotificationManager.getInstance().showMode,param3,_loc16_,param12,ExternalNotificationManager.getInstance().notificationPlaySound(param1),ExternalNotificationManager.getInstance().notificationNotify(param1),param14,param15);
         ExternalNotificationManager.getInstance().handleNotificationRequest(_loc17_);
         return _loc17_.instanceId;
      }
      
      public function removeExternalNotification(param1:String, param2:Boolean=false) : void {
         var _loc3_:Array = param1.split("#");
         ExternalNotificationManager.getInstance().closeExternalNotification(_loc3_[0],_loc3_[1],param2);
      }
      
      public function resetExternalNotificationDisplayTimeout(param1:String) : void {
         var _loc2_:Array = param1.split("#");
         ExternalNotificationManager.getInstance().resetNotificationDisplayTimeout(_loc2_[0],_loc2_[1]);
      }
   }
}
