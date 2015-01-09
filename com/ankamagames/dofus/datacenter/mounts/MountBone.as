package com.ankamagames.dofus.datacenter.mounts
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.GameData;

    public class MountBone implements IDataCenter 
    {

        private static var MODULE:String = "MountBones";
        private static var _ids:Array;

        public var id:uint;


        public static function getMountBonesIds():Array
        {
            var b:MountBone;
            if (!(_ids))
            {
                _ids = new Array();
                for each (b in getMountBones())
                {
                    _ids.push(b.id);
                };
            };
            return (_ids);
        }

        public static function getMountBoneById(id:uint):MountBone
        {
            return ((GameData.getObject(MODULE, id) as MountBone));
        }

        public static function getMountBones():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}//package com.ankamagames.dofus.datacenter.mounts

