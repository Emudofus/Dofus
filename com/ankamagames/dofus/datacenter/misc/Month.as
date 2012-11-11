package com.ankamagames.dofus.datacenter.misc
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class Month extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        private var _name:String;
        private static const MODULE:String = "Months";
        private static var _log:Logger = Log.getLogger(getQualifiedClassName(Month));

        public function Month()
        {
            return;
        }// end function

        public function get name() : String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            }
            return this._name;
        }// end function

        public static function getMonthById(param1:int) : Month
        {
            return GameData.getObject(MODULE, param1) as Month;
        }// end function

        public static function getMonths() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
