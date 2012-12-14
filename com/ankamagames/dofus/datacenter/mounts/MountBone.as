package com.ankamagames.dofus.datacenter.mounts
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class MountBone extends Object implements IDataCenter
    {
        public var id:uint;
        private static var MODULE:String = "MountBones";
        private static var _ids:Array;

        public function MountBone()
        {
            return;
        }// end function

        public static function getMountBonesIds() : Array
        {
            var _loc_1:* = null;
            if (!_ids)
            {
                _ids = new Array();
                for each (_loc_1 in getMountBones())
                {
                    
                    _ids.push(_loc_1.id);
                }
            }
            return _ids;
        }// end function

        public static function getMountBoneById(param1:uint) : MountBone
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

        public static function getMountBones() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
