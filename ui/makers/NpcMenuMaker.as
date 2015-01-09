package makers
{
    import d2actions.NpcGenericActionRequest;
    import flash.utils.Dictionary;
    import d2actions.*;
    import d2hooks.*;

    public class NpcMenuMaker 
    {

        public static var disabled:Boolean = false;


        private function onNPCMenuClick(pNPCId:int, pActionId:int):void
        {
            Api.system.sendAction(new NpcGenericActionRequest(pNPCId, pActionId));
        }

        public function createMenu(data:*, param:Object):Array
        {
            var realActions:Dictionary;
            var actionId:uint;
            var action:*;
            var actionData:Object;
            var menu:Array = new Array();
            var dead:Boolean = !(Api.player.isAlive());
            var npcId:int = data.npcId;
            var npc:Object = Api.data.getNpc(npcId);
            var npcActions:Object = npc.actions;
            if (npcActions.length > 0)
            {
                menu.push(ContextMenu.static_createContextMenuTitleObject(npc.name));
                realActions = new Dictionary();
                for each (actionId in npcActions)
                {
                    actionData = Api.data.getNpcAction(actionId);
                    if (((!((actionData.realId == actionId))) || (!(realActions[actionData.realId]))))
                    {
                        realActions[actionData.realId] = actionData.name;
                    };
                };
                for (action in realActions)
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(realActions[action], this.onNPCMenuClick, [param[0].id, action], ((disabled) || (dead))));
                };
            };
            return (menu);
        }


    }
}//package makers

