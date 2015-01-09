package 
{
    import flash.display.Sprite;
    import ui.ZaapSelection;
    import ui.ZaapiSelection;
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2hooks.TeleportDestinationList;
    import d2enums.TeleporterTypeEnum;

    public class Taxi extends Sprite 
    {

        protected var zaapSelection:ZaapSelection;
        protected var zaapiSelection:ZaapiSelection;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;


        public function main():void
        {
            this.sysApi.addHook(TeleportDestinationList, this.onTeleportDestinationList);
        }

        private function onTeleportDestinationList(teleportList:Object, tpType:uint):void
        {
            if (tpType == TeleporterTypeEnum.TELEPORTER_SUBWAY)
            {
                this.uiApi.loadUi("zaapiSelection", "zaapiSelection", [teleportList, tpType]);
            }
            else
            {
                this.uiApi.loadUi("zaapSelection", "zaapSelection", [teleportList, tpType]);
            };
        }


    }
}//package 

