package makers
{
    import d2actions.MountInformationInPaddockRequest;
    import d2actions.*;
    import d2hooks.*;

    public class MountMenuMaker 
    {

        public static var disabled:Boolean = false;


        private function onDetails(data:Object):void
        {
            Api.system.sendAction(new MountInformationInPaddockRequest(data.id));
        }

        public function createMenu(data:*, param:Object):Array
        {
            var menu:Array = new Array();
            var dead:Boolean = !(Api.player.isAlive());
            var guild:Object = Api.social.getGuild();
            if (data.hasOwnProperty("ownerName"))
            {
                menu.push(ContextMenu.static_createContextMenuTitleObject(Api.ui.getText("ui.mount.mountOf", data.ownerName)));
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mount.viewMountDetails"), this.onDetails, [param[0]], disabled));
            };
            return (menu);
        }


    }
}//package makers

