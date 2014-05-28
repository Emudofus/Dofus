package com.ankamagames.dofus.logic.common.managers
{
   import flash.utils.Timer;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.Stage;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellZoneManager;
   import flash.events.TimerEvent;
   import flash.events.Event;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.enums.StrataEnum;
   
   public class HyperlinkSpellManager extends Object
   {
      
      public function HyperlinkSpellManager() {
         super();
      }
      
      public static var lastSpellTooltipId:int = -1;
      
      private static var _zoneTimer:Timer;
      
      public static function showSpell(spellId:int, spellLevel:int) : void {
         var spellCacheId:int = spellId * 10 + spellLevel;
         if((spellCacheId == lastSpellTooltipId) && (TooltipManager.isVisible("Hyperlink")))
         {
            TooltipManager.hide("Hyperlink");
            lastSpellTooltipId = -1;
            return;
         }
         lastSpellTooltipId = spellCacheId;
         HyperlinkItemManager.lastItemTooltipId = -1;
         var spellWrapper:SpellWrapper = SpellWrapper.create(-1,spellId,spellLevel);
         var stage:Stage = StageShareManager.stage;
         var target:Rectangle = new Rectangle(stage.mouseX,stage.mouseY,10,10);
         TooltipManager.show(spellWrapper,target,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"Hyperlink",6,2,50,true,null,null,null,null,true);
      }
      
      public static function getSpellName(spellId:int, spellLevel:int) : String {
         var spellWrapper:SpellWrapper = SpellWrapper.create(-1,spellId,spellLevel);
         return "[" + spellWrapper.name + " " + I18n.getUiText("ui.common.short.level") + spellLevel + "]";
      }
      
      public static function showSpellArea(casterId:int, targetCellId:int, sourceCellId:int, spellId:int, spellLevelId:int) : void {
         if(Kernel.getWorker().getFrame(FightContextFrame))
         {
            SpellZoneManager.getInstance().displaySpellZone(casterId,targetCellId,sourceCellId,spellId,spellLevelId);
            if(!_zoneTimer)
            {
               _zoneTimer = new Timer(2000);
               _zoneTimer.addEventListener(TimerEvent.TIMER,onStopZoneTimer);
            }
            _zoneTimer.reset();
            _zoneTimer.start();
         }
      }
      
      private static function onStopZoneTimer(e:Event) : void {
         if(_zoneTimer)
         {
            _zoneTimer.removeEventListener(TimerEvent.TIMER,onStopZoneTimer);
            _zoneTimer.stop();
            _zoneTimer = null;
         }
         SpellZoneManager.getInstance().removeSpellZone();
      }
      
      public static function rollOver(pX:int, pY:int, casterId:int, targetCellId:int, sourceCellId:int, spellId:int, spellLevelId:int) : void {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.showSpellZone"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
