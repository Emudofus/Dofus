package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   
   public class LookCleaner extends Object
   {
      
      public function LookCleaner() {
         super();
      }
      
      public static function clean(param1:TiphonEntityLook) : TiphonEntityLook {
         var _loc4_:Breed = null;
         var _loc2_:TiphonEntityLook = param1.clone();
         var _loc3_:TiphonEntityLook = _loc2_.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
         if(_loc3_)
         {
            if(_loc3_.getBone() == 2)
            {
               _loc3_.setBone(1);
            }
            return _loc3_;
         }
         for each (_loc4_ in Breed.getBreeds())
         {
            if(_loc4_.creatureBonesId == _loc2_.getBone())
            {
               _loc2_.setBone(1);
               break;
            }
         }
         return _loc2_;
      }
   }
}
