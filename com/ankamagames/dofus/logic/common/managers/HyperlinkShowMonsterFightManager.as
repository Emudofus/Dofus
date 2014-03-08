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
      
      public static function showEntity(param1:int) : void {
         var _loc3_:DisplayObject = null;
         var _loc2_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(_loc2_)
         {
            _loc3_ = DofusEntities.getEntity(param1) as DisplayObject;
            if(_loc3_)
            {
               HyperlinkShowCellManager.showCell((_loc3_ as IEntity).position.cellId);
            }
         }
      }
      
      public static function rollOver(param1:int, param2:int, param3:int) : void {
         var _loc4_:Rectangle = new Rectangle(param1,param2,10,10);
         var _loc5_:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.whereAreYou"));
         TooltipManager.show(_loc5_,_loc4_,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
