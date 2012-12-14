package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.externalnotification.*;
    import com.ankamagames.dofus.externalnotification.enums.*;
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
            return ExternalNotificationManager.getInstance().canAddExternalNotification(param1);
        }// end function

        public function addExternalNotification(param1:int, param2:String, param3:String, param4:Object, param5:Boolean = false, param6:String = null, param7:Array = null) : String
        {
            var _loc_8:* = null;
            var _loc_9:* = new ExternalNotificationRequest(param1, ExternalNotificationManager.getInstance().clientId, ExternalNotificationManager.getInstance().otherClientsIds, param2, param5 ? (ExternalNotificationModeEnum.ALWAYS) : (ExternalNotificationManager.getInstance().showMode), param3, param4, ExternalNotificationManager.getInstance().notificationPlaySound(param1), ExternalNotificationManager.getInstance().notificationNotify(param1), param6, param7);
            ExternalNotificationManager.getInstance().handleNotificationRequest(_loc_9);
            _loc_8 = _loc_9.instanceId;
            return _loc_8;
        }// end function

        public function removeExternalNotification(param1:String, param2:Boolean = false) : void
        {
            var _loc_3:* = param1.split("#");
            ExternalNotificationManager.getInstance().closeExternalNotification(_loc_3[0], _loc_3[1], param2);
            return;
        }// end function

        public function resetExternalNotificationDisplayTimeout(param1:String) : void
        {
            var _loc_2:* = param1.split("#");
            ExternalNotificationManager.getInstance().resetNotificationDisplayTimeout(_loc_2[0], _loc_2[1]);
            return;
        }// end function

    }
}
