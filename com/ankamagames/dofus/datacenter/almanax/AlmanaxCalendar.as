package com.ankamagames.dofus.datacenter.almanax
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class AlmanaxCalendar extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var descId:uint;
        public var npcId:int;
        private var _name:String;
        private var _description:String;
        private static const MODULE:String = "AlmanaxCalendars";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AlmanaxCalendar));

        public function AlmanaxCalendar()
        {
            return;
        }// end function

        public function get bonusName() : String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            }
            return this._name;
        }// end function

        public function get bonusDescription() : String
        {
            if (!this._description)
            {
                this._description = I18n.getText(this.descId);
            }
            return this._description;
        }// end function

        public static function getAlmanaxCalendarById(param1:int) : AlmanaxCalendar
        {
            return GameData.getObject(MODULE, param1) as AlmanaxCalendar;
        }// end function

        public static function getAlmanaxCalendars() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
