package d2api
{
    public class ExternalNotificationApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function setMaxNotifications(pValue:int):void
        {
        }

        [Untrusted]
        public function setNotificationsMode(pValue:int):void
        {
        }

        [Untrusted]
        public function setDisplayDuration(pValueId:int):void
        {
        }

        [Untrusted]
        public function isExternalNotificationTypeIgnored(pExternalNotificationType:int):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function areExternalNotificationsEnabled():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getShowMode():int
        {
            return (0);
        }

        [Untrusted]
        public function canAddExternalNotification(pExternalNotificationType:int):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function addExternalNotification(pNotificationType:int, pId:String, pUiName:String, pTitle:String, pMessage:String, pIconPath:String, pIconId:int, pIconBg:String, pCss:String="normal", pCssClass:String="p", pEntityContactData:Object=null, pSoundId:String="16011", pAlwaysShow:Boolean=false, pHookName:String=null, pHookParams:Object=null):String
        {
            return (null);
        }

        [Untrusted]
        public function removeExternalNotification(pInstanceId:String, pActivateClientWindow:Boolean=false):void
        {
        }

        [Untrusted]
        public function resetExternalNotificationDisplayTimeout(pInstanceId:String):void
        {
        }


    }
}//package d2api

