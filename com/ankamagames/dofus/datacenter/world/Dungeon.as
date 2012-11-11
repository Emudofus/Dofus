package com.ankamagames.dofus.datacenter.world
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class Dungeon extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var optimalPlayerLevel:int;
        private var _name:String;
        private static const MODULE:String = "Dungeons";
        private static var _allDungeons:Array;

        public function Dungeon()
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

        public static function getDungeonById(param1:int) : Dungeon
        {
            var _loc_2:* = GameData.getObject(MODULE, param1) as ;
            return _loc_2;
        }// end function

        public static function getAllDungeons() : Array
        {
            if (_allDungeons)
            {
                return _allDungeons;
            }
            _allDungeons = GameData.getObjects(MODULE) as Array;
            return _allDungeons;
        }// end function

    }
}
