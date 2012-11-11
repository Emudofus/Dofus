package com.ankamagames.dofus.datacenter.notifications
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class Notification extends Object implements IDataCenter
    {
        public var id:int;
        public var titleId:uint;
        public var messageId:uint;
        public var iconId:int;
        public var typeId:int;
        public var trigger:String;
        private var _title:String;
        private var _message:String;
        private static const MODULE:String = "Notifications";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Notification));

        public function Notification()
        {
            return;
        }// end function

        public function get title() : String
        {
            if (!this._title)
            {
                this._title = I18n.getText(this.titleId);
            }
            return this._title;
        }// end function

        public function get message() : String
        {
            if (!this._message)
            {
                this._message = I18n.getText(this.messageId);
            }
            return this._message;
        }// end function

        public static function getNotificationById(param1:int) : Notification
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

        public static function getNotifications() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
