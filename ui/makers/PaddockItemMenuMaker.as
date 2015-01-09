package makers
{
    import d2actions.PaddockRemoveItemRequest;
    import d2actions.PaddockMoveItemRequest;
    import d2actions.*;
    import d2hooks.*;

    public class PaddockItemMenuMaker 
    {

        public static var disabled:Boolean = false;


        private function onPaddockRemoved(cellId:uint):void
        {
            Api.system.sendAction(new PaddockRemoveItemRequest(cellId));
        }

        private function onPaddockMoved(o:Object, cellId:uint):void
        {
            Api.system.sendAction(new PaddockMoveItemRequest(o));
        }

        public function createMenu(data:*, param:Object):Array
        {
            var menu:Array = new Array();
            var dead:Boolean = !(Api.player.isAlive());
            var guild:Object = Api.social.getGuild();
            var paddock:Object = Api.mount.getCurrentPaddock();
            if (((((((((guild) && (!((Api.social.getGuildRights().find("organizeFarm") == -1))))) && (paddock))) && (paddock.guildIdentity))) && ((paddock.guildIdentity.guildId == guild.guildId))))
            {
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.remove"), this.onPaddockRemoved, [param[0].position.cellId], ((disabled) || (dead))));
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.move"), this.onPaddockMoved, [data, param[0].position.cellId], ((disabled) || (dead))));
            };
            return (menu);
        }


    }
}//package makers

