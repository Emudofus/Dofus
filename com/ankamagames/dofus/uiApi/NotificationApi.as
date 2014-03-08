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
      
      public function set module(value:UiModule) : void {
         this._module = value;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function showNotification(pTitle:String, pContent:String, pType:uint=0) : void {
         NotificationManager.getInstance().showNotification(pTitle,pContent,pType);
      }
      
      public function prepareNotification(pTitle:String, pContent:String, pType:uint=0, pNotificationName:String="", pNotifyUser:Boolean=false) : uint {
         return NotificationManager.getInstance().prepareNotification(pTitle,pContent,pType,pNotificationName,pNotifyUser);
      }
      
      public function addButtonToNotification(pId:uint, pTitle:String, pAction:String, pParams:Object=null, pForceClose:Boolean=false, pWidth:Number=0, pHeight:Number=0, pType:String="action") : void {
         NotificationManager.getInstance().addButtonToNotification(pId,pTitle,pAction,pParams,pForceClose,pWidth,pHeight,pType);
      }
      
      public function addCallbackToNotification(pId:uint, pAction:String, pParams:Object=null, pType:String="action") : void {
         NotificationManager.getInstance().addCallbackToNotification(pId,pAction,pParams,pType);
      }
      
      public function addImageToNotification(pId:uint, pUrl:String, pX:Number=0, pY:Number=0, pWidth:Number=-1, pHeight:Number=-1, pLabel:String="", pTips:String="") : void {
         var pUri:Uri = new Uri(pUrl);
         NotificationManager.getInstance().addImageToNotification(pId,pUri,pX,pY,pWidth,pHeight,pLabel,pTips);
      }
      
      public function addTimerToNotification(pId:uint, pTime:uint, pPauseOnOver:Boolean=false, pBlockCallbackOnClose:Boolean=false, pNotify:Boolean=true) : void {
         NotificationManager.getInstance().addTimerToNotification(pId,pTime,pPauseOnOver,pBlockCallbackOnClose,pNotify);
      }
      
      public function sendNotification(notificationId:int=-1) : void {
         NotificationManager.getInstance().sendNotification(notificationId);
      }
      
      public function clearAllNotification() : void {
         NotificationManager.getInstance().clearAllNotification();
      }
   }
}
