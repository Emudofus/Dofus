package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.externalnotification.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class ExternalNotificationApi extends Object implements IApi
    {
        protected var _log:Logger;
        private var _module:UiModule;

        public function ExternalNotificationApi()
        {
            this._log = Log.getLogger(getQualifiedClassName());
            return;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            return;
        }// end function

        public function getWindowWidth() : Number
        {
            return ExternalNotificationManager.getInstance().windowWidth;
        }// end function

        public function getWindowHeight() : Number
        {
            return ExternalNotificationManager.getInstance().windowHeight;
        }// end function

        public function setMaxNotifications(param1:int) : void
        {
            ExternalNotificationManager.getInstance().setMaxNotifications(param1);
            return;
        }// end function

        public function setNotificationsMode(param1:int) : void
        {
            ExternalNotificationManager.getInstance().setNotificationsMode(param1);
            return;
        }// end function

        public function setDisplayDuration(param1:int) : void
        {
            ExternalNotificationManager.getInstance().setDisplayDuration(param1);
            return;
        }// end function

        public function isExternalNotificationTypeIgnored(param1:int) : Boolean
        {
            return ExternalNotificationManager.getInstance().isExternalNotificationTypeIgnored(param1);
        }// end function

        public function areExternalNotificationsEnabled() : Boolean
        {
            return ExternalNotificationManager.getInstance().notificationsEnabled;
        }// end function

        public function canAddExternalNotification(param1:int) : Boolean
        {
            return this.areExternalNotificationsEnabled() && !this.isExternalNotificationTypeIgnored(param1);
        }// end function

        public function addExternalNotification(param1:int, param2:String, param3:String, param4:int, param5:String, param6:String, param7:String = "normal", param8:String = "p") : void
        {
            var _loc_9:* = null;
            if (this.canAddExternalNotification(param1))
            {
                _loc_9 = new ExternalNotificationRequest(param1, ExternalNotificationManager.getInstance().clientId, param2, ExternalNotificationManager.getInstance().showMode, param3, param4, param5, param6, param7, param8);
                ExternalNotificationManager.getInstance().handleNotificationRequest(_loc_9);
            }
            return;
        }// end function

        public function removeExternalNotification(param1:String) : void
        {
            var _loc_2:* = param1.split("#");
            ExternalNotificationManager.getInstance().closeExternalNotification(_loc_2[0], _loc_2[1]);
            return;
        }// end function

        public function activateClientWindow(param1:String) : void
        {
            var _loc_2:* = param1.split("#");
            ExternalNotificationManager.getInstance().closeExternalNotification(_loc_2[0], _loc_2[1], true);
            return;
        }// end function

    }
}
