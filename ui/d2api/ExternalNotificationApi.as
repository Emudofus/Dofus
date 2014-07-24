package d2api
{
   public class ExternalNotificationApi extends Object
   {
      
      public function ExternalNotificationApi() {
         super();
      }
      
      public function destroy() : void {
      }
      
      public function setMaxNotifications(pValue:int) : void {
      }
      
      public function setNotificationsMode(pValue:int) : void {
      }
      
      public function setDisplayDuration(pValueId:int) : void {
      }
      
      public function isExternalNotificationTypeIgnored(pExternalNotificationType:int) : Boolean {
         return false;
      }
      
      public function areExternalNotificationsEnabled() : Boolean {
         return false;
      }
      
      public function getShowMode() : int {
         return 0;
      }
      
      public function canAddExternalNotification(pExternalNotificationType:int) : Boolean {
         return false;
      }
      
      public function addExternalNotification(pNotificationType:int, pId:String, pUiName:String, pTitle:String, pMessage:String, pIconPath:String, pIconId:int, pIconBg:String, pCss:String = "normal", pCssClass:String = "p", pEntityContactData:Object = null, pSoundId:String = "16011", pAlwaysShow:Boolean = false, pHookName:String = null, pHookParams:Object = null) : String {
         return null;
      }
      
      public function removeExternalNotification(pInstanceId:String, pActivateClientWindow:Boolean = false) : void {
      }
      
      public function resetExternalNotificationDisplayTimeout(pInstanceId:String) : void {
      }
   }
}
