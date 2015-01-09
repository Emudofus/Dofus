package makers
{
    import d2actions.NpcGenericActionRequest;
    import d2actions.ExchangeRequestOnTaxCollector;
    import d2actions.GameRolePlayTaxCollectorFightRequest;
    import d2actions.*;
    import d2hooks.*;

    public class TaxCollectorMenuMaker 
    {

        public static var disabled:Boolean = false;


        private function onTalkTaxCollectorClick(pTaxCollectorContextualId:int):void
        {
            Api.system.sendAction(new NpcGenericActionRequest(pTaxCollectorContextualId, 3));
        }

        private function onCollectTaxCollectorClick(pTaxCollectorContextualId:int):void
        {
            Api.system.sendAction(new ExchangeRequestOnTaxCollector(pTaxCollectorContextualId));
        }

        private function onAttackTaxCollectorClick(pTaxCollectorContextualId:int):void
        {
            Api.system.sendAction(new GameRolePlayTaxCollectorFightRequest(pTaxCollectorContextualId));
        }

        public function createMenu(data:*, param:Object):Array
        {
            var playerInfos:Object;
            var lDisabled:Boolean;
            var aDisabled:Boolean;
            var menu:Array = new Array();
            var dead:Boolean = !(Api.player.isAlive());
            menu.push(ContextMenu.static_createContextMenuTitleObject(((Api.data.getTaxCollectorFirstname(data.identification.firstNameId).firstname + " ") + Api.data.getTaxCollectorName(data.identification.lastNameId).name)));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.talk"), this.onTalkTaxCollectorClick, [param[0].id]));
            if (((Api.social.hasGuild()) && ((Api.social.getGuild().guildId == data.identification.guildIdentity.guildId))))
            {
                playerInfos = Api.player.getPlayedCharacterInfo();
                lDisabled = !(Api.social.hasGuildRight(playerInfos.id, "collect"));
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.CollectTaxCollector"), this.onCollectTaxCollectorClick, [param[0].id]), ((((disabled) || (lDisabled))) || (dead)));
            }
            else
            {
                aDisabled = false;
                if (data.taxCollectorAttack != 0)
                {
                    aDisabled = true;
                };
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.attack"), this.onAttackTaxCollectorClick, [param[0].id], ((((disabled) || (aDisabled))) || (dead))));
            };
            return (menu);
        }


    }
}//package makers

