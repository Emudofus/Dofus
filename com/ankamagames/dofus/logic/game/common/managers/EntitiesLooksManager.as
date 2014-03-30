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
   
   public class EntitiesLooksManager extends Object
   {
      
      public function EntitiesLooksManager() {
         super();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(EntitiesLooksManager));
      
      private static var _self:EntitiesLooksManager;
      
      public static function getInstance() : EntitiesLooksManager {
         if(!_self)
         {
            _self = new EntitiesLooksManager();
         }
         return _self;
      }
      
      private var _entitiesFrame:AbstractEntitiesFrame;
      
      public function set entitiesFrame(pFrame:AbstractEntitiesFrame) : void {
         this._entitiesFrame = pFrame;
      }
      
      public function isCreatureMode() : Boolean {
         return this._entitiesFrame is RoleplayEntitiesFrame?(this._entitiesFrame as RoleplayEntitiesFrame).isCreatureMode:(this._entitiesFrame as FightEntitiesFrame).isInCreaturesFightMode();
      }
      
      public function isCreature(pEntityId:int) : Boolean {
         var look:TiphonEntityLook = this.getTiphonEntityLook(pEntityId);
         if(look)
         {
            if((this.isCreatureFromLook(look)) || (this.isCreatureMode()) && (this.getLookFromContext(pEntityId).getBone() == look.getBone()))
            {
               return true;
            }
         }
         return false;
      }
      
      public function isCreatureFromLook(pLook:TiphonEntityLook) : Boolean {
         var breed:Breed = null;
         var bone:uint = pLook.getBone();
         var breeds:Array = Breed.getBreeds();
         for each (breed in breeds)
         {
            if(breed.creatureBonesId == bone)
            {
               return true;
            }
         }
         if(pLook.getBone() == CreatureBoneType.getPlayerIncarnationCreatureBone())
         {
            return true;
         }
         return false;
      }
      
      public function isIncarnation(pEntityId:int) : Boolean {
         var look:TiphonEntityLook = this.getRealTiphonEntityLook(pEntityId,true);
         if((look) && (this.isIncarnationFromLook(look)))
         {
            return true;
         }
         return false;
      }
      
      public function isIncarnationFromLook(pLook:TiphonEntityLook) : Boolean {
         var incarnation:Incarnation = null;
         var boneIdMale:String = null;
         var boneIdFemale:String = null;
         if(pLook.getBone() == CreatureBoneType.getPlayerIncarnationCreatureBone())
         {
            return true;
         }
         var incarnations:Array = Incarnation.getAllIncarnation();
         var entityLookStr:String = pLook.toString();
         var boneId:String = entityLookStr.slice(1,entityLookStr.indexOf("|"));
         for each (incarnation in incarnations)
         {
            boneIdMale = incarnation.lookMale.slice(1,incarnation.lookMale.indexOf("|"));
            boneIdFemale = incarnation.lookFemale.slice(1,incarnation.lookFemale.indexOf("|"));
            if((boneId == boneIdMale) || (boneId == boneIdFemale))
            {
               return true;
            }
         }
         return false;
      }
      
      public function getTiphonEntityLook(pEntityId:int) : TiphonEntityLook {
         var char:AnimatedCharacter = DofusEntities.getEntity(pEntityId) as AnimatedCharacter;
         return char?char.look.clone():null;
      }
      
      public function getRealTiphonEntityLook(pEntityId:int, pWithoutMount:Boolean=false) : TiphonEntityLook {
         var entityLook:EntityLook = null;
         var infos:GameContextActorInformations = null;
         var riderLook:TiphonEntityLook = null;
         if(this._entitiesFrame)
         {
            if(this._entitiesFrame is FightEntitiesFrame)
            {
               entityLook = (this._entitiesFrame as FightEntitiesFrame).getRealFighterLook(pEntityId);
            }
            else
            {
               infos = this._entitiesFrame.getEntityInfos(pEntityId);
               entityLook = infos?infos.look:null;
            }
         }
         if((!entityLook) && (pEntityId == PlayedCharacterManager.getInstance().id))
         {
            entityLook = PlayedCharacterManager.getInstance().infos.entityLook;
         }
         var look:TiphonEntityLook = entityLook?EntityLookAdapter.fromNetwork(entityLook):null;
         if((look) && (pWithoutMount))
         {
            riderLook = look.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
            if(riderLook)
            {
               look = riderLook;
            }
         }
         return look;
      }
      
      public function getCreatureLook(pEntityId:int) : TiphonEntityLook {
         var infos:GameContextActorInformations = this._entitiesFrame?this._entitiesFrame.getEntityInfos(pEntityId):null;
         return infos?this.getLookFromContextInfos(infos,true):null;
      }
      
      public function getLookFromContext(pEntityId:int, pForceCreature:Boolean=false) : TiphonEntityLook {
         var infos:GameContextActorInformations = this._entitiesFrame?this._entitiesFrame.getEntityInfos(pEntityId):null;
         return infos?this.getLookFromContextInfos(infos,pForceCreature):null;
      }
      
      public function getLookFromContextInfos(pInfos:GameContextActorInformations, pForceCreature:Boolean=false) : TiphonEntityLook {
         var gfci:GameFightCompanionInformations = null;
         var companion:Companion = null;
         var gfmi:GameFightMonsterInformations = null;
         var isPrism:* = false;
         var m:Monster = null;
         var fightCreatureBone:* = 0;
         var charLook:TiphonEntityLook = null;
         var breedId:* = 0;
         var boneCorrect:* = false;
         var look:TiphonEntityLook = EntityLookAdapter.fromNetwork(pInfos.look);
         if((this.isCreatureMode()) || (pForceCreature))
         {
            switch(true)
            {
               case pInfos is GameRolePlayHumanoidInformations:
               case pInfos is GameFightCharacterInformations:
                  if(this.isIncarnation(pInfos.contextualId))
                  {
                     look.setBone(CreatureBoneType.getPlayerIncarnationCreatureBone());
                  }
                  else
                  {
                     charLook = look.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0)?TiphonUtility.getLookWithoutMount(look):look;
                     breedId = pInfos.hasOwnProperty("breed")?pInfos["breed"]:0;
                     boneCorrect = this.isBoneCorrect(charLook.getBone());
                     if((breedId <= 0) && (boneCorrect))
                     {
                        breedId = Breed.getBreedFromSkin(charLook.firstSkin).id;
                     }
                     else
                     {
                        if(!boneCorrect)
                        {
                           switch(charLook.getBone())
                           {
                              case 453:
                                 breedId = 12;
                                 break;
                              case 706:
                              case 1504:
                              case 1509:
                                 look.setBone(CreatureBoneType.getPlayerIncarnationCreatureBone());
                                 break;
                           }
                        }
                     }
                     if(breedId > 0)
                     {
                        look.setBone(Breed.getBreedById(breedId).creatureBonesId);
                     }
                     else
                     {
                        return look;
                     }
                  }
                  break;
               case pInfos is GameRolePlayPrismInformations:
                  look.setBone(CreatureBoneType.getPrismCreatureBone());
                  break;
               case pInfos is GameRolePlayMerchantInformations:
                  look.setBone(CreatureBoneType.getPlayerMerchantCreatureBone());
                  break;
               case pInfos is GameRolePlayTaxCollectorInformations:
               case pInfos is GameFightTaxCollectorInformations:
                  look.setBone(CreatureBoneType.getTaxCollectorCreatureBone());
                  break;
               case pInfos is GameFightCompanionInformations:
                  gfci = pInfos as GameFightCompanionInformations;
                  companion = Companion.getCompanionById(gfci.companionGenericId);
                  look.setBone(companion.creatureBoneId);
                  break;
               case pInfos is GameFightMutantInformations:
                  look.setBone(CreatureBoneType.getMonsterCreatureBone());
                  break;
               case pInfos is GameFightMonsterInformations:
                  gfmi = pInfos as GameFightMonsterInformations;
                  isPrism = gfmi.creatureGenericId == 3451;
                  m = Monster.getMonsterById(gfmi.creatureGenericId);
                  if(gfmi.stats.summoned)
                  {
                     fightCreatureBone = CreatureBoneType.getMonsterInvocationCreatureBone();
                  }
                  else
                  {
                     if(m.isBoss)
                     {
                        fightCreatureBone = CreatureBoneType.getBossMonsterCreatureBone();
                     }
                     else
                     {
                        if(isPrism)
                        {
                           fightCreatureBone = CreatureBoneType.getPrismCreatureBone();
                        }
                        else
                        {
                           fightCreatureBone = CreatureBoneType.getMonsterCreatureBone();
                        }
                     }
                  }
                  look.setBone(fightCreatureBone);
                  break;
               case pInfos is GameRolePlayActorInformations:
                  return look;
            }
            look.setScales(0.9,0.9);
         }
         return look;
      }
      
      private function isBoneCorrect(boneId:int) : Boolean {
         if((boneId == 1) || (boneId == 113) || (boneId == 44) || (boneId == 1575) || (boneId == 1576))
         {
            return true;
         }
         return false;
      }
   }
}
