package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.dofus.logic.game.common.managers.TaxCollectorsManager;
    import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.jerakine.data.I18n;
    import flash.geom.Rectangle;
    import com.ankamagames.berilia.types.data.TextTooltipInfo;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.berilia.enums.StrataEnum;

    public class HyperlinkTaxCollectorPosition 
    {


        public static function showPosition(posX:int, posY:int, worldMapId:int, taxCollectorId:uint):void
        {
            var taxcollector:TaxCollectorWrapper = TaxCollectorsManager.getInstance().taxCollectors[taxCollectorId];
            KernelEventsManager.getInstance().processCallback(HookList.AddMapFlag, ("flag_taxcollector" + taxCollectorId), (((((posX + ",") + posY) + " (") + I18n.getUiText("ui.cartography.positionof", [((taxcollector.firstName + " ") + taxcollector.lastName)])) + ")"), worldMapId, posX, posY, 0xFF6600, true);
        }

        public static function rollOver(pX:int, pY:int, worldMapId:int, taxCollectorId:uint, posX:int, posY:int):void
        {
            var target:Rectangle = new Rectangle(pX, pY, 10, 10);
            var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.position"));
            TooltipManager.show(info, target, UiModuleManager.getInstance().getModule("Ankama_GameUiCore"), false, "HyperLink", 6, 2, 3, true, null, null, null, null, false, StrataEnum.STRATA_TOOLTIP, 1);
        }


    }
}//package com.ankamagames.dofus.logic.common.managers

