package com.ankamagames.dofus.datacenter.spells
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class SpellState extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var preventsSpellCast:Boolean;
        public var preventsFight:Boolean;
        public var critical:Boolean;
        private var _name:String;
        private static const MODULE:String = "SpellStates";

        public function SpellState()
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

        public static function getSpellStateById(param1:int) : SpellState
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

        public static function getSpellStates() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
