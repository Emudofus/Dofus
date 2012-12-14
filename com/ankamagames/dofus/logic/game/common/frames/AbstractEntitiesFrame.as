package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.breeds.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.datacenter.monsters.*;
    import com.ankamagames.dofus.datacenter.mounts.*;
    import com.ankamagames.dofus.internalDatacenter.world.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.logic.game.common.actions.roleplay.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.miscs.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.dofus.types.sequences.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.events.*;
    import com.ankamagames.tiphon.types.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.geom.*;
    import flash.utils.*;

    public class AbstractEntitiesFrame extends Object implements Frame
    {
        protected var _entities:Dictionary;
        protected var _creaturesMode:Boolean = false;
        protected var _creaturesLimit:int = -1;
        protected var _humanNumber:uint = 0;
        protected var _playerIsOnRide:Boolean = false;
        protected var _customAnimModifier:IAnimationModifier;
        protected var _skinModifier:ISkinModifier;
        protected var _untargetableEntities:Boolean = false;
        protected var _interactiveElements:Vector.<InteractiveElement>;
        protected var _currentSubAreaId:uint;
        protected var _currentSubAreaSide:int;
        protected var _worldPoint:WorldPointWrapper;
        protected var _creaturesFightMode:Boolean = false;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractEntitiesFrame));

        public function AbstractEntitiesFrame()
        {
            this._customAnimModifier = new CustomAnimStatiqueAnimationModifier();
            this._skinModifier = new BreedSkinModifier();
            return;
        }// end function

        public function get playerIsOnRide() : Boolean
        {
            return this._playerIsOnRide;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function set untargetableEntities(param1:Boolean) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._untargetableEntities = param1;
            for each (_loc_2 in this._entities)
            {
                
                _loc_3 = DofusEntities.getEntity(_loc_2.contextualId) as AnimatedCharacter;
                if (_loc_3)
                {
                    _loc_3.mouseEnabled = !param1;
                }
            }
            return;
        }// end function

        public function get untargetableEntities() : Boolean
        {
            return this._untargetableEntities;
        }// end function

        public function get interactiveElements() : Vector.<InteractiveElement>
        {
            return this._interactiveElements;
        }// end function

        public function pushed() : Boolean
        {
            this._entities = new Dictionary();
            OptionManager.getOptionManager("atouin").addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onAtouinOptionChange);
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            throw new AbstractMethodCallError();
        }// end function

        public function pulled() : Boolean
        {
            this._entities = null;
            Atouin.getInstance().clearEntities();
            OptionManager.getOptionManager("atouin").removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onAtouinOptionChange);
            return true;
        }// end function

        public function getEntityInfos(param1:int) : GameContextActorInformations
        {
            if (!this._entities)
            {
                return null;
            }
            return this._entities[param1];
        }// end function

        public function getEntitiesIdsList() : Vector.<int>
        {
            var _loc_2:* = null;
            var _loc_1:* = new Vector.<int>(0, false);
            for each (_loc_2 in this._entities)
            {
                
                _loc_1.push(_loc_2.contextualId);
            }
            return _loc_1;
        }// end function

        public function getEntitiesDictionnary() : Dictionary
        {
            return this._entities;
        }// end function

        public function registerActor(param1:GameContextActorInformations) : void
        {
            if (this._entities == null)
            {
                this._entities = new Dictionary();
            }
            this._entities[param1.contextualId] = param1;
            return;
        }// end function

        public function addOrUpdateActor(param1:GameContextActorInformations, param2:IAnimationModifier = null) : AnimatedCharacter
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_3:* = DofusEntities.getEntity(param1.contextualId) as AnimatedCharacter;
            var _loc_4:* = true;
            if (!(param1 is GameRolePlayNpcInformations) && param1 is GameRolePlayHumanoidInformations)
            {
                if (this._creaturesMode && this.isIncarnation(EntityLookAdapter.fromNetwork(param1.look).toString()))
                {
                    _loc_5 = this.getFightPokemonLook(param1.look, false, false, true, false);
                }
                else
                {
                    _loc_5 = this.getLook(param1.look);
                }
            }
            else if (this._creaturesMode && param1 is GameRolePlayMerchantInformations)
            {
                _loc_5 = this.getDealerPokemonLook(param1.look);
            }
            else if (this._creaturesMode && param1 is GameRolePlayTaxCollectorInformations)
            {
                _loc_5 = this.getPercoPokemonLook(param1.look);
            }
            else if (this._creaturesFightMode && param1 is GameFightCharacterInformations)
            {
                _loc_5 = this.getLook(param1.look);
            }
            else if (this._creaturesFightMode && param1 is GameFightMonsterInformations)
            {
                _loc_5 = this.getFightPokemonLook(param1.look, true, (param1 as GameFightMonsterInformations).stats.summoned, false, false);
            }
            else
            {
                _loc_5 = EntityLookAdapter.fromNetwork(param1.look);
            }
            if (_loc_3 == null)
            {
                _loc_3 = new AnimatedCharacter(param1.contextualId, _loc_5);
                _loc_3.addEventListener(TiphonEvent.PLAYANIM_EVENT, this.onPlayAnim);
                if (OptionManager.getOptionManager("atouin").useLowDefSkin)
                {
                    _loc_3.setAlternativeSkinIndex(0, true);
                }
                if (_loc_5.getBone() == 1)
                {
                    if (param2)
                    {
                        _loc_3.addAnimationModifier(param2);
                    }
                    else
                    {
                        _loc_3.addAnimationModifier(this._customAnimModifier);
                    }
                }
                _loc_3.skinModifier = this._skinModifier;
                if (param1.contextualId == PlayedCharacterManager.getInstance().id)
                {
                    if (PlayedCharacterManager.getInstance().infos.entityLook != EntityLookAdapter.toNetwork(_loc_5))
                    {
                        PlayedCharacterManager.getInstance().infos.entityLook = EntityLookAdapter.toNetwork(_loc_5);
                        KernelEventsManager.getInstance().processCallback(HookList.PlayedCharacterLookChange, _loc_5);
                    }
                }
            }
            else
            {
                _loc_4 = false;
                if (this._humanNumber > 0)
                {
                    var _loc_7:* = this;
                    var _loc_8:* = this._humanNumber - 1;
                    _loc_7._humanNumber = _loc_8;
                }
                if (this._creaturesMode && param1 is GameRolePlayMerchantInformations)
                {
                    _loc_3.look.updateFrom(_loc_5);
                }
                else
                {
                    this.updateActorLook(param1.contextualId, param1.look, true);
                }
            }
            if (param1 is GameRolePlayHumanoidInformations)
            {
                _loc_6 = param1 as GameRolePlayHumanoidInformations;
                if (param1.contextualId == PlayedCharacterManager.getInstance().id)
                {
                    PlayedCharacterManager.getInstance().restrictions = _loc_6.humanoidInfo.restrictions;
                }
            }
            if (!this._creaturesFightMode && !this._creaturesMode && _loc_3.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER) && _loc_3.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER).length)
            {
                _loc_3.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, new RiderBehavior());
            }
            if (_loc_3.id == PlayedCharacterManager.getInstance().infos.id)
            {
                if (_loc_3.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER) && _loc_3.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER).length)
                {
                    this._playerIsOnRide = true;
                }
                else
                {
                    this._playerIsOnRide = false;
                }
            }
            if (!this._creaturesFightMode && !this._creaturesMode && _loc_3.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET) && _loc_3.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET).length)
            {
                _loc_3.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET, new AnimStatiqueSubEntityBehavior());
            }
            if (param1.disposition.cellId != -1)
            {
                _loc_3.position = MapPoint.fromCellId(param1.disposition.cellId);
            }
            if (_loc_4)
            {
                _loc_3.setDirection(param1.disposition.direction);
                _loc_3.display(PlacementStrataEnums.STRATA_PLAYER);
            }
            this.registerActor(param1);
            if (PlayedCharacterManager.getInstance().id == _loc_3.id)
            {
                SoundManager.getInstance().manager.setSoundSourcePosition(_loc_3.id, new Point(_loc_3.x, _loc_3.y));
            }
            _loc_3.mouseEnabled = !this.untargetableEntities;
            return _loc_3;
        }// end function

        protected function updateActorLook(param1:int, param2:EntityLook, param3:Boolean = false) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            if (this._entities[param1])
            {
                _loc_6 = this._entities[param1] as GameContextActorInformations;
                _loc_7 = _loc_6.look.bonesId;
                _loc_6.look = param2;
                if (param3 && param2.bonesId != _loc_7)
                {
                    _loc_8 = new SerialSequencer();
                    _loc_9 = new AddGfxEntityStep(1165, DofusEntities.getEntity(param1).position.cellId);
                    _loc_8.addStep(_loc_9);
                    _loc_8.start();
                }
            }
            else
            {
                _log.warn("Cannot update unknown actor look (" + param1 + ") in informations.");
            }
            var _loc_4:* = DofusEntities.getEntity(param1) as AnimatedCharacter;
            if (DofusEntities.getEntity(param1) as AnimatedCharacter)
            {
                _loc_4.addEventListener(TiphonEvent.RENDER_FAILED, this.onUpdateEntityFail, false, 0, false);
                _loc_4.addEventListener(TiphonEvent.RENDER_SUCCEED, this.onUpdateEntitySuccess, false, 0, false);
                if (param2.bonesId != 1)
                {
                    _loc_4.removeAnimationModifier(this._customAnimModifier);
                }
                else
                {
                    _loc_4.addAnimationModifier(this._customAnimModifier);
                }
                if (!this._creaturesFightMode && !(this._entities[param1] is GameRolePlayNpcInformations) && (this._entities[param1] is GameRolePlayHumanoidInformations || this._entities[param1] as GameFightCharacterInformations))
                {
                    if (this.isIncarnation(EntityLookAdapter.fromNetwork(param2).toString()) && this._creaturesMode)
                    {
                        _loc_5 = this.getFightPokemonLook(param2, false, false, true, false);
                    }
                    else
                    {
                        _loc_5 = this.getLook(param2, param1);
                    }
                }
                else if (this._creaturesFightMode && _loc_6 is GameFightTaxCollectorInformations)
                {
                    _loc_5 = this.getPercoPokemonLook(param2);
                }
                else if (this._entities[param1] is GameFightMonsterInformations && this._creaturesFightMode)
                {
                    if ((this._entities[param1] as GameFightMonsterInformations).stats.summoned)
                    {
                        _loc_5 = this.getFightPokemonLook(param2, true, true, false, false);
                    }
                    else
                    {
                        _loc_10 = Monster.getMonsterById((this._entities[param1] as GameFightMonsterInformations).creatureGenericId);
                        _loc_5 = this.getFightPokemonLook(param2, true, false, false, _loc_10 == null ? (false) : (_loc_10.isBoss));
                    }
                }
                else if (this._creaturesFightMode && this._entities[param1] is GameFightCharacterInformations)
                {
                    _loc_11 = TiphonUtility.getEntityWithoutMount(_loc_4) as TiphonSprite;
                    if (_loc_11.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_LIFTED_ENTITY, 0))
                    {
                        _loc_11.removeAnimationModifierByClass(CarrierAnimationModifier);
                    }
                    if ((this._entities[param1] as GameFightCharacterInformations).stats.summoned)
                    {
                        _loc_5 = this.getFightPokemonLook(param2, false, true, false, false);
                    }
                    else if (this.isIncarnation(EntityLookAdapter.fromNetwork(param2).toString()))
                    {
                        _loc_5 = this.getFightPokemonLook(param2, false, false, true, false);
                    }
                    else
                    {
                        _loc_5 = this.getLook(param2, param1);
                    }
                }
                else if (this._creaturesFightMode && this._entities[param1] is GameFightMutantInformations)
                {
                    _loc_5 = this.getFightPokemonLook(param2, true);
                }
                else
                {
                    _loc_5 = EntityLookAdapter.fromNetwork(param2);
                }
                _loc_4.enableSubCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, !this._creaturesFightMode);
                _loc_4.look.updateFrom(_loc_5);
                if (this._creaturesMode || this._creaturesFightMode)
                {
                    _loc_4.setAnimation(AnimationEnum.ANIM_STATIQUE);
                }
                else
                {
                    _loc_4.setAnimation(_loc_4.getAnimation());
                }
                if (_loc_4.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET) && _loc_4.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET).length)
                {
                    _loc_4.setSubEntityBehaviour(1, new AnimStatiqueSubEntityBehavior());
                }
            }
            else
            {
                _log.warn("Cannot update unknown actor look (" + param1 + ") in the game world.");
            }
            if (param1 == PlayedCharacterManager.getInstance().id && _loc_5)
            {
                PlayedCharacterManager.getInstance().infos.entityLook = param2;
                KernelEventsManager.getInstance().processCallback(HookList.PlayedCharacterLookChange, LookCleaner.clean(_loc_5));
            }
            return;
        }// end function

        protected function updateActorDisposition(param1:int, param2:EntityDispositionInformations) : void
        {
            if (this._entities[param1])
            {
                (this._entities[param1] as GameContextActorInformations).disposition = param2;
            }
            else
            {
                _log.warn("Cannot update unknown actor disposition (" + param1 + ") in informations.");
            }
            var _loc_3:* = DofusEntities.getEntity(param1);
            if (_loc_3)
            {
                if (_loc_3 is IMovable && param2.cellId >= 0)
                {
                    if (_loc_3 is TiphonSprite && (_loc_3 as TiphonSprite).rootEntity && (_loc_3 as TiphonSprite).rootEntity != _loc_3)
                    {
                        _log.debug("PAS DE SYNCHRO pour " + (_loc_3 as TiphonSprite).name + " car entité portée");
                    }
                    else
                    {
                        IMovable(_loc_3).jump(MapPoint.fromCellId(param2.cellId));
                    }
                }
                if (_loc_3 is IAnimated)
                {
                    IAnimated(_loc_3).setDirection(param2.direction);
                }
            }
            else
            {
                _log.warn("Cannot update unknown actor disposition (" + param1 + ") in the game world.");
            }
            return;
        }// end function

        protected function updateActorOrientation(param1:int, param2:uint) : void
        {
            if (this._entities[param1])
            {
                (this._entities[param1] as GameContextActorInformations).disposition.direction = param2;
            }
            else
            {
                _log.warn("Cannot update unknown actor orientation (" + param1 + ") in informations.");
            }
            var _loc_3:* = DofusEntities.getEntity(param1) as AnimatedCharacter;
            if (_loc_3)
            {
                if (param1 == PlayedCharacterManager.getInstance().id && param2 != DirectionsEnum.DOWN && _loc_3.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND, 0) && OptionManager.getOptionManager("tiphon").aura)
                {
                    _loc_3.look.removeSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND);
                }
                _loc_3.setDirection(param2);
            }
            else
            {
                _log.warn("Cannot update unknown actor orientation (" + param1 + ") in the game world.");
            }
            return;
        }// end function

        protected function hideActor(param1:int) : void
        {
            var _loc_2:* = DofusEntities.getEntity(param1) as IDisplayable;
            if (_loc_2)
            {
                _loc_2.remove();
            }
            else
            {
                _log.warn("Cannot remove an unknown actor (" + param1 + ").");
            }
            return;
        }// end function

        protected function removeActor(param1:int) : void
        {
            this.hideActor(param1);
            var _loc_2:* = DofusEntities.getEntity(param1) as TiphonSprite;
            if (_loc_2)
            {
                _loc_2.destroy();
            }
            this.updateCreaturesLimit();
            if (this._humanNumber > 0)
            {
                var _loc_3:* = this;
                var _loc_4:* = this._humanNumber - 1;
                _loc_3._humanNumber = _loc_4;
            }
            delete this._entities[param1];
            if (this.switchPokemonMode())
            {
                _log.debug("switch pokemon/normal mode");
            }
            return;
        }// end function

        protected function switchPokemonMode() : Boolean
        {
            var _loc_1:* = null;
            if (this._creaturesLimit > -1 && this._creaturesMode != (!Kernel.getWorker().getFrame(FightEntitiesFrame) && this._creaturesLimit < 50 && this._humanNumber >= this._creaturesLimit))
            {
                _log.debug("human number: " + this._humanNumber + ", creature limit: " + this._creaturesLimit + " => " + this._creaturesMode);
                _loc_1 = SwitchCreatureModeAction.create(!this._creaturesMode);
                Kernel.getWorker().process(_loc_1);
                return true;
            }
            return false;
        }// end function

        protected function getLook(param1:EntityLook, param2:int = -1) : TiphonEntityLook
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_3:* = EntityLookAdapter.fromNetwork(param1);
            var _loc_4:* = _loc_3;
            if (this._creaturesMode || this._creaturesFightMode)
            {
                _loc_6 = 0;
                _loc_7 = MountBone.getMountBonesIds();
                if (this.isBoneCorrect(_loc_3.getBone()))
                {
                    if (param2 != -1 && this._entities[param2].hasOwnProperty("breed"))
                    {
                        _loc_6 = this._entities[param2].breed;
                    }
                    else
                    {
                        _loc_6 = Breed.getBreedFromSkin(_loc_3.firstSkin).id;
                    }
                }
                else if (_loc_7.indexOf(_loc_3.getBone()) != -1)
                {
                    _loc_5 = TiphonUtility.getLookWithoutMount(_loc_3);
                    if (_loc_5 != _loc_3)
                    {
                        if (this.isBoneCorrect(_loc_5.getBone()))
                        {
                            if (param2 != -1 && this._entities[param2].hasOwnProperty("breed"))
                            {
                                _loc_6 = this._entities[param2].breed;
                            }
                            else
                            {
                                _loc_6 = Breed.getBreedFromSkin(_loc_5.firstSkin).id;
                            }
                        }
                    }
                }
                if (_loc_6 == 0)
                {
                    if (param2 != -1 && this._entities[param2].hasOwnProperty("breed"))
                    {
                        _loc_6 = this._entities[param2].breed;
                    }
                    else
                    {
                        _loc_8 = _loc_5 ? (_loc_5.getBone()) : (_loc_3.getBone());
                        switch(_loc_8)
                        {
                            case 453:
                            {
                                _loc_6 = 12;
                                break;
                            }
                            case 706:
                            case 1504:
                            case 1509:
                            {
                                return this.getFightPokemonLook(param1, false, false, true, false);
                            }
                            case 923:
                            {
                            }
                            default:
                            {
                                return _loc_5 ? (_loc_5) : (_loc_3);
                                break;
                            }
                        }
                    }
                }
                _loc_4.setBone(Breed.getBreedById(_loc_6).creatureBonesId);
                _loc_4.setScales(0.9, 0.9);
            }
            else if (!OptionManager.getOptionManager("tiphon").aura)
            {
                _loc_4.removeSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND);
            }
            return _loc_4;
        }// end function

        private function isBoneCorrect(param1:int) : Boolean
        {
            if (param1 == 1 || param1 == 113 || param1 == 44 || param1 == 1575 || param1 == 1576)
            {
                return true;
            }
            return false;
        }// end function

        protected function getFightPokemonLook(param1:EntityLook, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) : TiphonEntityLook
        {
            var _loc_8:* = 0;
            var _loc_6:* = EntityLookAdapter.fromNetwork(param1);
            var _loc_7:* = EntityLookAdapter.fromNetwork(param1);
            switch(param2)
            {
                case true:
                {
                    if (param3)
                    {
                        _loc_8 = 1765;
                    }
                    else if (param5)
                    {
                        _loc_8 = 1748;
                    }
                    else
                    {
                        _loc_8 = 1747;
                    }
                    break;
                }
                case false:
                {
                    if (param3)
                    {
                        _loc_8 = 1765;
                    }
                    else if (param4)
                    {
                        _loc_8 = 1749;
                    }
                    else
                    {
                        _loc_8 = _loc_6.getBone();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_7.setBone(_loc_8);
            _loc_7.setScales(0.9, 0.9);
            return _loc_7;
        }// end function

        private function getPercoPokemonLook(param1:EntityLook) : TiphonEntityLook
        {
            var _loc_2:* = EntityLookAdapter.fromNetwork(param1);
            _loc_2.setBone(1813);
            _loc_2.setScales(0.9, 0.9);
            return _loc_2;
        }// end function

        private function getDealerPokemonLook(param1:EntityLook) : TiphonEntityLook
        {
            var _loc_2:* = EntityLookAdapter.fromNetwork(param1);
            _loc_2.setBone(1965);
            _loc_2.setScales(0.9, 0.9);
            return _loc_2;
        }// end function

        protected function updateCreaturesLimit() : void
        {
            var _loc_1:* = NaN;
            this._creaturesLimit = OptionManager.getOptionManager("tiphon").creaturesMode;
            if (this._creaturesMode && this._creaturesLimit > 0)
            {
                _loc_1 = this._creaturesLimit * 20 / 100;
                this._creaturesLimit = Math.ceil(this._creaturesLimit - _loc_1);
            }
            return;
        }// end function

        public function onPlayAnim(event:TiphonEvent) : void
        {
            var _loc_2:* = new Array();
            var _loc_3:* = event.params.substring(6, (event.params.length - 1));
            _loc_2 = _loc_3.split(",");
            event.sprite.setAnimation(_loc_2[int(_loc_2.length * Math.random())]);
            return;
        }// end function

        private function onAtouinOptionChange(event:PropertyChangeEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            if (event.propertyName == "useLowDefSkin")
            {
                _loc_2 = EntitiesManager.getInstance().entities;
                for each (_loc_3 in _loc_2)
                {
                    
                    if (_loc_3 is TiphonSprite)
                    {
                        TiphonSprite(_loc_3).setAlternativeSkinIndex(event.propertyValue ? (0) : (-1), true);
                    }
                }
            }
            return;
        }// end function

        public function isInCreaturesFightMode() : Boolean
        {
            return this._creaturesFightMode;
        }// end function

        private function onUpdateEntitySuccess(event:TiphonEvent) : void
        {
            event.sprite.removeEventListener(TiphonEvent.RENDER_FAILED, this.onUpdateEntityFail);
            event.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onUpdateEntitySuccess);
            return;
        }// end function

        private function onUpdateEntityFail(event:TiphonEvent) : void
        {
            event.sprite.removeEventListener(TiphonEvent.RENDER_FAILED, this.onUpdateEntityFail);
            event.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onUpdateEntitySuccess);
            TiphonSprite(event.sprite).setAnimation("AnimStatique");
            return;
        }// end function

        private function isIncarnation(param1:String) : Boolean
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = Incarnation.getAllIncarnation();
            var _loc_4:* = param1.slice(1, param1.indexOf("|"));
            for each (_loc_3 in _loc_2)
            {
                
                _loc_5 = _loc_3.lookMale.slice(1, _loc_3.lookMale.indexOf("|"));
                _loc_6 = _loc_3.lookFemale.slice(1, _loc_3.lookFemale.indexOf("|"));
                if (_loc_4 == _loc_5 || _loc_4 == _loc_6)
                {
                    return true;
                }
            }
            return false;
        }// end function

    }
}
