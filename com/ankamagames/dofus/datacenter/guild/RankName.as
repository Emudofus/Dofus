package com.ankamagames.dofus.datacenter.guild
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class RankName extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var order:int;
        private var _name:String;
        private static const MODULE:String = "RankNames";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(RankName));

        public function RankName()
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

        public static function getRankNameById(param1:int) : RankName
        {
            return GameData.getObject(MODULE, param1) as RankName;
        }// end function

        public static function getRankNames() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
