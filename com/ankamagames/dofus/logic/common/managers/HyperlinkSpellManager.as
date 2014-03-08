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
      
      public static function showSpell(param1:int, param2:int) : void {
         var _loc3_:int = param1 * 10 + param2;
         if(_loc3_ == lastSpellTooltipId && (TooltipManager.isVisible("Hyperlink")))
         {
            TooltipManager.hide("Hyperlink");
            lastSpellTooltipId = -1;
            return;
         }
         lastSpellTooltipId = _loc3_;
         HyperlinkItemManager.lastItemTooltipId = -1;
         var _loc4_:SpellWrapper = SpellWrapper.create(-1,param1,param2);
         var _loc5_:Stage = StageShareManager.stage;
         var _loc6_:Rectangle = new Rectangle(_loc5_.mouseX,_loc5_.mouseY,10,10);
         TooltipManager.show(_loc4_,_loc6_,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"Hyperlink",6,2,50,true,null,null,null,null,true);
      }
      
      public static function getSpellName(param1:int, param2:int) : String {
         var _loc3_:SpellWrapper = SpellWrapper.create(-1,param1,param2);
         return "[" + _loc3_.name + " " + I18n.getUiText("ui.common.short.level") + param2 + "]";
      }
      
      public static function showSpellArea(param1:int, param2:int, param3:int, param4:int, param5:int) : void {
         if(Kernel.getWorker().getFrame(FightContextFrame))
         {
            SpellZoneManager.getInstance().displaySpellZone(param1,param2,param3,param4,param5);
            if(!_zoneTimer)
            {
               _zoneTimer = new Timer(2000);
               _zoneTimer.addEventListener(TimerEvent.TIMER,onStopZoneTimer);
            }
            _zoneTimer.reset();
            _zoneTimer.start();
         }
      }
      
      private static function onStopZoneTimer(param1:Event) : void {
         if(_zoneTimer)
         {
            _zoneTimer.removeEventListener(TimerEvent.TIMER,onStopZoneTimer);
            _zoneTimer.stop();
            _zoneTimer = null;
         }
         SpellZoneManager.getInstance().removeSpellZone();
      }
      
      public static function rollOver(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : void {
         var _loc8_:Rectangle = new Rectangle(param1,param2,10,10);
         var _loc9_:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.showSpellZone"));
         TooltipManager.show(_loc9_,_loc8_,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
