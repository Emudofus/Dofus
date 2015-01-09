package d2api
{
    public class RoleplayApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function getTotalFightOnCurrentMap():uint
        {
            return (0);
        }

        [Untrusted]
        public function getSpellToForgetList():Object
        {
            return (null);
        }

        [Untrusted]
        public function getEmotesList():Object
        {
            return (null);
        }

        [Untrusted]
        public function getUsableEmotesList():Object
        {
            return (null);
        }

        [Untrusted]
        public function getSpawnMap():uint
        {
            return (0);
        }

        [Trusted]
        public function getEntitiesOnCell(cellId:int):Object
        {
            return (null);
        }

        [Trusted]
        public function getPlayersIdOnCurrentMap():Object
        {
            return (null);
        }

        [Trusted]
        public function getPlayerIsInCurrentMap(playerId:int):Boolean
        {
            return (false);
        }

        [Trusted]
        public function isUsingInteractive():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getFight(id:int):Object
        {
            return (null);
        }

        [Trusted]
        public function putEntityOnTop(entity:Object):void
        {
        }

        [Untrusted]
        public function getEntityInfos(entity:Object):Object
        {
            return (null);
        }

        [Untrusted]
        public function getEntityByName(name:String):Object
        {
            return (null);
        }

        [Trusted]
        public function switchButtonWrappers(btnWrapper1:Object, btnWrapper2:Object):void
        {
        }

        [Trusted]
        public function setButtonWrapperActivation(btnWrapper:Object, active:Boolean):void
        {
        }


    }
}//package d2api

