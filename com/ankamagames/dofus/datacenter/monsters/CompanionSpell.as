package com.ankamagames.dofus.datacenter.monsters
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.GameData;

    public class CompanionSpell implements IDataCenter 
    {

        public static const MODULE:String = "CompanionSpells";

        public var id:int;
        public var spellId:int;
        public var companionId:int;
        public var gradeByLevel:String;


        public static function getCompanionSpellById(id:uint):CompanionSpell
        {
            return ((GameData.getObject(MODULE, id) as CompanionSpell));
        }

        public static function getCompanionSpells():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}//package com.ankamagames.dofus.datacenter.monsters

