package com.ankamagames.dofus.datacenter.externalnotifications
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class ExternalNotification extends Object implements IDataCenter
    {
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
        private static const MODULE:String = "ExternalNotifications";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ExternalNotification));

        public function ExternalNotification()
        {
            return;
        }// end function

        public function get description() : String
        {
            if (!this._description)
            {
                this._description = I18n.getText(this.descriptionId);
            }
            return this._description;
        }// end function

        public function get message() : String
        {
            if (!this._message)
            {
                this._message = I18n.getText(this.messageId);
            }
            return this._message;
        }// end function

        public static function getExternalNotificationById(param1:int) : ExternalNotification
        {
            return GameData.getObject(MODULE, param1) as ExternalNotification;
        }// end function

        public static function getExternalNotifications() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
