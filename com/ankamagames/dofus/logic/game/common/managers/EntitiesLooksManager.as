package com.ankamagames.dofus.logic.game.common.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.datacenter.breeds.Breed;
    import com.ankamagames.dofus.datacenter.appearance.CreatureBoneType;
    import com.ankamagames.dofus.datacenter.items.Incarnation;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCompanionInformations;
    import com.ankamagames.dofus.datacenter.monsters.Companion;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.tiphon.types.TiphonUtility;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
    import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightTaxCollectorInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMutantInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
    import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;

    public class EntitiesLooksManager 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(EntitiesLooksManager));
        private static var _self:EntitiesLooksManager;

        private var _entitiesFrame:AbstractEntitiesFrame;


        public static function getInstance():EntitiesLooksManager
        {
            if (!(_self))
            {
                _self = new (EntitiesLooksManager)();
            };
            return (_self);
        }


        public function set entitiesFrame(pFrame:AbstractEntitiesFrame):void
        {
            this._entitiesFrame = pFrame;
        }

        public function isCreatureMode():Boolean
        {
            return ((((this._entitiesFrame is RoleplayEntitiesFrame)) ? ((this._entitiesFrame as RoleplayEntitiesFrame).isCreatureMode) : (this._entitiesFrame as FightEntitiesFrame).isInCreaturesFightMode()));
        }

        public function isCreature(pEntityId:int):Boolean
        {
            var look:TiphonEntityLook = this.getTiphonEntityLook(pEntityId);
            if (look)
            {
                if (((this.isCreatureFromLook(look)) || (((this.isCreatureMode()) && ((this.getLookFromContext(pEntityId).getBone() == look.getBone()))))))
                {
                    return (true);
                };
            };
            return (false);
        }

        public function isCreatureFromLook(pLook:TiphonEntityLook):Boolean
        {
            var breed:Breed;
            var bone:uint = pLook.getBone();
            var breeds:Array = Breed.getBreeds();
            for each (breed in breeds)
            {
                if (breed.creatureBonesId == bone)
                {
                    return (true);
                };
            };
            if (pLook.getBone() == CreatureBoneType.getPlayerIncarnationCreatureBone())
            {
                return (true);
            };
            return (false);
        }

        public function isIncarnation(pEntityId:int):Boolean
        {
            var look:TiphonEntityLook = this.getRealTiphonEntityLook(pEntityId, true);
            if (((look) && (this.isIncarnationFromLook(look))))
            {
                return (true);
            };
            return (false);
        }

        public function isIncarnationFromLook(pLook:TiphonEntityLook):Boolean
        {
            var incarnation:Incarnation;
            var boneIdMale:String;
            var boneIdFemale:String;
            if (pLook.getBone() == CreatureBoneType.getPlayerIncarnationCreatureBone())
            {
                return (true);
            };
            var incarnations:Array = Incarnation.getAllIncarnation();
            var entityLookStr:String = pLook.toString();
            var boneId:String = entityLookStr.slice(1, entityLookStr.indexOf("|"));
            for each (incarnation in incarnations)
            {
                boneIdMale = incarnation.lookMale.slice(1, incarnation.lookMale.indexOf("|"));
                boneIdFemale = incarnation.lookFemale.slice(1, incarnation.lookFemale.indexOf("|"));
                if ((((boneId == boneIdMale)) || ((boneId == boneIdFemale))))
                {
                    return (true);
                };
            };
            return (false);
        }

        public function getTiphonEntityLook(pEntityId:int):TiphonEntityLook
        {
            var char:AnimatedCharacter = (DofusEntities.getEntity(pEntityId) as AnimatedCharacter);
            return (((char) ? char.look.clone() : null));
        }

        public function getRealTiphonEntityLook(pEntityId:int, pWithoutMount:Boolean=false):TiphonEntityLook
        {
            var entityLook:EntityLook;
            var _local_5:GameContextActorInformations;
            var riderLook:TiphonEntityLook;
            if (this._entitiesFrame)
            {
                if ((this._entitiesFrame is FightEntitiesFrame))
                {
                    entityLook = (this._entitiesFrame as FightEntitiesFrame).getRealFighterLook(pEntityId);
                }
                else
                {
                    _local_5 = this._entitiesFrame.getEntityInfos(pEntityId);
                    entityLook = ((_local_5) ? _local_5.look : null);
                };
            };
            if (((!(entityLook)) && ((pEntityId == PlayedCharacterManager.getInstance().id))))
            {
                entityLook = PlayedCharacterManager.getInstance().infos.entityLook;
            };
            var look:TiphonEntityLook = ((entityLook) ? EntityLookAdapter.fromNetwork(entityLook) : null);
            if (((look) && (pWithoutMount)))
            {
                riderLook = look.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0);
                if (riderLook)
                {
                    look = riderLook;
                };
            };
            return (look);
        }

        public function getCreatureLook(pEntityId:int):TiphonEntityLook
        {
            var infos:GameContextActorInformations = ((this._entitiesFrame) ? this._entitiesFrame.getEntityInfos(pEntityId) : null);
            return (((infos) ? this.getLookFromContextInfos(infos, true) : null));
        }

        public function getLookFromContext(pEntityId:int, pForceCreature:Boolean=false):TiphonEntityLook
        {
            var infos:GameContextActorInformations = ((this._entitiesFrame) ? this._entitiesFrame.getEntityInfos(pEntityId) : null);
            return (((infos) ? this.getLookFromContextInfos(infos, pForceCreature) : null));
        }

        public function getLookFromContextInfos(pInfos:GameContextActorInformations, pForceCreature:Boolean=false):TiphonEntityLook
        {
            var _local_4:GameFightCompanionInformations;
            var _local_5:Companion;
            var _local_6:GameFightMonsterInformations;
            var _local_7:Boolean;
            var _local_8:Monster;
            var _local_9:int;
            var _local_10:TiphonEntityLook;
            var _local_11:int;
            var _local_12:Boolean;
            var _local_13:Breed;
            var fighterLook:TiphonEntityLook;
            var oldBone:int;
            var entityStates:Array;
            var look:TiphonEntityLook = EntityLookAdapter.fromNetwork(pInfos.look);
            if (((this.isCreatureMode()) || (pForceCreature)))
            {
                switch (true)
                {
                    case (pInfos is GameRolePlayHumanoidInformations):
                    case (pInfos is GameFightCharacterInformations):
                        if (this.isIncarnation(pInfos.contextualId))
                        {
                            look.setBone(CreatureBoneType.getPlayerIncarnationCreatureBone());
                        }
                        else
                        {
                            _local_10 = ((look.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0)) ? (TiphonUtility.getLookWithoutMount(look)) : look);
                            _local_11 = ((pInfos.hasOwnProperty("breed")) ? pInfos["breed"] : 0);
                            _local_12 = this.isBoneCorrect(_local_10.getBone());
                            _local_13 = Breed.getBreedFromSkin(_local_10.firstSkin);
                            if ((((((_local_11 <= 0)) && (_local_12))) && (_local_13)))
                            {
                                _local_11 = _local_13.id;
                            }
                            else
                            {
                                if (!(_local_12))
                                {
                                    switch (_local_10.getBone())
                                    {
                                        case 453:
                                            _local_11 = 12;
                                            break;
                                        case 706:
                                        case 1504:
                                        case 1509:
                                        case 113:
                                            look.setBone(CreatureBoneType.getPlayerIncarnationCreatureBone());
                                            break;
                                    };
                                };
                            };
                            if (_local_11 > 0)
                            {
                                look.setBone(Breed.getBreedById(_local_11).creatureBonesId);
                            }
                            else
                            {
                                return (look);
                            };
                        };
                        break;
                    case (pInfos is GameRolePlayPrismInformations):
                        look.setBone(CreatureBoneType.getPrismCreatureBone());
                        break;
                    case (pInfos is GameRolePlayMerchantInformations):
                        look.setBone(CreatureBoneType.getPlayerMerchantCreatureBone());
                        break;
                    case (pInfos is GameRolePlayTaxCollectorInformations):
                    case (pInfos is GameFightTaxCollectorInformations):
                        look.setBone(CreatureBoneType.getTaxCollectorCreatureBone());
                        break;
                    case (pInfos is GameFightCompanionInformations):
                        _local_4 = (pInfos as GameFightCompanionInformations);
                        _local_5 = Companion.getCompanionById(_local_4.companionGenericId);
                        look.setBone(_local_5.creatureBoneId);
                        break;
                    case (pInfos is GameFightMutantInformations):
                        look.setBone(CreatureBoneType.getMonsterCreatureBone());
                        break;
                    case (pInfos is GameFightMonsterInformations):
                        _local_6 = (pInfos as GameFightMonsterInformations);
                        _local_7 = (_local_6.creatureGenericId == 3451);
                        _local_8 = Monster.getMonsterById(_local_6.creatureGenericId);
                        if (_local_6.stats.summoned)
                        {
                            _local_9 = CreatureBoneType.getMonsterInvocationCreatureBone();
                        }
                        else
                        {
                            if (_local_8.isBoss)
                            {
                                _local_9 = CreatureBoneType.getBossMonsterCreatureBone();
                            }
                            else
                            {
                                if (_local_7)
                                {
                                    _local_9 = CreatureBoneType.getPrismCreatureBone();
                                }
                                else
                                {
                                    _local_9 = CreatureBoneType.getMonsterCreatureBone();
                                };
                            };
                        };
                        look.setBone(_local_9);
                        break;
                    case (pInfos is GameRolePlayActorInformations):
                        return (look);
                };
                look.setScales(0.9, 0.9);
            }
            else
            {
                if ((((pInfos is GameFightCharacterInformations)) && (!((this._entitiesFrame as FightEntitiesFrame).charactersMountsVisible))))
                {
                    fighterLook = look.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0);
                    if (!(fighterLook))
                    {
                        fighterLook = look;
                    };
                    oldBone = fighterLook.getBone();
                    look = TiphonUtility.getLookWithoutMount(look);
                    if (oldBone == 2)
                    {
                        entityStates = FightersStateManager.getInstance().getStates(pInfos.contextualId);
                        if (entityStates)
                        {
                            if (entityStates.indexOf(98) == -1)
                            {
                                if (entityStates.indexOf(99) != -1)
                                {
                                    look.setBone(1575);
                                }
                                else
                                {
                                    if (entityStates.indexOf(100) != -1)
                                    {
                                        look.setBone(1576);
                                    };
                                };
                            };
                        };
                    };
                };
            };
            return (look);
        }

        private function isBoneCorrect(boneId:int):Boolean
        {
            if ((((((((boneId == 1)) || ((boneId == 44)))) || ((boneId == 1575)))) || ((boneId == 1576))))
            {
                return (true);
            };
            return (false);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.managers

