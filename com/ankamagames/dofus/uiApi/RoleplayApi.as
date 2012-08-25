package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.logic.game.roleplay.managers.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class RoleplayApi extends Object implements IApi
    {
        private var _module:UiModule;
        protected var _log:Logger;

        public function RoleplayApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(RoleplayApi));
            return;
        }// end function

        private function get roleplayEntitiesFrame() : RoleplayEntitiesFrame
        {
            return Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
        }// end function

        private function get roleplayInteractivesFrame() : RoleplayInteractivesFrame
        {
            return Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
        }// end function

        private function get spellInventoryManagementFrame() : SpellInventoryManagementFrame
        {
            return Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame;
        }// end function

        private function get roleplayEmoticonFrame() : RoleplayEmoticonFrame
        {
            return Kernel.getWorker().getFrame(RoleplayEmoticonFrame) as RoleplayEmoticonFrame;
        }// end function

        private function get zaapFrame() : ZaapFrame
        {
            return Kernel.getWorker().getFrame(ZaapFrame) as ZaapFrame;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            return;
        }// end function

        public function getTotalFightOnCurrentMap() : uint
        {
            return this.roleplayEntitiesFrame.fightNumber;
        }// end function

        public function getSpellToForgetList() : Array
        {
            var _loc_2:SpellWrapper = null;
            var _loc_1:* = new Array();
            for each (_loc_2 in PlayedCharacterManager.getInstance().spellsInventory)
            {
                
                if (_loc_2.spellLevel > 1)
                {
                    _loc_1.push(_loc_2);
                }
            }
            return _loc_1;
        }// end function

        public function getEmotesList() : Array
        {
            var _loc_1:* = this.roleplayEmoticonFrame.emotesList;
            return _loc_1;
        }// end function

        public function getUsableEmotesList() : Array
        {
            return this.roleplayEntitiesFrame.usableEmoticons;
        }// end function

        public function getSpawnMap() : uint
        {
            return this.zaapFrame.spawnMapId;
        }// end function

        public function getEntitiesOnCell(param1:int) : Array
        {
            return EntitiesManager.getInstance().getEntitiesOnCell(param1);
        }// end function

        public function getPlayersIdOnCurrentMap() : Array
        {
            return this.roleplayEntitiesFrame.playersId;
        }// end function

        public function getPlayerIsInCurrentMap(param1:int) : Boolean
        {
            return this.roleplayEntitiesFrame.playersId.indexOf(param1) != -1;
        }// end function

        public function getFight(param1:int) : Object
        {
            return this.roleplayEntitiesFrame.fights[param1];
        }// end function

        public function putEntityOnTop(param1:AnimatedCharacter) : void
        {
            RoleplayManager.getInstance().putEntityOnTop(param1);
            return;
        }// end function

        public function getEntityInfos(param1:Object) : Object
        {
            var _loc_2:* = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
            return _loc_2.entitiesFrame.getEntityInfos(param1.id);
        }// end function

        public function getEntityByName(param1:String) : Object
        {
            var _loc_3:IEntity = null;
            var _loc_4:GameRolePlayNamedActorInformations = null;
            var _loc_2:* = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
            for each (_loc_3 in EntitiesManager.getInstance().entities)
            {
                
                _loc_4 = _loc_2.entitiesFrame.getEntityInfos(_loc_3.id) as GameRolePlayNamedActorInformations;
                if (_loc_4 && param1 == _loc_4.name)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

    }
}
