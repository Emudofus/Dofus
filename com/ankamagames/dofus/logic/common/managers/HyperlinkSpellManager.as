package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class HyperlinkSpellManager extends Object
    {
        public static var lastSpellTooltipId:int = -1;
        private static var _zoneTimer:Timer;

        public function HyperlinkSpellManager()
        {
            return;
        }// end function

        public static function showSpell(param1:int, param2:int) : void
        {
            var _loc_3:* = param1 * 10 + param2;
            if (_loc_3 == lastSpellTooltipId && TooltipManager.isVisible("Hyperlink"))
            {
                TooltipManager.hide("Hyperlink");
                lastSpellTooltipId = -1;
                return;
            }
            lastSpellTooltipId = _loc_3;
            HyperlinkItemManager.lastItemTooltipId = -1;
            var _loc_4:* = SpellWrapper.create(-1, param1, param2);
            var _loc_5:* = StageShareManager.stage;
            var _loc_6:* = new Rectangle(_loc_5.mouseX, _loc_5.mouseY, 10, 10);
            TooltipManager.show(_loc_4, _loc_6, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, "Hyperlink", 6, 2, 50, true, null, null, null, null, true);
            return;
        }// end function

        public static function getSpellName(param1:int, param2:int) : String
        {
            var _loc_3:* = SpellWrapper.create(-1, param1, param2);
            return "[" + _loc_3.name + " " + I18n.getUiText("ui.common.short.level") + param2 + "]";
        }// end function

        public static function showSpellArea(param1:int, param2:int, param3:int, param4:int, param5:int) : void
        {
            if (Kernel.getWorker().getFrame(FightContextFrame))
            {
                SpellZoneManager.getInstance().displaySpellZone(param1, param2, param3, param4, param5);
                if (!_zoneTimer)
                {
                    _zoneTimer = new Timer(2000);
                    _zoneTimer.addEventListener(TimerEvent.TIMER, onStopZoneTimer);
                }
                _zoneTimer.reset();
                _zoneTimer.start();
            }
            return;
        }// end function

        private static function onStopZoneTimer(event:Event) : void
        {
            if (_zoneTimer)
            {
                _zoneTimer.removeEventListener(TimerEvent.TIMER, onStopZoneTimer);
                _zoneTimer.stop();
                _zoneTimer = null;
            }
            SpellZoneManager.getInstance().removeSpellZone();
            return;
        }// end function

    }
}
