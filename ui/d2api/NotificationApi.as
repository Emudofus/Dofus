package d2api
{
   public class NotificationApi extends Object
   {
      
      public function NotificationApi() {
         super();
      }
      
      public function destroy() : void {
      }
      
      public function showNotification(pTitle:String, pContent:String, pType:uint = 0) : void {
      }
      
      public function prepareNotification(pTitle:String, pContent:String, pType:uint = 0, pNotificationName:String = "", pNotifyUser:Boolean = false) : uint {
         return 0;
      }
      
      public function addButtonToNotification(pId:uint, pTitle:String, pAction:String, pParams:Object = null, pForceClose:Boolean = false, pWidth:Number = 0, pHeight:Number = 0, pType:String = "action") : void {
      }
      
      public function addCallbackToNotification(pId:uint, pAction:String, pParams:Object = null, pType:String = "action") : void {
      }
      
      public function addImageToNotification(pId:uint, pUrl:String, pX:Number = 0, pY:Number = 0, pWidth:Number = -1, pHeight:Number = -1, pLabel:String = "", pTips:String = "") : void {
      }
      
      public function addTimerToNotification(pId:uint, pTime:uint, pPauseOnOver:Boolean = false, pBlockCallbackOnClose:Boolean = false, pNotify:Boolean = true) : void {
      }
      
      public function sendNotification(notificationId:int = -1) : void {
      }
      
      public function clearAllNotification() : void {
      }
   }
}
