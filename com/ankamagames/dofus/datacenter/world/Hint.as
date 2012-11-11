package com.ankamagames.dofus.datacenter.world
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class Hint extends Object implements IDataCenter
    {
        public var id:int;
        public var categoryId:uint;
        public var gfx:uint;
        public var nameId:uint;
        public var mapId:uint;
        public var realMapId:uint;
        public var x:int;
        public var y:int;
        public var outdoor:Boolean;
        public var subareaId:int;
        private var _name:String;
        private static const MODULE:String = "Hints";

        public function Hint()
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

        public static function getHintById(param1:int) : Hint
        {
            return GameData.getObject(MODULE, param1) as Hint;
        }// end function

        public static function getHints() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
