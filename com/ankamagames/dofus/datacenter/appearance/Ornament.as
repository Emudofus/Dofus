package com.ankamagames.dofus.datacenter.appearance
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class Ornament extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var visible:Boolean;
        public var assetId:int;
        public var iconId:int;
        public var rarity:int;
        public var order:int;
        private var _name:String;
        private static const MODULE:String = "Ornaments";

        public function Ornament()
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

        public static function getOrnamentById(param1:int) : Ornament
        {
            return GameData.getObject(MODULE, param1) as Ornament;
        }// end function

        public static function getAllOrnaments() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
