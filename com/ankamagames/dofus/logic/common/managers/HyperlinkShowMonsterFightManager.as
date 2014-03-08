package com.ankamagames.dofus.logic.common.managers
{
   import flash.display.DisplayObject;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.enums.StrataEnum;
   
   public class HyperlinkShowMonsterFightManager extends Object
   {
      
      public function HyperlinkShowMonsterFightManager() {
         super();
      }
      
      public static function showEntity(entityId:int) : void {
         var entity:DisplayObject = null;
         var fightEntitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(fightEntitiesFrame)
         {
            entity = DofusEntities.getEntity(entityId) as DisplayObject;
            if(entity)
            {
               HyperlinkShowCellManager.showCell((entity as IEntity).position.cellId);
            }
         }
      }
      
      public static function rollOver(pX:int, pY:int, entityId:int) : void {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.whereAreYou"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
