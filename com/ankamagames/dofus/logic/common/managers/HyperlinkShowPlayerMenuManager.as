package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.factories.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.data.*;
    import flash.geom.*;

    public class HyperlinkShowPlayerMenuManager extends Object
    {

        public function HyperlinkShowPlayerMenuManager()
        {
            return;
        }// end function

        public static function showPlayerMenu(param1:String, param2:int = 0, param3:Number = 0, param4:String = null, param5:uint = 0) : void
        {
            var _loc_8:* = null;
            var _loc_6:* = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
            var _loc_7:* = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
            if (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame && param2)
            {
                _loc_8 = _loc_7.getEntityInfos(param2) as GameRolePlayCharacterInformations;
                if (!_loc_8)
                {
                    _loc_8 = new GameRolePlayCharacterInformations();
                    _loc_8.contextualId = param2;
                    _loc_8.name = param1;
                }
                _loc_6.createContextMenu(MenusFactory.create(_loc_8, null, [{id:param2, fingerprint:param4, timestamp:param3, chan:param5}]));
            }
            else
            {
                _loc_6.createContextMenu(MenusFactory.create(param1));
            }
            return;
        }// end function

        public static function getPlayerName(param1:String, param2:int = 0, param3:Number = 0, param4:String = null, param5:uint = 0) : String
        {
            var _loc_6:* = 0;
            switch(param5)
            {
                case ChatActivableChannelsEnum.CHANNEL_TEAM:
                case ChatActivableChannelsEnum.CHANNEL_GUILD:
                case ChatActivableChannelsEnum.CHANNEL_PARTY:
                case ChatActivableChannelsEnum.CHANNEL_ARENA:
                case ChatActivableChannelsEnum.CHANNEL_ADMIN:
                {
                    _loc_6 = 3;
                    break;
                }
                case ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE:
                {
                    _loc_6 = 4;
                    break;
                }
                default:
                {
                    _loc_6 = 1;
                    break;
                    break;
                }
            }
            ChatAutocompleteNameManager.getInstance().addEntry(param1, _loc_6);
            return param1;
        }// end function

        public static function rollOverPlayer(param1:int, param2:int, param3:String, param4:int = 0, param5:Number = 0, param6:String = null, param7:uint = 0) : void
        {
            var _loc_8:* = new Rectangle(param1, param2, 10, 10);
            var _loc_9:* = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.player"));
            TooltipManager.show(_loc_9, _loc_8, UiModuleManager.getInstance().getModule("Ankama_GameUiCore"), false, "HyperLink", 6, 2, 3, true, null, null, null, null, false, StrataEnum.STRATA_TOOLTIP, 1);
            return;
        }// end function

    }
}
