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
      
      public static function showMonster(monsterId:int, loop:int = 0) : Sprite {
         var monsterClip:DisplayObject = null;
         var rect:Rectangle = null;
         var list:Dictionary = null;
         var monster:Object = null;
         var roleplayEntitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(roleplayEntitiesFrame)
         {
            list = roleplayEntitiesFrame.getEntitiesDictionnary();
            for each(monster in list)
            {
               if((monster is GameRolePlayGroupMonsterInformations) && ((monster.staticInfos.mainCreatureLightInfos.creatureGenericId == monsterId) || (monsterId == -1)))
               {
                  monsterClip = DofusEntities.getEntity(GameRolePlayGroupMonsterInformations(monster).contextualId) as DisplayObject;
                  if((monsterClip) && (monsterClip.stage))
                  {
                     return HyperlinkDisplayArrowManager.showAbsoluteArrow(new Rectangle(monsterClip.x,monsterClip.y - 80,0,0),0,0,1,loop);
                  }
                  return null;
               }
               if((monster is GameFightMonsterInformations) && ((monster.creatureGenericId == monsterId) || (monsterId == -1)))
               {
                  monsterClip = DofusEntities.getEntity(GameFightMonsterInformations(monster).contextualId) as DisplayObject;
                  if((monsterClip) && (monsterClip.stage))
                  {
                     rect = monsterClip.getRect(Berilia.getInstance().docMain);
                     return HyperlinkDisplayArrowManager.showAbsoluteArrow(rect,0,0,1,loop);
                  }
                  return null;
               }
            }
         }
         return null;
      }
      
      public static function getMonsterName(monsterId:uint) : String {
         var m:Monster = Monster.getMonsterById(monsterId);
         if(m)
         {
            return m.name;
         }
         return "[null]";
      }
   }
}
