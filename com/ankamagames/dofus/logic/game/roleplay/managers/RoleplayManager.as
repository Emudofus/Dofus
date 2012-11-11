package com.ankamagames.dofus.logic.game.roleplay.managers
{
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.berilia.factories.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.logic.game.roleplay.types.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.display.*;

    public class RoleplayManager extends Object implements IDestroyable
    {
        public var dofusTimeYearLag:int;
        private static var _self:RoleplayManager;

        public function RoleplayManager()
        {
            if (_self != null)
            {
                throw new SingletonError("RoleplayManager is a singleton and should not be instanciated directly.");
            }
            return;
        }// end function

        private function get roleplayContextFrame() : RoleplayContextFrame
        {
            return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
        }// end function

        public function destroy() : void
        {
            _self = null;
            return;
        }// end function

        public function displayCharacterContextualMenu(param1:GameContextActorInformations) : Boolean
        {
            var _loc_2:* = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
            var _loc_3:* = MenusFactory.create(param1, null, [{id:param1.contextualId}]);
            if (_loc_3)
            {
                _loc_2.createContextMenu(_loc_3);
                return true;
            }
            return false;
        }// end function

        public function displayContextualMenu(param1:GameContextActorInformations, param2:IInteractive) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
            switch(true)
            {
                case param1 is GameRolePlayMutantInformations:
                {
                    if ((param1 as GameRolePlayMutantInformations).humanoidInfo.restrictions.cantAttack)
                    {
                        _loc_3 = MenusFactory.create(param1, null, [param2]);
                    }
                    break;
                }
                case param1 is GameRolePlayCharacterInformations:
                {
                    _loc_3 = MenusFactory.create(param1, null, [param2]);
                    break;
                }
                case param1 is GameRolePlayMerchantInformations:
                {
                    _loc_3 = MenusFactory.create(param1, null, [param2]);
                    break;
                }
                case param1 is GameRolePlayNpcInformations:
                {
                    _loc_3 = MenusFactory.create(param1, null, [param2]);
                    break;
                }
                case param1 is GameRolePlayTaxCollectorInformations:
                {
                    _loc_3 = MenusFactory.create(param1, null, [param2]);
                    break;
                }
                case param1 is GameRolePlayPrismInformations:
                {
                    _loc_3 = MenusFactory.create(param1, null, [param2]);
                    break;
                }
                case param1 is GameContextPaddockItemInformations:
                {
                    if (this.roleplayContextFrame.currentPaddock.guildIdentity)
                    {
                        _loc_3 = MenusFactory.create(param1, null, [param2]);
                    }
                    break;
                }
                case param1 is GameRolePlayMountInformations:
                {
                    _loc_3 = MenusFactory.create(param1, null, [param2]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_3)
            {
                _loc_4.createContextMenu(_loc_3);
                return true;
            }
            return false;
        }// end function

        public function putEntityOnTop(param1:AnimatedCharacter) : void
        {
            var _loc_2:* = InteractiveCellManager.getInstance().getCell(param1.position.cellId);
            EntitiesDisplayManager.getInstance().orderEntity(param1, _loc_2);
            return;
        }// end function

        public static function getInstance() : RoleplayManager
        {
            if (_self == null)
            {
                _self = new RoleplayManager;
            }
            return _self;
        }// end function

    }
}
