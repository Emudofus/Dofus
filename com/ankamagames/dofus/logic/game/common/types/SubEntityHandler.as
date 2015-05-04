package com.ankamagames.dofus.logic.game.common.types
{
   import com.ankamagames.tiphon.types.ISubEntityHandler;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   
   public class SubEntityHandler extends Object implements ISubEntityHandler
   {
      
      public function SubEntityHandler()
      {
         super();
      }
      
      public static var instance:ISubEntityHandler = new SubEntityHandler();
      
      public function onSubEntityAdded(param1:TiphonSprite, param2:TiphonEntityLook, param3:uint, param4:uint) : Boolean
      {
         if(param3 != SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET_FOLLOWER)
         {
            return true;
         }
         var _loc5_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(_loc5_)
         {
            if(param1.look.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET,0) == null)
            {
               param1.look.addSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET,0,param2);
            }
            return false;
         }
         return false;
      }
   }
}
