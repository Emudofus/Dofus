package com.ankamagames.dofus.logic.common.managers
{
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.enums.StrataEnum;
   
   public class HyperlinkShowEntityManager extends Object
   {
      
      public function HyperlinkShowEntityManager() {
         super();
      }
      
      public static function showEntity(entityId:int, showCell:int = 0) : Sprite {
         var rect:Rectangle = null;
         var entity:DisplayObject = DofusEntities.getEntity(entityId) as DisplayObject;
         if(entity)
         {
            if(showCell)
            {
               HyperlinkShowCellManager.showCell((entity as IEntity).position.cellId);
               return null;
            }
            rect = entity.getRect(Berilia.getInstance().docMain);
            return HyperlinkDisplayArrowManager.showAbsoluteArrow(new Rectangle(int(rect.x),int(rect.y),0,0));
         }
         return null;
      }
      
      public static function rollOver(pX:int, pY:int, entityId:int, showCell:int = 0) : void {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.whereAreYou"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
