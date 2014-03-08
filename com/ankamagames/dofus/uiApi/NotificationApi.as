package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.jerakine.types.Uri;
   
   public class NotificationApi extends Object implements IApi
   {
      
      public function NotificationApi() {
         super();
      }
      
      private static var _init:Boolean = false;
      
      private var _module:UiModule;
      
      public function set module(param1:UiModule) : void {
         this._module = param1;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function showNotification(param1:String, param2:String, param3:uint=0) : void {
         NotificationManager.getInstance().showNotification(param1,param2,param3);
      }
      
      public function prepareNotification(param1:String, param2:String, param3:uint=0, param4:String="", param5:Boolean=false) : uint {
         return NotificationManager.getInstance().prepareNotification(param1,param2,param3,param4,param5);
      }
      
      public function addButtonToNotification(param1:uint, param2:String, param3:String, param4:Object=null, param5:Boolean=false, param6:Number=0, param7:Number=0, param8:String="action") : void {
         NotificationManager.getInstance().addButtonToNotification(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public function addCallbackToNotification(param1:uint, param2:String, param3:Object=null, param4:String="action") : void {
         NotificationManager.getInstance().addCallbackToNotification(param1,param2,param3,param4);
      }
      
      public function addImageToNotification(param1:uint, param2:String, param3:Number=0, param4:Number=0, param5:Number=-1, param6:Number=-1, param7:String="", param8:String="") : void {
         var _loc9_:Uri = new Uri(param2);
         NotificationManager.getInstance().addImageToNotification(param1,_loc9_,param3,param4,param5,param6,param7,param8);
      }
      
      public function addTimerToNotification(param1:uint, param2:uint, param3:Boolean=false, param4:Boolean=false, param5:Boolean=true) : void {
         NotificationManager.getInstance().addTimerToNotification(param1,param2,param3,param4,param5);
      }
      
      public function sendNotification(param1:int=-1) : void {
         NotificationManager.getInstance().sendNotification(param1);
      }
      
      public function clearAllNotification() : void {
         NotificationManager.getInstance().clearAllNotification();
      }
   }
}
