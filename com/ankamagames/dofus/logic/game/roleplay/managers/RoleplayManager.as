package com.ankamagames.dofus.logic.game.roleplay.managers
{
    import com.ankamagames.jerakine.interfaces.IDestroyable;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.berilia.factories.MenusFactory;
    import com.ankamagames.berilia.types.data.ContextMenuData;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMutantInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
    import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPortalInformations;
    import com.ankamagames.dofus.logic.game.roleplay.types.GameContextPaddockItemInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMountInformations;
    import com.ankamagames.jerakine.entities.interfaces.IInteractive;
    import com.ankamagames.atouin.managers.InteractiveCellManager;
    import flash.display.Sprite;
    import com.ankamagames.atouin.managers.EntitiesDisplayManager;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;

    public class RoleplayManager implements IDestroyable 
    {

        private static var _self:RoleplayManager;
        private static const REWARD_SCALE_CAP:Number = 1.5;
        private static const REWARD_REDUCED_SCALE:Number = 0.7;

        public var dofusTimeYearLag:int;

        public function RoleplayManager()
        {
            if (_self != null)
            {
                throw (new SingletonError("RoleplayManager is a singleton and should not be instanciated directly."));
            };
        }

        public static function getInstance():RoleplayManager
        {
            if (_self == null)
            {
                _self = new (RoleplayManager)();
            };
            return (_self);
        }


        private function get roleplayContextFrame():RoleplayContextFrame
        {
            return ((Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame));
        }

        public function destroy():void
        {
            _self = null;
        }

        public function displayCharacterContextualMenu(pGameContextActorInformations:GameContextActorInformations):Boolean
        {
            var modContextMenu:Object = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
            var menu:ContextMenuData = MenusFactory.create(pGameContextActorInformations, null, [{"id":pGameContextActorInformations.contextualId}]);
            if (menu)
            {
                modContextMenu.createContextMenu(menu);
                return (true);
            };
            return (false);
        }

        public function displayContextualMenu(pGameContextActorInformations:GameContextActorInformations, pEntity:IInteractive):Boolean
        {
            var menu:ContextMenuData;
            var modContextMenu:Object = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
            switch (true)
            {
                case (pGameContextActorInformations is GameRolePlayMutantInformations):
                    if ((pGameContextActorInformations as GameRolePlayMutantInformations).humanoidInfo.restrictions.cantAttack)
                    {
                        menu = MenusFactory.create(pGameContextActorInformations, null, [pEntity]);
                    };
                    break;
                case (pGameContextActorInformations is GameRolePlayCharacterInformations):
                    menu = MenusFactory.create(pGameContextActorInformations, null, [pEntity]);
                    break;
                case (pGameContextActorInformations is GameRolePlayMerchantInformations):
                    menu = MenusFactory.create(pGameContextActorInformations, null, [pEntity]);
                    break;
                case (pGameContextActorInformations is GameRolePlayNpcInformations):
                    menu = MenusFactory.create(pGameContextActorInformations, null, [pEntity]);
                    break;
                case (pGameContextActorInformations is GameRolePlayTaxCollectorInformations):
                    menu = MenusFactory.create(pGameContextActorInformations, null, [pEntity]);
                    break;
                case (pGameContextActorInformations is GameRolePlayPrismInformations):
                    menu = MenusFactory.create(pGameContextActorInformations, null, [pEntity]);
                    break;
                case (pGameContextActorInformations is GameRolePlayPortalInformations):
                    menu = MenusFactory.create(pGameContextActorInformations, null, [pEntity]);
                    break;
                case (pGameContextActorInformations is GameContextPaddockItemInformations):
                    if (this.roleplayContextFrame.currentPaddock.guildIdentity)
                    {
                        menu = MenusFactory.create(pGameContextActorInformations, null, [pEntity]);
                    };
                    break;
                case (pGameContextActorInformations is GameRolePlayMountInformations):
                    menu = MenusFactory.create(pGameContextActorInformations, null, [pEntity]);
                    break;
            };
            if (menu)
            {
                modContextMenu.createContextMenu(menu);
                return (true);
            };
            return (false);
        }

        public function putEntityOnTop(entity:AnimatedCharacter):void
        {
            var cellSprite:Sprite = InteractiveCellManager.getInstance().getCell(entity.position.cellId);
            EntitiesDisplayManager.getInstance().orderEntity(entity, cellSprite);
        }

        public function getKamasReward(kamasScaleWithPlayerLevel:Boolean=true, optimalLevel:int=-1, kamasRatio:Number=1, duration:Number=1, pPlayerLevel:int=-1):Number
        {
            if ((((pPlayerLevel == -1)) && (kamasScaleWithPlayerLevel)))
            {
                pPlayerLevel = PlayedCharacterManager.getInstance().infos.level;
            };
            var lvl:int = ((kamasScaleWithPlayerLevel) ? pPlayerLevel : optimalLevel);
            return (((((Math.pow(lvl, 2) + (20 * lvl)) - 20) * kamasRatio) * duration));
        }

        public function getExperienceReward(pPlayerLevel:int, pXpBonus:int, optimalLevel:int=-1, xpRatio:Number=1, duration:Number=1):int
        {
            var rewLevel:int;
            var xpBonus:Number = (1 + (pXpBonus / 100));
            if (pPlayerLevel > optimalLevel)
            {
                rewLevel = Math.min(pPlayerLevel, (optimalLevel * REWARD_SCALE_CAP));
                return (((((1 - REWARD_REDUCED_SCALE) * this.getFixeExperienceReward(optimalLevel, duration, xpRatio)) + (REWARD_REDUCED_SCALE * this.getFixeExperienceReward(rewLevel, duration, xpRatio))) * xpBonus));
            };
            return ((this.getFixeExperienceReward(pPlayerLevel, duration, xpRatio) * xpBonus));
        }

        private function getFixeExperienceReward(level:int, duration:Number, xpRatio:Number):Number
        {
            return (((((level * Math.pow((100 + (2 * level)), 2)) / 20) * duration) * xpRatio));
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.managers

