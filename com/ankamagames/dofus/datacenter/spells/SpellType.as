package com.ankamagames.dofus.datacenter.spells
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class SpellType extends Object implements IDataCenter
    {
        public var id:int;
        public var longNameId:uint;
        public var shortNameId:uint;
        private var _longName:String;
        private var _shortName:String;
        private static const MODULE:String = "SpellTypes";

        public function SpellType()
        {
            return;
        }// end function

        public function get longName() : String
        {
            if (!this._longName)
            {
                this._longName = I18n.getText(this.longNameId);
            }
            return this._longName;
        }// end function

        public function get shortName() : String
        {
            if (!this._shortName)
            {
                this._shortName = I18n.getText(this.shortNameId);
            }
            return this._shortName;
        }// end function

        public static function getSpellTypeById(param1:int) : SpellType
        {
            return GameData.getObject(MODULE, param1) as SpellType;
        }// end function

    }
}
