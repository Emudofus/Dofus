package com.ankamagames.dofus.datacenter.appearance
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.GameData;

    public class CreatureBoneOverride implements IDataCenter 
    {

        public static const MODULE:String = "CreatureBonesOverrides";

        public var boneId:int;
        public var creatureBoneId:int;


        public static function getCreatureBones(pBoneId:int):int
        {
            var bonesOverride:CreatureBoneOverride = (GameData.getObject(MODULE, pBoneId) as CreatureBoneOverride);
            return (((bonesOverride) ? bonesOverride.creatureBoneId : 0));
        }

        public static function getAllCreatureBonesOverrides():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}//package com.ankamagames.dofus.datacenter.appearance

