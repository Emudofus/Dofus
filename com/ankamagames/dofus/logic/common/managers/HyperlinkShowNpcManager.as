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
      
      public static function showNpc(npcId:int, loop:int=0) : MovieClip {
         var list:Dictionary = null;
         var npc:Object = null;
         var graphicCell:GraphicCell = null;
         var rect:Rectangle = null;
         var abstractEntitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(abstractEntitiesFrame)
         {
            list = abstractEntitiesFrame.getEntitiesDictionnary();
            for each (npc in list)
            {
               if((npc is GameRolePlayNpcInformations) && ((npc.npcId == npcId) || (npcId == -1)))
               {
                  graphicCell = InteractiveCellManager.getInstance().getCell(npc.disposition.cellId);
                  rect = graphicCell.getRect(Berilia.getInstance().docMain);
                  rect.y = rect.y - 80;
                  return HyperlinkDisplayArrowManager.showAbsoluteArrow(rect,0,0,1,loop);
               }
            }
         }
         return null;
      }
   }
}
