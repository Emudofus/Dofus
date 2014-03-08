package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.tiphon.types.IAnimationModifier;
   import com.ankamagames.tiphon.types.ISkinModifier;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.dofus.logic.game.common.managers.EntitiesLooksManager;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.types.entities.RiderBehavior;
   import com.ankamagames.dofus.types.entities.AnimStatiqueSubEntityBehavior;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import flash.geom.Point;
   import com.ankamagames.jerakine.enum.OptionEnum;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.misc.utils.LookCleaner;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.jerakine.entities.interfaces.IAnimated;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.SwitchCreatureModeAction;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.datacenter.items.Incarnation;
   import com.ankamagames.dofus.logic.game.fight.miscs.CustomAnimStatiqueAnimationModifier;
   import com.ankamagames.dofus.types.entities.BreedSkinModifier;
   
   public class AbstractEntitiesFrame extends Object implements Frame
   {
      
      public function AbstractEntitiesFrame() {
         this._customAnimModifier = new CustomAnimStatiqueAnimationModifier();
         this._skinModifier = new BreedSkinModifier();
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractEntitiesFrame));
      
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
      
      protected var _worldPoint:WorldPointWrapper;
      
      protected var _creaturesFightMode:Boolean = false;
      
      protected var _justSwitchingCreaturesFightMode:Boolean = false;
      
      public function get playerIsOnRide() : Boolean {
         return this._playerIsOnRide;
      }
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function set untargetableEntities(param1:Boolean) : void {
         var _loc2_:GameContextActorInformations = null;
         var _loc3_:AnimatedCharacter = null;
         this._untargetableEntities = param1;
         for each (_loc2_ in this._entities)
         {
            _loc3_ = DofusEntities.getEntity(_loc2_.contextualId) as AnimatedCharacter;
            if(_loc3_)
            {
               _loc3_.mouseEnabled = !param1;
            }
         }
      }
      
      public function get untargetableEntities() : Boolean {
         return this._untargetableEntities;
      }
      
      public function get interactiveElements() : Vector.<InteractiveElement> {
         return this._interactiveElements;
      }
      
      public function get justSwitchingCreaturesFightMode() : Boolean {
         return this._justSwitchingCreaturesFightMode;
      }
      
      public function pushed() : Boolean {
         this._entities = new Dictionary();
         OptionManager.getOptionManager("atouin").addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onAtouinOptionChange);
         EntitiesLooksManager.getInstance().entitiesFrame = this;
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         throw new AbstractMethodCallError();
      }
      
      public function pulled() : Boolean {
         this._entities = null;
         Atouin.getInstance().clearEntities();
         OptionManager.getOptionManager("atouin").removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onAtouinOptionChange);
         return true;
      }
      
      public function getEntityInfos(param1:int) : GameContextActorInformations {
         if(!this._entities)
         {
            return null;
         }
         return this._entities[param1];
      }
      
      public function getEntitiesIdsList() : Vector.<int> {
         var _loc2_:GameContextActorInformations = null;
         var _loc1_:Vector.<int> = new Vector.<int>(0,false);
         for each (_loc2_ in this._entities)
         {
            _loc1_.push(_loc2_.contextualId);
         }
         return _loc1_;
      }
      
      public function getEntitiesDictionnary() : Dictionary {
         return this._entities;
      }
      
      public function registerActor(param1:GameContextActorInformations) : void {
         if(this._entities == null)
         {
            this._entities = new Dictionary();
         }
         this._entities[param1.contextualId] = param1;
      }
      
      public function addOrUpdateActor(param1:GameContextActorInformations, param2:IAnimationModifier=null) : AnimatedCharacter {
         var _loc5_:TiphonEntityLook = null;
         var _loc6_:TiphonEntityLook = null;
         var _loc7_:EntityLook = null;
         var _loc8_:EntityLook = null;
         var _loc9_:GameRolePlayHumanoidInformations = null;
         var _loc3_:AnimatedCharacter = DofusEntities.getEntity(param1.contextualId) as AnimatedCharacter;
         var _loc4_:* = true;
         _loc5_ = EntitiesLooksManager.getInstance().getLookFromContextInfos(param1);
         if(param1.contextualId == PlayedCharacterManager.getInstance().id)
         {
            if((this._creaturesMode) || (this._creaturesFightMode))
            {
               _loc7_ = EntityLookAdapter.toNetwork(_loc5_);
               if(PlayedCharacterManager.getInstance().infos.entityLook.bonesId != _loc7_.bonesId)
               {
                  PlayedCharacterManager.getInstance().realEntityLook = PlayedCharacterManager.getInstance().infos.entityLook;
               }
            }
         }
         if(_loc3_ == null)
         {
            _loc3_ = new AnimatedCharacter(param1.contextualId,_loc5_);
            _loc3_.addEventListener(TiphonEvent.PLAYANIM_EVENT,this.onPlayAnim);
            if(OptionManager.getOptionManager("atouin").useLowDefSkin)
            {
               _loc3_.setAlternativeSkinIndex(0,true);
            }
            if(_loc5_.getBone() == 1)
            {
               if(param2)
               {
                  _loc3_.addAnimationModifier(param2);
               }
               else
               {
                  _loc3_.addAnimationModifier(this._customAnimModifier);
               }
            }
            _loc3_.skinModifier = this._skinModifier;
            if(param1 is GameFightMonsterInformations)
            {
               _loc3_.speedAdjust = Monster.getMonsterById(GameFightMonsterInformations(param1).creatureGenericId).speedAdjust;
            }
            if(param1.contextualId == PlayedCharacterManager.getInstance().id)
            {
               _loc8_ = EntityLookAdapter.toNetwork(_loc5_);
               if(!EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook).equals(_loc5_))
               {
                  PlayedCharacterManager.getInstance().infos.entityLook = _loc8_;
                  KernelEventsManager.getInstance().processCallback(HookList.PlayedCharacterLookChange,_loc5_);
               }
            }
         }
         else
         {
            _loc4_ = false;
            if(this._humanNumber > 0)
            {
               this._humanNumber--;
            }
            if((this._creaturesMode) && param1 is GameRolePlayMerchantInformations)
            {
               _loc3_.look.updateFrom(_loc5_);
            }
            else
            {
               this.updateActorLook(param1.contextualId,param1.look,true);
            }
         }
         if(param1 is GameRolePlayHumanoidInformations)
         {
            _loc9_ = param1 as GameRolePlayHumanoidInformations;
            if(param1.contextualId == PlayedCharacterManager.getInstance().id)
            {
               PlayedCharacterManager.getInstance().restrictions = _loc9_.humanoidInfo.restrictions;
            }
         }
         if((!this._creaturesFightMode && !this._creaturesMode) && (_loc3_.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER)) && (_loc3_.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER).length))
         {
            _loc3_.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,new RiderBehavior());
         }
         if(_loc3_.id == PlayedCharacterManager.getInstance().id)
         {
            if((_loc3_.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER)) && (_loc3_.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER).length))
            {
               this._playerIsOnRide = true;
            }
            else
            {
               this._playerIsOnRide = false;
            }
         }
         if((!this._creaturesFightMode && !this._creaturesMode) && (_loc3_.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET)) && (_loc3_.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET).length))
         {
            _loc3_.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET,new AnimStatiqueSubEntityBehavior());
         }
         if(param1.disposition.cellId != -1)
         {
            _loc3_.position = MapPoint.fromCellId(param1.disposition.cellId);
         }
         if(_loc4_)
         {
            _loc3_.setDirection(param1.disposition.direction);
            _loc3_.display(PlacementStrataEnums.STRATA_PLAYER);
         }
         this.registerActor(param1);
         if(PlayedCharacterManager.getInstance().id == _loc3_.id)
         {
            SoundManager.getInstance().manager.setSoundSourcePosition(_loc3_.id,new Point(_loc3_.x,_loc3_.y));
         }
         _loc3_.visibleAura = OptionManager.getOptionManager("tiphon").auraMode >= OptionEnum.AURA_ALWAYS;
         _loc3_.mouseEnabled = !this.untargetableEntities;
         return _loc3_;
      }
      
      protected function updateActorLook(param1:int, param2:EntityLook, param3:Boolean=false) : AnimatedCharacter {
         var _loc5_:TiphonEntityLook = null;
         var _loc6_:GameContextActorInformations = null;
         var _loc7_:* = 0;
         var _loc8_:SerialSequencer = null;
         var _loc9_:AddGfxEntityStep = null;
         if(this._entities[param1])
         {
            _loc6_ = this._entities[param1] as GameContextActorInformations;
            _loc7_ = _loc6_.look.bonesId;
            _loc6_.look = param2;
            if((param3) && !(param2.bonesId == _loc7_))
            {
               _loc8_ = new SerialSequencer();
               _loc9_ = new AddGfxEntityStep(1165,DofusEntities.getEntity(param1).position.cellId);
               _loc8_.addStep(_loc9_);
               _loc8_.start();
            }
         }
         else
         {
            _log.warn("Cannot update unknown actor look (" + param1 + ") in informations.");
         }
         var _loc4_:AnimatedCharacter = DofusEntities.getEntity(param1) as AnimatedCharacter;
         if(_loc4_)
         {
            _loc4_.addEventListener(TiphonEvent.RENDER_FAILED,this.onUpdateEntityFail,false,0,false);
            _loc4_.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onUpdateEntitySuccess,false,0,false);
            if(param2.bonesId != 1)
            {
               _loc4_.removeAnimationModifier(this._customAnimModifier);
            }
            else
            {
               _loc4_.addAnimationModifier(this._customAnimModifier);
            }
            _loc5_ = EntitiesLooksManager.getInstance().getLookFromContextInfos(this._entities[param1]);
            _loc4_.enableSubCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,!this._creaturesFightMode);
            _loc4_.look.updateFrom(_loc5_);
            if((this._creaturesMode) || (this._creaturesFightMode))
            {
               _loc4_.setAnimation(AnimationEnum.ANIM_STATIQUE);
            }
            else
            {
               _loc4_.setAnimation(_loc4_.getAnimation());
            }
            if((_loc4_.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET)) && (_loc4_.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET).length))
            {
               _loc4_.setSubEntityBehaviour(1,new AnimStatiqueSubEntityBehavior());
            }
         }
         else
         {
            _log.warn("Cannot update unknown actor look (" + param1 + ") in the game world.");
         }
         if(param1 == PlayedCharacterManager.getInstance().id && (_loc5_))
         {
            if((this._creaturesMode) || (this._creaturesFightMode))
            {
               if(PlayedCharacterManager.getInstance().infos.entityLook.bonesId != param2.bonesId)
               {
                  PlayedCharacterManager.getInstance().realEntityLook = PlayedCharacterManager.getInstance().infos.entityLook;
               }
            }
            PlayedCharacterManager.getInstance().infos.entityLook = param2;
            KernelEventsManager.getInstance().processCallback(HookList.PlayedCharacterLookChange,LookCleaner.clean(_loc5_));
         }
         return _loc4_;
      }
      
      protected function updateActorDisposition(param1:int, param2:EntityDispositionInformations) : void {
         if(this._entities[param1])
         {
            (this._entities[param1] as GameContextActorInformations).disposition = param2;
         }
         else
         {
            _log.warn("Cannot update unknown actor disposition (" + param1 + ") in informations.");
         }
         var _loc3_:IEntity = DofusEntities.getEntity(param1);
         if(_loc3_)
         {
            if(_loc3_ is IMovable && param2.cellId >= 0)
            {
               if((_loc3_ is TiphonSprite) && ((_loc3_ as TiphonSprite).rootEntity) && !((_loc3_ as TiphonSprite).rootEntity == _loc3_))
               {
                  _log.debug("PAS DE SYNCHRO pour " + (_loc3_ as TiphonSprite).name + " car entité portée");
               }
               else
               {
                  IMovable(_loc3_).jump(MapPoint.fromCellId(param2.cellId));
               }
            }
            if(_loc3_ is IAnimated)
            {
               IAnimated(_loc3_).setDirection(param2.direction);
            }
         }
         else
         {
            _log.warn("Cannot update unknown actor disposition (" + param1 + ") in the game world.");
         }
      }
      
      protected function updateActorOrientation(param1:int, param2:uint) : void {
         var _loc4_:* = false;
         if(this._entities[param1])
         {
            (this._entities[param1] as GameContextActorInformations).disposition.direction = param2;
         }
         else
         {
            _log.warn("Cannot update unknown actor orientation (" + param1 + ") in informations.");
         }
         var _loc3_:AnimatedCharacter = DofusEntities.getEntity(param1) as AnimatedCharacter;
         if(_loc3_)
         {
            _loc4_ = false;
            if((OptionManager.getOptionManager("tiphon").auraMode >= OptionEnum.AURA_ALWAYS) && (OptionManager.getOptionManager("tiphon").alwaysShowAuraOnFront) && param2 == DirectionsEnum.DOWN)
            {
               _loc4_ = true;
            }
            _loc3_.visibleAura = _loc4_;
            _loc3_.setDirection(param2);
         }
         else
         {
            _log.warn("Cannot update unknown actor orientation (" + param1 + ") in the game world.");
         }
      }
      
      protected function hideActor(param1:int) : void {
         var _loc2_:IDisplayable = DofusEntities.getEntity(param1) as IDisplayable;
         if(_loc2_)
         {
            _loc2_.remove();
         }
         else
         {
            _log.warn("Cannot remove an unknown actor (" + param1 + ").");
         }
      }
      
      protected function removeActor(param1:int) : void {
         this.hideActor(param1);
         var _loc2_:TiphonSprite = DofusEntities.getEntity(param1) as TiphonSprite;
         if(_loc2_)
         {
            _loc2_.destroy();
         }
         this.updateCreaturesLimit();
         if(this._humanNumber > 0)
         {
            this._humanNumber--;
         }
         delete this._entities[[param1]];
         if(this.switchPokemonMode())
         {
            _log.debug("switch pokemon/normal mode");
         }
      }
      
      protected function switchPokemonMode() : Boolean {
         var _loc1_:SwitchCreatureModeAction = null;
         if(this._creaturesLimit > -1 && !(this._creaturesMode == (!Kernel.getWorker().getFrame(FightEntitiesFrame) && this._creaturesLimit < 50 && this._humanNumber >= this._creaturesLimit)))
         {
            _log.debug("human number: " + this._humanNumber + ", creature limit: " + this._creaturesLimit + " => " + this._creaturesMode);
            _loc1_ = SwitchCreatureModeAction.create(!this._creaturesMode);
            Kernel.getWorker().process(_loc1_);
            return true;
         }
         return false;
      }
      
      protected function updateCreaturesLimit() : void {
         var _loc1_:* = NaN;
         this._creaturesLimit = OptionManager.getOptionManager("tiphon").creaturesMode;
         if((this._creaturesMode) && this._creaturesLimit > 0)
         {
            _loc1_ = this._creaturesLimit * 20 / 100;
            this._creaturesLimit = Math.ceil(this._creaturesLimit - _loc1_);
         }
      }
      
      public function onPlayAnim(param1:TiphonEvent) : void {
         var _loc2_:Array = new Array();
         var _loc3_:String = param1.params.substring(6,param1.params.length-1);
         _loc2_ = _loc3_.split(",");
         param1.sprite.setAnimation(_loc2_[int(_loc2_.length * Math.random())]);
      }
      
      private function onAtouinOptionChange(param1:PropertyChangeEvent) : void {
         var _loc2_:Array = null;
         var _loc3_:* = undefined;
         if(param1.propertyName == "useLowDefSkin")
         {
            _loc2_ = EntitiesManager.getInstance().entities;
            for each (_loc3_ in _loc2_)
            {
               if(_loc3_ is TiphonSprite)
               {
                  TiphonSprite(_loc3_).setAlternativeSkinIndex(param1.propertyValue?0:-1,true);
               }
            }
         }
      }
      
      public function isInCreaturesFightMode() : Boolean {
         return this._creaturesFightMode;
      }
      
      private function onUpdateEntitySuccess(param1:TiphonEvent) : void {
         param1.sprite.removeEventListener(TiphonEvent.RENDER_FAILED,this.onUpdateEntityFail);
         param1.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onUpdateEntitySuccess);
      }
      
      private function onUpdateEntityFail(param1:TiphonEvent) : void {
         param1.sprite.removeEventListener(TiphonEvent.RENDER_FAILED,this.onUpdateEntityFail);
         param1.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onUpdateEntitySuccess);
         TiphonSprite(param1.sprite).setAnimation("AnimStatique");
      }
      
      private function isIncarnation(param1:String) : Boolean {
         var _loc3_:Incarnation = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc2_:Array = Incarnation.getAllIncarnation();
         var _loc4_:String = param1.slice(1,param1.indexOf("|"));
         for each (_loc3_ in _loc2_)
         {
            _loc5_ = _loc3_.lookMale.slice(1,_loc3_.lookMale.indexOf("|"));
            _loc6_ = _loc3_.lookFemale.slice(1,_loc3_.lookFemale.indexOf("|"));
            if(_loc4_ == _loc5_ || _loc4_ == _loc6_)
            {
               return true;
            }
         }
         return false;
      }
      
      protected function onPropertyChanged(param1:PropertyChangeEvent) : void {
         if(param1.propertyName == "mapCoordinates")
         {
            KernelEventsManager.getInstance().processCallback(HookList.MapComplementaryInformationsData,this._worldPoint,this._currentSubAreaId,param1.propertyValue);
         }
      }
   }
}
