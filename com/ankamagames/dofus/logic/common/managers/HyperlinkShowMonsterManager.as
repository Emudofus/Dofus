package com.ankamagames.dofus.logic.common.managers
{
   import flash.display.Sprite;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   
   public class HyperlinkShowMonsterManager extends Object
   {
      
      public function HyperlinkShowMonsterManager() {
         super();
      }
      
      public static function showMonster(param1:int, param2:int=0) : Sprite {
         var _loc4_:DisplayObject = null;
         var _loc5_:Rectangle = null;
         var _loc6_:Dictionary = null;
         var _loc7_:Object = null;
         var _loc3_:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(_loc3_)
         {
            _loc6_ = _loc3_.getEntitiesDictionnary();
            for each (_loc7_ in _loc6_)
            {
               if(_loc7_ is GameRolePlayGroupMonsterInformations && (_loc7_.staticInfos.mainCreatureLightInfos.creatureGenericId == param1 || param1 == -1))
               {
                  _loc4_ = DofusEntities.getEntity(GameRolePlayGroupMonsterInformations(_loc7_).contextualId) as DisplayObject;
                  if((_loc4_) && (_loc4_.stage))
                  {
                     return HyperlinkDisplayArrowManager.showAbsoluteArrow(new Rectangle(_loc4_.x,_loc4_.y - 80,0,0),0,0,1,param2);
                  }
                  return null;
               }
               if(_loc7_ is GameFightMonsterInformations && (_loc7_.creatureGenericId == param1 || param1 == -1))
               {
                  _loc4_ = DofusEntities.getEntity(GameFightMonsterInformations(_loc7_).contextualId) as DisplayObject;
                  if((_loc4_) && (_loc4_.stage))
                  {
                     _loc5_ = _loc4_.getRect(Berilia.getInstance().docMain);
                     return HyperlinkDisplayArrowManager.showAbsoluteArrow(_loc5_,0,0,1,param2);
                  }
                  return null;
               }
            }
         }
         return null;
      }
      
      public static function getMonsterName(param1:uint) : String {
         var _loc2_:Monster = Monster.getMonsterById(param1);
         if(_loc2_)
         {
            return _loc2_.name;
         }
         return "[null]";
      }
   }
}
