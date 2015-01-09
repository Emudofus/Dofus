package makers
{
    import d2network.GameRolePlayMerchantInformations;
    import d2actions.*;
    import d2hooks.*;

    public class MultiPlayerMenuMaker 
    {


        public function createMenu(data:*, param:Object):Array
        {
            var entity:Object;
            var infos:Object;
            var subMenu:Object;
            var playerEntity:Object = param[0];
            var menu:Array = new Array();
            var cellId:uint = param[0].position.cellId;
            var entities:Object = Api.roleplay.getEntitiesOnCell(cellId);
            var pmm:PlayerMenuMaker = new PlayerMenuMaker();
            var hvmm:HumanVendorMenuMaker = new HumanVendorMenuMaker();
            for each (entity in entities)
            {
                if (entity.id > 0)
                {
                    infos = Api.roleplay.getEntityInfos(entity);
                    if (!(infos))
                    {
                    }
                    else
                    {
                        if ((infos is GameRolePlayMerchantInformations))
                        {
                            subMenu = hvmm.createMenu(infos, [entity]);
                        }
                        else
                        {
                            subMenu = pmm.createMenu(infos, [entity]);
                        };
                        if (!(infos.hasOwnProperty("fight")))
                        {
                            menu.push(Api.modMenu.createContextMenuItemObject(infos.name, this.onPutOnTop, [entity], false, subMenu));
                        };
                    };
                };
            };
            return (menu);
        }

        private function onPutOnTop(entity:Object):void
        {
            Api.roleplay.putEntityOnTop(entity);
        }


    }
}//package makers

