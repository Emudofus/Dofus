package com.ankamagames.dofus.datacenter.monsters
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class MonsterSuperRace extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        private var _name:String;
        private static const MODULE:String = "MonsterSuperRaces";

        public function MonsterSuperRace()
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

        public static function getMonsterSuperRaceById(param1:uint) : MonsterSuperRace
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

        public static function getMonsterSuperRaces() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
