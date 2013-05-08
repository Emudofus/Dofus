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
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
   import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.types.entities.RiderBehavior;
   import com.ankamagames.dofus.types.entities.AnimStatiqueSubEntityBehavior;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import flash.geom.Point;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightTaxCollectorInformations;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.dofus.logic.game.fight.miscs.CarrierAnimationModifier;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMutantInformations;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.misc.utils.LookCleaner;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.entities.interfaces.IAnimated;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.SwitchCreatureModeAction;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.datacenter.mounts.MountBone;
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.datacenter.items.Incarnation;
   import com.ankamagames.dofus.logic.game.fight.miscs.CustomAnimStatiqueAnimationModifier;
   import com.ankamagames.dofus.types.entities.BreedSkinModifier;


   public class AbstractEntitiesFrame extends Object implements Frame
   {
         

      public function AbstractEntitiesFrame() {
         this._customAnimModifier=new CustomAnimStatiqueAnimationModifier();
         this._skinModifier=new BreedSkinModifier();
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

      protected var _currentSubAreaSide:int;

      protected var _worldPoint:WorldPointWrapper;

      protected var _creaturesFightMode:Boolean = false;

      public function get playerIsOnRide() : Boolean {
         return this._playerIsOnRide;
      }

      public function get priority() : int {
         return Priority.NORMAL;
      }

      public function set untargetableEntities(enabled:Boolean) : void {
         var infos:GameContextActorInformations = null;
         var entity:AnimatedCharacter = null;
         this._untargetableEntities=enabled;
         for each (infos in this._entities)
         {
            entity=DofusEntities.getEntity(infos.contextualId) as AnimatedCharacter;
            if(entity)
            {
               entity.mouseEnabled=!enabled;
            }
         }
      }

      public function get untargetableEntities() : Boolean {
         return this._untargetableEntities;
      }

      public function get interactiveElements() : Vector.<InteractiveElement> {
         return this._interactiveElements;
      }

      public function pushed() : Boolean {
         this._entities=new Dictionary();
         OptionManager.getOptionManager("atouin").addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onAtouinOptionChange);
         return true;
      }

      public function process(msg:Message) : Boolean {
         throw new AbstractMethodCallError();
      }

      public function pulled() : Boolean {
         this._entities=null;
         Atouin.getInstance().clearEntities();
         OptionManager.getOptionManager("atouin").removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onAtouinOptionChange);
         return true;
      }

      public function getEntityInfos(entityId:int) : GameContextActorInformations {
         if(!this._entities)
         {
            return null;
         }
         return this._entities[entityId];
      }

      public function getEntitiesIdsList() : Vector.<int> {
         var gcai:GameContextActorInformations = null;
         var entitiesList:Vector.<int> = new Vector.<int>(0,false);
         for each (gcai in this._entities)
         {
            entitiesList.push(gcai.contextualId);
         }
         return entitiesList;
      }

      public function getEntitiesDictionnary() : Dictionary {
         return this._entities;
      }

      public function registerActor(infos:GameContextActorInformations) : void {
         if(this._entities==null)
         {
            this._entities=new Dictionary();
         }
         this._entities[infos.contextualId]=infos;
      }

      public function addOrUpdateActor(infos:GameContextActorInformations, animationModifier:IAnimationModifier=null) : AnimatedCharacter {
         var newLook:TiphonEntityLook = null;
         var entitylookNew:EntityLook = null;
         var entitylook:EntityLook = null;
         var humanoid:GameRolePlayHumanoidInformations = null;
         var characterEntity:AnimatedCharacter = DofusEntities.getEntity(infos.contextualId) as AnimatedCharacter;
         var justCreated:Boolean = true;
         if((!(infos is GameRolePlayNpcInformations))&&(infos is GameRolePlayHumanoidInformations))
         {
            if((this._creaturesMode)&&(this.isIncarnation(EntityLookAdapter.fromNetwork(infos.look).toString())))
            {
               newLook=this.getFightPokemonLook(infos.look,false,false,true,false);
            }
            else
            {
               newLook=this.getLook(infos.look);
            }
         }
         else
         {
            if((this._creaturesMode)&&(infos is GameRolePlayMerchantInformations))
            {
               newLook=this.getDealerPokemonLook(infos.look);
            }
            else
            {
               if((this._creaturesMode)&&(infos is GameRolePlayTaxCollectorInformations))
               {
                  newLook=this.getPercoPokemonLook(infos.look);
               }
               else
               {
                  if((this._creaturesFightMode)&&(infos is GameFightCharacterInformations))
                  {
                     newLook=this.getLook(infos.look);
                  }
                  else
                  {
                     if((this._creaturesFightMode)&&(infos is GameFightMonsterInformations))
                     {
                        newLook=this.getFightPokemonLook(infos.look,true,(infos as GameFightMonsterInformations).stats.summoned,false,false);
                     }
                     else
                     {
                        newLook=EntityLookAdapter.fromNetwork(infos.look);
                     }
                  }
               }
            }
         }
         if(infos.contextualId==PlayedCharacterManager.getInstance().id)
         {
            if((this._creaturesMode)||(this._creaturesFightMode))
            {
               entitylookNew=EntityLookAdapter.toNetwork(newLook);
               if(PlayedCharacterManager.getInstance().infos.entityLook.bonesId!=entitylookNew.bonesId)
               {
                  PlayedCharacterManager.getInstance().realEntityLook=PlayedCharacterManager.getInstance().infos.entityLook;
               }
            }
         }
         if(characterEntity==null)
         {
            characterEntity=new AnimatedCharacter(infos.contextualId,newLook);
            characterEntity.addEventListener(TiphonEvent.PLAYANIM_EVENT,this.onPlayAnim);
            if(OptionManager.getOptionManager("atouin").useLowDefSkin)
            {
               characterEntity.setAlternativeSkinIndex(0,true);
            }
            if(newLook.getBone()==1)
            {
               if(animationModifier)
               {
                  characterEntity.addAnimationModifier(animationModifier);
               }
               else
               {
                  characterEntity.addAnimationModifier(this._customAnimModifier);
               }
            }
            characterEntity.skinModifier=this._skinModifier;
            if(infos.contextualId==PlayedCharacterManager.getInstance().id)
            {
               entitylook=EntityLookAdapter.toNetwork(newLook);
               if(PlayedCharacterManager.getInstance().infos.entityLook!=entitylook)
               {
                  PlayedCharacterManager.getInstance().infos.entityLook=entitylook;
                  KernelEventsManager.getInstance().processCallback(HookList.PlayedCharacterLookChange,newLook);
               }
            }
         }
         else
         {
            justCreated=false;
            if(this._humanNumber>0)
            {
               this._humanNumber--;
            }
            if((this._creaturesMode)&&(infos is GameRolePlayMerchantInformations))
            {
               characterEntity.look.updateFrom(newLook);
            }
            else
            {
               this.updateActorLook(infos.contextualId,infos.look,true);
            }
         }
         if(infos is GameRolePlayHumanoidInformations)
         {
            humanoid=infos as GameRolePlayHumanoidInformations;
            if(infos.contextualId==PlayedCharacterManager.getInstance().id)
            {
               PlayedCharacterManager.getInstance().restrictions=humanoid.humanoidInfo.restrictions;
            }
         }
         if((!this._creaturesFightMode&&!this._creaturesMode)&&(characterEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER))&&(characterEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER).length))
         {
            characterEntity.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,new RiderBehavior());
         }
         if(characterEntity.id==PlayedCharacterManager.getInstance().infos.id)
         {
            if((characterEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER))&&(characterEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER).length))
            {
               this._playerIsOnRide=true;
            }
            else
            {
               this._playerIsOnRide=false;
            }
         }
         if((!this._creaturesFightMode&&!this._creaturesMode)&&(characterEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET))&&(characterEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET).length))
         {
            characterEntity.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET,new AnimStatiqueSubEntityBehavior());
         }
         if(infos.disposition.cellId!=-1)
         {
            characterEntity.position=MapPoint.fromCellId(infos.disposition.cellId);
         }
         if(justCreated)
         {
            characterEntity.setDirection(infos.disposition.direction);
            characterEntity.display(PlacementStrataEnums.STRATA_PLAYER);
         }
         this.registerActor(infos);
         if(PlayedCharacterManager.getInstance().id==characterEntity.id)
         {
            SoundManager.getInstance().manager.setSoundSourcePosition(characterEntity.id,new Point(characterEntity.x,characterEntity.y));
         }
         characterEntity.mouseEnabled=!this.untargetableEntities;
         return characterEntity;
      }

      protected function updateActorLook(actorId:int, newLook:EntityLook, smoke:Boolean=false) : void {
         var tel:TiphonEntityLook = null;
         var entity:GameContextActorInformations = null;
         var oldBone:* = 0;
         var sequencer:SerialSequencer = null;
         var addGfxStep:AddGfxEntityStep = null;
         var m:Monster = null;
         var rider:TiphonSprite = null;
         if(this._entities[actorId])
         {
            entity=this._entities[actorId] as GameContextActorInformations;
            oldBone=entity.look.bonesId;
            entity.look=newLook;
            if((smoke)&&(!(newLook.bonesId==oldBone)))
            {
               sequencer=new SerialSequencer();
               addGfxStep=new AddGfxEntityStep(1165,DofusEntities.getEntity(actorId).position.cellId);
               sequencer.addStep(addGfxStep);
               sequencer.start();
            }
         }
         else
         {
            _log.warn("Cannot update unknown actor look ("+actorId+") in informations.");
         }
         var ac:AnimatedCharacter = DofusEntities.getEntity(actorId) as AnimatedCharacter;
         if(ac)
         {
            ac.addEventListener(TiphonEvent.RENDER_FAILED,this.onUpdateEntityFail,false,0,false);
            ac.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onUpdateEntitySuccess,false,0,false);
            if(newLook.bonesId!=1)
            {
               ac.removeAnimationModifier(this._customAnimModifier);
            }
            else
            {
               ac.addAnimationModifier(this._customAnimModifier);
            }
            if((!this._creaturesFightMode)&&(!(this._entities[actorId] is GameRolePlayNpcInformations))&&((this._entities[actorId] is GameRolePlayHumanoidInformations)||(this._entities[actorId] as GameFightCharacterInformations)))
            {
               if((this.isIncarnation(EntityLookAdapter.fromNetwork(newLook).toString()))&&(this._creaturesMode))
               {
                  tel=this.getFightPokemonLook(newLook,false,false,true,false);
               }
               else
               {
                  tel=this.getLook(newLook,actorId);
               }
            }
            else
            {
               if((this._creaturesFightMode)&&(entity is GameFightTaxCollectorInformations))
               {
                  tel=this.getPercoPokemonLook(newLook);
               }
               else
               {
                  if((this._entities[actorId] is GameFightMonsterInformations)&&(this._creaturesFightMode))
                  {
                     if((this._entities[actorId] as GameFightMonsterInformations).stats.summoned)
                     {
                        tel=this.getFightPokemonLook(newLook,true,true,false,false);
                     }
                     else
                     {
                        m=Monster.getMonsterById((this._entities[actorId] as GameFightMonsterInformations).creatureGenericId);
                        tel=this.getFightPokemonLook(newLook,true,false,false,m==null?false:m.isBoss);
                     }
                  }
                  else
                  {
                     if((this._creaturesFightMode)&&(this._entities[actorId] is GameFightCharacterInformations))
                     {
                        rider=TiphonUtility.getEntityWithoutMount(ac) as TiphonSprite;
                        if(rider.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_LIFTED_ENTITY,0))
                        {
                           rider.removeAnimationModifierByClass(CarrierAnimationModifier);
                        }
                        if((this._entities[actorId] as GameFightCharacterInformations).stats.summoned)
                        {
                           tel=this.getFightPokemonLook(newLook,false,true,false,false);
                        }
                        else
                        {
                           if(this.isIncarnation(EntityLookAdapter.fromNetwork(newLook).toString()))
                           {
                              tel=this.getFightPokemonLook(newLook,false,false,true,false);
                           }
                           else
                           {
                              tel=this.getLook(newLook,actorId);
                           }
                        }
                     }
                     else
                     {
                        if((this._creaturesFightMode)&&(this._entities[actorId] is GameFightMutantInformations))
                        {
                           tel=this.getFightPokemonLook(newLook,true);
                        }
                        else
                        {
                           tel=EntityLookAdapter.fromNetwork(newLook);
                        }
                     }
                  }
               }
            }
            ac.enableSubCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,!this._creaturesFightMode);
            ac.look.updateFrom(tel);
            if((this._creaturesMode)||(this._creaturesFightMode))
            {
               ac.setAnimation(AnimationEnum.ANIM_STATIQUE);
            }
            else
            {
               ac.setAnimation(ac.getAnimation());
            }
            if((ac.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET))&&(ac.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET).length))
            {
               ac.setSubEntityBehaviour(1,new AnimStatiqueSubEntityBehavior());
            }
         }
         else
         {
            _log.warn("Cannot update unknown actor look ("+actorId+") in the game world.");
         }
         if((actorId==PlayedCharacterManager.getInstance().id)&&(tel))
         {
            if((this._creaturesMode)||(this._creaturesFightMode))
            {
               if(PlayedCharacterManager.getInstance().infos.entityLook.bonesId!=newLook.bonesId)
               {
                  PlayedCharacterManager.getInstance().realEntityLook=PlayedCharacterManager.getInstance().infos.entityLook;
               }
            }
            PlayedCharacterManager.getInstance().infos.entityLook=newLook;
            KernelEventsManager.getInstance().processCallback(HookList.PlayedCharacterLookChange,LookCleaner.clean(tel));
         }
      }

      protected function updateActorDisposition(actorId:int, newDisposition:EntityDispositionInformations) : void {
         if(this._entities[actorId])
         {
            (this._entities[actorId] as GameContextActorInformations).disposition=newDisposition;
         }
         else
         {
            _log.warn("Cannot update unknown actor disposition ("+actorId+") in informations.");
         }
         var actor:IEntity = DofusEntities.getEntity(actorId);
         if(actor)
         {
            if((actor is IMovable)&&(newDisposition.cellId>=0))
            {
               if((actor is TiphonSprite)&&((actor as TiphonSprite).rootEntity)&&(!((actor as TiphonSprite).rootEntity==actor)))
               {
                  _log.debug("PAS DE SYNCHRO pour "+(actor as TiphonSprite).name+" car entité portée");
               }
               else
               {
                  IMovable(actor).jump(MapPoint.fromCellId(newDisposition.cellId));
               }
            }
            if(actor is IAnimated)
            {
               IAnimated(actor).setDirection(newDisposition.direction);
            }
         }
         else
         {
            _log.warn("Cannot update unknown actor disposition ("+actorId+") in the game world.");
         }
      }

      protected function updateActorOrientation(actorId:int, newOrientation:uint) : void {
         if(this._entities[actorId])
         {
            (this._entities[actorId] as GameContextActorInformations).disposition.direction=newOrientation;
         }
         else
         {
            _log.warn("Cannot update unknown actor orientation ("+actorId+") in informations.");
         }
         var ac:AnimatedCharacter = DofusEntities.getEntity(actorId) as AnimatedCharacter;
         if(ac)
         {
            if((actorId==PlayedCharacterManager.getInstance().id&&!(newOrientation==DirectionsEnum.DOWN))&&(ac.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND,0))&&(OptionManager.getOptionManager("tiphon").aura))
            {
               ac.look.removeSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND);
            }
            ac.setDirection(newOrientation);
         }
         else
         {
            _log.warn("Cannot update unknown actor orientation ("+actorId+") in the game world.");
         }
      }

      protected function hideActor(actorId:int) : void {
         var disp:IDisplayable = DofusEntities.getEntity(actorId) as IDisplayable;
         if(disp)
         {
            disp.remove();
         }
         else
         {
            _log.warn("Cannot remove an unknown actor ("+actorId+").");
         }
      }

      protected function removeActor(actorId:int) : void {
         this.hideActor(actorId);
         var tiphonSprite:TiphonSprite = DofusEntities.getEntity(actorId) as TiphonSprite;
         if(tiphonSprite)
         {
            tiphonSprite.destroy();
         }
         this.updateCreaturesLimit();
         if(this._humanNumber>0)
         {
            this._humanNumber--;
         }
         delete this._entities[[actorId]];
         if(this.switchPokemonMode())
         {
            _log.debug("switch pokemon/normal mode");
         }
      }

      protected function switchPokemonMode() : Boolean {
         var action:SwitchCreatureModeAction = null;
         if((this._creaturesLimit<-1)&&(!(this._creaturesMode==(!Kernel.getWorker().getFrame(FightEntitiesFrame)&&this._creaturesLimit>50&&this._humanNumber>=this._creaturesLimit))))
         {
            _log.debug("human number: "+this._humanNumber+", creature limit: "+this._creaturesLimit+" => "+this._creaturesMode);
            action=SwitchCreatureModeAction.create(!this._creaturesMode);
            Kernel.getWorker().process(action);
            return true;
         }
         return false;
      }

      protected function getLook(look:EntityLook, entityId:int=-1) : TiphonEntityLook {
         var lookWithoutMount:TiphonEntityLook = null;
         var breedId:uint = 0;
         var mountBonesIds:Array = null;
         var boneToCheck:* = 0;
         var oldLook:TiphonEntityLook = EntityLookAdapter.fromNetwork(look);
         var newLook:TiphonEntityLook = oldLook;
         if((this._creaturesMode)||(this._creaturesFightMode))
         {
            breedId=0;
            mountBonesIds=MountBone.getMountBonesIds();
            if(this.isBoneCorrect(oldLook.getBone()))
            {
               if((!(entityId==-1))&&(this._entities[entityId].hasOwnProperty("breed")))
               {
                  breedId=this._entities[entityId].breed;
               }
               else
               {
                  breedId=Breed.getBreedFromSkin(oldLook.firstSkin).id;
               }
            }
            else
            {
               if(mountBonesIds.indexOf(oldLook.getBone())!=-1)
               {
                  lookWithoutMount=TiphonUtility.getLookWithoutMount(oldLook);
                  if(lookWithoutMount!=oldLook)
                  {
                     if(this.isBoneCorrect(lookWithoutMount.getBone()))
                     {
                        if((!(entityId==-1))&&(this._entities[entityId].hasOwnProperty("breed")))
                        {
                           breedId=this._entities[entityId].breed;
                        }
                        else
                        {
                           breedId=Breed.getBreedFromSkin(lookWithoutMount.firstSkin).id;
                        }
                     }
                  }
               }
            }
            if(breedId==0)
            {
               if((!(entityId==-1))&&(this._entities[entityId].hasOwnProperty("breed")))
               {
                  breedId=this._entities[entityId].breed;
               }
               else
               {
                  boneToCheck=lookWithoutMount?lookWithoutMount.getBone():oldLook.getBone();
                  switch(boneToCheck)
                  {
                     case 453:
                        breedId=12;
                        break;
                     case 706:
                     case 1504:
                     case 1509:
                        return this.getFightPokemonLook(look,false,false,true,false);
                        break;
                     case 923:
                  }
                  return lookWithoutMount?lookWithoutMount:oldLook;
               }
            }
            newLook.setBone(Breed.getBreedById(breedId).creatureBonesId);
            newLook.setScales(0.9,0.9);
         }
         else
         {
            if(!OptionManager.getOptionManager("tiphon").aura)
            {
               newLook.removeSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND);
            }
         }
         return newLook;
      }

      private function isBoneCorrect(boneId:int) : Boolean {
         if((boneId==1)||(boneId==113)||(boneId==44)||(boneId==1575)||(boneId==1576))
         {
            return true;
         }
         return false;
      }

      protected function getFightPokemonLook(look:EntityLook, isMonstre:Boolean=false, isInvocation:Boolean=false, isIncarnation:Boolean=false, isBoss:Boolean=false) : TiphonEntityLook {
         var idBone:* = 0;
         var oldLook:TiphonEntityLook = EntityLookAdapter.fromNetwork(look);
         var newLook:TiphonEntityLook = oldLook;
         switch(isMonstre)
         {
            case true:
               if(isInvocation)
               {
                  idBone=1765;
               }
               else
               {
                  if(isBoss)
                  {
                     idBone=1748;
                  }
                  else
                  {
                     idBone=1747;
                  }
               }
               break;
            case false:
               if(isInvocation)
               {
                  idBone=1765;
               }
               else
               {
                  if(isIncarnation)
                  {
                     idBone=1749;
                  }
                  else
                  {
                     idBone=oldLook.getBone();
                  }
               }
               break;
         }
         newLook.setBone(idBone);
         newLook.setScales(0.9,0.9);
         return newLook;
      }

      private function getPercoPokemonLook(look:EntityLook) : TiphonEntityLook {
         var newLook:TiphonEntityLook = EntityLookAdapter.fromNetwork(look);
         newLook.setBone(1813);
         newLook.setScales(0.9,0.9);
         return newLook;
      }

      private function getDealerPokemonLook(look:EntityLook) : TiphonEntityLook {
         var newLook:TiphonEntityLook = EntityLookAdapter.fromNetwork(look);
         newLook.setBone(1965);
         newLook.setScales(0.9,0.9);
         return newLook;
      }

      protected function updateCreaturesLimit() : void {
         var vingtpourcent:* = NaN;
         this._creaturesLimit=OptionManager.getOptionManager("tiphon").creaturesMode;
         if((this._creaturesMode)&&(this._creaturesLimit<0))
         {
            vingtpourcent=this._creaturesLimit*20/100;
            this._creaturesLimit=Math.ceil(this._creaturesLimit-vingtpourcent);
         }
      }

      public function onPlayAnim(e:TiphonEvent) : void {
         var animsRandom:Array = new Array();
         var tempStr:String = e.params.substring(6,e.params.length-1);
         animsRandom=tempStr.split(",");
         e.sprite.setAnimation(animsRandom[int(animsRandom.length*Math.random())]);
      }

      private function onAtouinOptionChange(e:PropertyChangeEvent) : void {
         var entities:Array = null;
         var entitie:* = undefined;
         if(e.propertyName=="useLowDefSkin")
         {
            entities=EntitiesManager.getInstance().entities;
            for each (entitie in entities)
            {
               if(entitie is TiphonSprite)
               {
                  TiphonSprite(entitie).setAlternativeSkinIndex(e.propertyValue?0:-1,true);
               }
            }
         }
      }

      public function isInCreaturesFightMode() : Boolean {
         return this._creaturesFightMode;
      }

      private function onUpdateEntitySuccess(e:TiphonEvent) : void {
         e.sprite.removeEventListener(TiphonEvent.RENDER_FAILED,this.onUpdateEntityFail);
         e.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onUpdateEntitySuccess);
      }

      private function onUpdateEntityFail(e:TiphonEvent) : void {
         e.sprite.removeEventListener(TiphonEvent.RENDER_FAILED,this.onUpdateEntityFail);
         e.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onUpdateEntitySuccess);
         TiphonSprite(e.sprite).setAnimation("AnimStatique");
      }

      private function isIncarnation(entity:String) : Boolean {
         var incarnation:Incarnation = null;
         var boneIdMale:String = null;
         var boneIdFemale:String = null;
         var incarnations:Array = Incarnation.getAllIncarnation();
         var boneId:String = entity.slice(1,entity.indexOf("|"));
         for each (incarnation in incarnations)
         {
            boneIdMale=incarnation.lookMale.slice(1,incarnation.lookMale.indexOf("|"));
            boneIdFemale=incarnation.lookFemale.slice(1,incarnation.lookFemale.indexOf("|"));
            if((boneId==boneIdMale)||(boneId==boneIdFemale))
            {
               return true;
            }
         }
         return false;
      }
   }

}