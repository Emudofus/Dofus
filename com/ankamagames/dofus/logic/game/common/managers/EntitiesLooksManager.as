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
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
   import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMutantInformations;
   
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
      
      public function set entitiesFrame(param1:AbstractEntitiesFrame) : void {
         this._entitiesFrame = param1;
      }
      
      public function isCreatureMode() : Boolean {
         return this._entitiesFrame is RoleplayEntitiesFrame?(this._entitiesFrame as RoleplayEntitiesFrame).isCreatureMode:(this._entitiesFrame as FightEntitiesFrame).isInCreaturesFightMode();
      }
      
      public function isCreature(param1:int) : Boolean {
         var _loc2_:TiphonEntityLook = this.getTiphonEntityLook(param1);
         if(_loc2_)
         {
            if((this.isCreatureFromLook(_loc2_)) || (this.isCreatureMode()) && this.getLookFromContext(param1).getBone() == _loc2_.getBone())
            {
               return true;
            }
         }
         return false;
      }
      
      public function isCreatureFromLook(param1:TiphonEntityLook) : Boolean {
         var _loc4_:Breed = null;
         var _loc2_:uint = param1.getBone();
         var _loc3_:Array = Breed.getBreeds();
         for each (_loc4_ in _loc3_)
         {
            if(_loc4_.creatureBonesId == _loc2_)
            {
               return true;
            }
         }
         if(param1.getBone() == CreatureBoneType.getPlayerIncarnationCreatureBone())
         {
            return true;
         }
         return false;
      }
      
      public function isIncarnation(param1:int) : Boolean {
         var _loc2_:TiphonEntityLook = this.getRealTiphonEntityLook(param1,true);
         if((_loc2_) && (this.isIncarnationFromLook(_loc2_)))
         {
            return true;
         }
         return false;
      }
      
      public function isIncarnationFromLook(param1:TiphonEntityLook) : Boolean {
         var _loc3_:Incarnation = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(param1.getBone() == CreatureBoneType.getPlayerIncarnationCreatureBone())
         {
            return true;
         }
         var _loc2_:Array = Incarnation.getAllIncarnation();
         var _loc4_:String = param1.toString();
         var _loc5_:String = _loc4_.slice(1,_loc4_.indexOf("|"));
         for each (_loc3_ in _loc2_)
         {
            _loc6_ = _loc3_.lookMale.slice(1,_loc3_.lookMale.indexOf("|"));
            _loc7_ = _loc3_.lookFemale.slice(1,_loc3_.lookFemale.indexOf("|"));
            if(_loc5_ == _loc6_ || _loc5_ == _loc7_)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getTiphonEntityLook(param1:int) : TiphonEntityLook {
         var _loc2_:AnimatedCharacter = DofusEntities.getEntity(param1) as AnimatedCharacter;
         return _loc2_?_loc2_.look.clone():null;
      }
      
      public function getRealTiphonEntityLook(param1:int, param2:Boolean=false) : TiphonEntityLook {
         var _loc3_:EntityLook = null;
         var _loc5_:GameContextActorInformations = null;
         var _loc6_:TiphonEntityLook = null;
         if(this._entitiesFrame)
         {
            if(this._entitiesFrame is FightEntitiesFrame)
            {
               _loc3_ = (this._entitiesFrame as FightEntitiesFrame).getRealFighterLook(param1);
            }
            else
            {
               _loc5_ = this._entitiesFrame.getEntityInfos(param1);
               _loc3_ = _loc5_?_loc5_.look:null;
            }
         }
         if(!_loc3_ && param1 == PlayedCharacterManager.getInstance().id)
         {
            _loc3_ = PlayedCharacterManager.getInstance().infos.entityLook;
         }
         var _loc4_:TiphonEntityLook = _loc3_?EntityLookAdapter.fromNetwork(_loc3_):null;
         if((_loc4_) && (param2))
         {
            _loc6_ = _loc4_.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
            if(_loc6_)
            {
               _loc4_ = _loc6_;
            }
         }
         return _loc4_;
      }
      
      public function getCreatureLook(param1:int) : TiphonEntityLook {
         var _loc2_:GameContextActorInformations = this._entitiesFrame?this._entitiesFrame.getEntityInfos(param1):null;
         return _loc2_?this.getLookFromContextInfos(_loc2_,true):null;
      }
      
      public function getLookFromContext(param1:int, param2:Boolean=false) : TiphonEntityLook {
         var _loc3_:GameContextActorInformations = this._entitiesFrame?this._entitiesFrame.getEntityInfos(param1):null;
         return _loc3_?this.getLookFromContextInfos(_loc3_,param2):null;
      }
      
      public function getLookFromContextInfos(param1:GameContextActorInformations, param2:Boolean=false) : TiphonEntityLook {
         var _loc4_:GameFightCompanionInformations = null;
         var _loc5_:Companion = null;
         var _loc6_:GameFightMonsterInformations = null;
         var _loc7_:* = false;
         var _loc8_:Monster = null;
         var _loc9_:* = 0;
         var _loc10_:TiphonEntityLook = null;
         var _loc11_:* = 0;
         var _loc12_:* = false;
         var _loc3_:TiphonEntityLook = EntityLookAdapter.fromNetwork(param1.look);
         if((this.isCreatureMode()) || (param2))
         {
            switch(true)
            {
               case param1 is GameRolePlayNpcInformations:
                  return _loc3_;
               case param1 is GameRolePlayHumanoidInformations:
               case param1 is GameFightCharacterInformations:
                  if(this.isIncarnation(param1.contextualId))
                  {
                     _loc3_.setBone(CreatureBoneType.getPlayerIncarnationCreatureBone());
                  }
                  else
                  {
                     _loc10_ = _loc3_.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0)?TiphonUtility.getLookWithoutMount(_loc3_):_loc3_;
                     _loc11_ = param1.hasOwnProperty("breed")?param1["breed"]:0;
                     _loc12_ = this.isBoneCorrect(_loc10_.getBone());
                     if(_loc11_ <= 0 && (_loc12_))
                     {
                        _loc11_ = Breed.getBreedFromSkin(_loc10_.firstSkin).id;
                     }
                     else
                     {
                        if(!_loc12_)
                        {
                           switch(_loc10_.getBone())
                           {
                              case 453:
                                 _loc11_ = 12;
                                 break;
                              case 706:
                              case 1504:
                              case 1509:
                                 _loc3_.setBone(CreatureBoneType.getPlayerIncarnationCreatureBone());
                                 break;
                           }
                        }
                     }
                     if(_loc11_ > 0)
                     {
                        _loc3_.setBone(Breed.getBreedById(_loc11_).creatureBonesId);
                     }
                     else
                     {
                        return _loc3_;
                     }
                  }
                  break;
               case param1 is GameRolePlayPrismInformations:
                  _loc3_.setBone(CreatureBoneType.getPrismCreatureBone());
                  break;
               case param1 is GameRolePlayMerchantInformations:
                  _loc3_.setBone(CreatureBoneType.getPlayerMerchantCreatureBone());
                  break;
               case param1 is GameRolePlayTaxCollectorInformations:
               case param1 is GameFightTaxCollectorInformations:
                  _loc3_.setBone(CreatureBoneType.getTaxCollectorCreatureBone());
                  break;
               case param1 is GameFightCompanionInformations:
                  _loc4_ = param1 as GameFightCompanionInformations;
                  _loc5_ = Companion.getCompanionById(_loc4_.companionGenericId);
                  _loc3_.setBone(_loc5_.creatureBoneId);
                  break;
               case param1 is GameFightMutantInformations:
                  _loc3_.setBone(CreatureBoneType.getMonsterCreatureBone());
                  break;
               case param1 is GameFightMonsterInformations:
                  _loc6_ = param1 as GameFightMonsterInformations;
                  _loc7_ = _loc6_.creatureGenericId == 3451;
                  _loc8_ = Monster.getMonsterById(_loc6_.creatureGenericId);
                  if(_loc6_.stats.summoned)
                  {
                     _loc9_ = CreatureBoneType.getMonsterInvocationCreatureBone();
                  }
                  else
                  {
                     if(_loc8_.isBoss)
                     {
                        _loc9_ = CreatureBoneType.getBossMonsterCreatureBone();
                     }
                     else
                     {
                        if(_loc7_)
                        {
                           _loc9_ = CreatureBoneType.getPrismCreatureBone();
                        }
                        else
                        {
                           _loc9_ = CreatureBoneType.getMonsterCreatureBone();
                        }
                     }
                  }
                  _loc3_.setBone(_loc9_);
                  break;
            }
            _loc3_.setScales(0.9,0.9);
         }
         return _loc3_;
      }
      
      private function isBoneCorrect(param1:int) : Boolean {
         if(param1 == 1 || param1 == 113 || param1 == 44 || param1 == 1575 || param1 == 1576)
         {
            return true;
         }
         return false;
      }
   }
}
