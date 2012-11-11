package com.ankamagames.dofus.datacenter.houses
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class House extends Object implements IDataCenter
    {
        public var typeId:int;
        public var defaultPrice:uint;
        public var nameId:int;
        public var descriptionId:int;
        public var gfxId:int;
        private var _name:String;
        private var _description:String;
        private static const MODULE:String = "Houses";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(House));

        public function House()
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

        public function get description() : String
        {
            if (!this._description)
            {
                this._description = I18n.getText(this.descriptionId);
            }
            return this._description;
        }// end function

        public static function getGuildHouseById(param1:int) : House
        {
            return GameData.getObject(MODULE, param1) as House;
        }// end function

    }
}
