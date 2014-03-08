package com.ankamagames.dofus.datacenter.mounts
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class MountBone extends Object implements IDataCenter
   {
      
      public function MountBone() {
         super();
      }
      
      private static var MODULE:String = "MountBones";
      
      private static var _ids:Array;
      
      public static function getMountBonesIds() : Array {
         var _loc1_:MountBone = null;
         if(!_ids)
         {
            _ids = new Array();
            for each (_loc1_ in getMountBones())
            {
               _ids.push(_loc1_.id);
            }
         }
         return _ids;
      }
      
      public static function getMountBoneById(param1:uint) : MountBone {
         return GameData.getObject(MODULE,param1) as MountBone;
      }
      
      public static function getMountBones() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
   }
}
