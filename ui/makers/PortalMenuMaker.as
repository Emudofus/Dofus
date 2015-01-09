package makers
{
    import d2actions.NpcGenericActionRequest;
    import d2actions.PortalUseRequest;
    import d2network.PortalInformation;
    import d2data.Area;
    import d2actions.*;
    import d2hooks.*;

    public class PortalMenuMaker 
    {

        public static var disabled:Boolean = false;

        public var _portalId:int;
        public var _areaName:String;


        private function onPortalTalk(entityId:int):void
        {
            Api.system.sendAction(new NpcGenericActionRequest(entityId, 3));
        }

        private function onPortalUse():void
        {
            Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"), Api.ui.getText("ui.dimension.confirmTeleport", this._areaName), [Api.ui.getText("ui.common.yes"), Api.ui.getText("ui.common.no")], [this.onValid], this.onValid);
        }

        protected function onValid():void
        {
            Api.system.sendAction(new PortalUseRequest(this._portalId));
        }

        public function createMenu(data:*, param:Object):Array
        {
            var name:String;
            var menu:Array = new Array();
            var dead:Boolean = !(Api.player.isAlive());
            var portalInfos:PortalInformation = data.portal;
            this._portalId = portalInfos.portalId;
            var area:Area = Api.data.getArea(portalInfos.areaId);
            if (area)
            {
                this._areaName = area.name;
            }
            else
            {
                this._areaName = "???";
            };
            name = Api.ui.getText("ui.dimension.portal", this._areaName);
            menu.push(ContextMenu.static_createContextMenuTitleObject(name));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.talk"), this.onPortalTalk, [param[0].id]));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.use"), this.onPortalUse, null, ((disabled) || (dead))));
            return (menu);
        }


    }
}//package makers

