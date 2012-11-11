package com.ankamagames.dofus.datacenter.items
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class ItemSet extends Object implements IDataCenter
    {
        public var id:uint;
        public var items:Vector.<uint>;
        public var nameId:uint;
        public var effects:Vector.<Vector.<EffectInstance>>;
        public var bonusIsSecret:Boolean;
        private var _name:String;
        private static const MODULE:String = "ItemSets";

        public function ItemSet()
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

        public static function getItemSetById(param1:uint) : ItemSet
        {
            return GameData.getObject(MODULE, param1) as ItemSet;
        }// end function

        public static function getItemSets() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
