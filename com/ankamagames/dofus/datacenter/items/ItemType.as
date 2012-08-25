package com.ankamagames.dofus.datacenter.items
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class ItemType extends Object implements IDataCenter
    {
        private var _zoneSize:uint = 4.29497e+009;
        private var _zoneShape:uint = 4.29497e+009;
        private var _zoneMinSize:uint = 4.29497e+009;
        public var id:int;
        public var nameId:uint;
        public var superTypeId:uint;
        public var plural:Boolean;
        public var gender:uint;
        public var rawZone:String;
        public var needUseConfirm:Boolean;
        private var _name:String;
        private static const MODULE:String = "ItemTypes";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ItemType));

        public function ItemType()
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

        public function get zoneSize() : uint
        {
            if (this._zoneSize == uint.MAX_VALUE)
            {
                this.parseZone();
            }
            return this._zoneSize;
        }// end function

        public function get zoneShape() : uint
        {
            if (this._zoneShape == uint.MAX_VALUE)
            {
                this.parseZone();
            }
            return this._zoneShape;
        }// end function

        public function get zoneMinSize() : uint
        {
            if (this._zoneMinSize == uint.MAX_VALUE)
            {
                this.parseZone();
            }
            return this._zoneMinSize;
        }// end function

        private function parseZone() : void
        {
            var _loc_1:Array = null;
            if (this.rawZone && this.rawZone.length)
            {
                this._zoneShape = this.rawZone.charCodeAt(0);
                _loc_1 = this.rawZone.substr(1).split(",");
                if (_loc_1.length > 0)
                {
                    this._zoneSize = parseInt(_loc_1[0]);
                }
                else
                {
                    this._zoneSize = 0;
                }
                if (_loc_1.length > 1)
                {
                    this._zoneMinSize = parseInt(_loc_1[1]);
                }
                else
                {
                    this._zoneMinSize = 0;
                }
            }
            else
            {
                _log.error("Zone incorrect (" + this.rawZone + ")");
            }
            return;
        }// end function

        public static function getItemTypeById(param1:uint) : ItemType
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

        public static function getItemTypes() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
