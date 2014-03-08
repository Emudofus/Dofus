package com.ankamagames.dofus.logic.common.managers
{
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   import com.ankamagames.atouin.types.GraphicCell;
   import flash.geom.Rectangle;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.berilia.Berilia;
   
   public class HyperlinkShowNpcManager extends Object
   {
      
      public function HyperlinkShowNpcManager() {
         super();
      }
      
      public static function showNpc(param1:int, param2:int=0) : MovieClip {
         var _loc4_:Dictionary = null;
         var _loc5_:Object = null;
         var _loc6_:GraphicCell = null;
         var _loc7_:Rectangle = null;
         var _loc3_:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(_loc3_)
         {
            _loc4_ = _loc3_.getEntitiesDictionnary();
            for each (_loc5_ in _loc4_)
            {
               if(_loc5_ is GameRolePlayNpcInformations && (_loc5_.npcId == param1 || param1 == -1))
               {
                  _loc6_ = InteractiveCellManager.getInstance().getCell(_loc5_.disposition.cellId);
                  _loc7_ = _loc6_.getRect(Berilia.getInstance().docMain);
                  _loc7_.y = _loc7_.y - 80;
                  return HyperlinkDisplayArrowManager.showAbsoluteArrow(_loc7_,0,0,1,param2);
               }
            }
         }
         return null;
      }
   }
}
