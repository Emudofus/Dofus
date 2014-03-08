package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformations;
   import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorFightersInformation;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.internalDatacenter.guild.SocialEntityInFightWrapper;
   import com.ankamagames.dofus.network.enums.TaxCollectorStateEnum;
   import com.ankamagames.dofus.network.types.game.prism.PrismFightersInformation;
   import flash.utils.getTimer;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.dofus.internalDatacenter.guild.SocialFightersWrapper;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class TaxCollectorsManager extends Object implements IDestroyable
   {
      
      public function TaxCollectorsManager() {
         super();
         if(_self != null)
         {
            throw new SingletonError("TaxCollectorsManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            this._taxCollectors = new Dictionary();
            this._guildTaxCollectorsInFight = new Dictionary();
            this._allTaxCollectorsInPreFight = new Dictionary();
            this._prismsInFight = new Dictionary();
            return;
         }
      }
      
      private static const TYPE_TAX_COLLECTOR:int = 0;
      
      private static const TYPE_PRISM:int = 1;
      
      private static var _self:TaxCollectorsManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TaxCollectorsManager));
      
      public static function getInstance() : TaxCollectorsManager {
         if(_self == null)
         {
            _self = new TaxCollectorsManager();
         }
         return _self;
      }
      
      private var _taxCollectors:Dictionary;
      
      private var _guildTaxCollectorsInFight:Dictionary;
      
      private var _allTaxCollectorsInPreFight:Dictionary;
      
      private var _prismsInFight:Dictionary;
      
      public var maxTaxCollectorsCount:int;
      
      public var taxCollectorsCount:int;
      
      public var taxCollectorLifePoints:int;
      
      public var taxCollectorDamagesBonuses:int;
      
      public var taxCollectorPods:int;
      
      public var taxCollectorProspecting:int;
      
      public var taxCollectorWisdom:int;
      
      public function destroy() : void {
         this._taxCollectors = new Dictionary();
         this._guildTaxCollectorsInFight = new Dictionary();
         this._allTaxCollectorsInPreFight = new Dictionary();
         this._prismsInFight = new Dictionary();
         _self = null;
      }
      
      public function get taxCollectors() : Dictionary {
         return this._taxCollectors;
      }
      
      public function get guildTaxCollectorsFighters() : Dictionary {
         return this._guildTaxCollectorsInFight;
      }
      
      public function get allTaxCollectorsInPreFight() : Dictionary {
         return this._allTaxCollectorsInPreFight;
      }
      
      public function get prismsFighters() : Dictionary {
         return this._prismsInFight;
      }
      
      public function setTaxCollectors(param1:Vector.<TaxCollectorInformations>) : void {
         var _loc2_:TaxCollectorInformations = null;
         this._taxCollectors = new Dictionary();
         for each (_loc2_ in param1)
         {
            this._taxCollectors[_loc2_.uniqueId] = TaxCollectorWrapper.create(_loc2_);
         }
      }
      
      public function setTaxCollectorsFighters(param1:Vector.<TaxCollectorFightersInformation>) : void {
         var _loc2_:* = 0;
         var _loc3_:* = NaN;
         var _loc6_:Object = null;
         var _loc8_:TaxCollectorFightersInformation = null;
         var _loc9_:TaxCollectorWrapper = null;
         var _loc4_:Array = new Array();
         var _loc5_:Array = new Array();
         var _loc7_:int = SocialFrame.getInstance().guild.guildId;
         this._guildTaxCollectorsInFight = new Dictionary();
         this._allTaxCollectorsInPreFight = new Dictionary();
         for each (_loc8_ in param1)
         {
            _loc9_ = this._taxCollectors[_loc8_.collectorId];
            if(!_loc9_)
            {
               _log.error("Tax collector " + _loc8_.collectorId + " doesn\'t exist IS PROBLEM");
            }
            else
            {
               _loc2_ = _loc9_.fightTime;
               _loc3_ = _loc9_.waitTimeForPlacement * 100;
               _loc4_ = new Array();
               _loc5_ = new Array();
               for each (_loc6_ in _loc8_.allyCharactersInformations)
               {
                  _loc4_.push(_loc6_);
               }
               for each (_loc6_ in _loc8_.enemyCharactersInformations)
               {
                  _loc5_.push(_loc6_);
               }
               if(!_loc9_.guild || _loc9_.guild.guildId == _loc7_)
               {
                  if(this._guildTaxCollectorsInFight[_loc8_.collectorId])
                  {
                     this._guildTaxCollectorsInFight[_loc8_.collectorId].update(TYPE_TAX_COLLECTOR,_loc8_.collectorId,_loc4_,_loc5_,_loc2_,_loc3_,_loc9_.nbPositionPerTeam);
                  }
                  else
                  {
                     this._guildTaxCollectorsInFight[_loc8_.collectorId] = SocialEntityInFightWrapper.create(TYPE_TAX_COLLECTOR,_loc8_.collectorId,_loc4_,_loc5_,_loc2_,_loc3_,_loc9_.nbPositionPerTeam);
                  }
                  this._guildTaxCollectorsInFight[_loc8_.collectorId].addPonyFighter(_loc9_);
               }
               if(_loc9_.state != TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
               {
                  if(this._allTaxCollectorsInPreFight[_loc8_.collectorId])
                  {
                     delete this._allTaxCollectorsInPreFight[[_loc8_.collectorId]];
                  }
               }
               else
               {
                  if(this._allTaxCollectorsInPreFight[_loc8_.collectorId])
                  {
                     this._allTaxCollectorsInPreFight[_loc8_.collectorId].update(TYPE_TAX_COLLECTOR,_loc8_.collectorId,_loc4_,_loc5_,_loc2_,_loc3_,_loc9_.nbPositionPerTeam);
                  }
                  else
                  {
                     this._allTaxCollectorsInPreFight[_loc8_.collectorId] = SocialEntityInFightWrapper.create(TYPE_TAX_COLLECTOR,_loc8_.collectorId,_loc4_,_loc5_,_loc2_,_loc3_,_loc9_.nbPositionPerTeam);
                  }
                  this._allTaxCollectorsInPreFight[_loc8_.collectorId].addPonyFighter(_loc9_);
               }
            }
         }
      }
      
      public function setPrismsInFight(param1:Vector.<PrismFightersInformation>) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function updateGuild(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : void {
         this.maxTaxCollectorsCount = param1;
         this.taxCollectorsCount = param2;
         this.taxCollectorLifePoints = param3;
         this.taxCollectorDamagesBonuses = param4;
         this.taxCollectorPods = param5;
         this.taxCollectorProspecting = param6;
         this.taxCollectorWisdom = param7;
      }
      
      public function addTaxCollector(param1:TaxCollectorInformations) : Boolean {
         var _loc2_:* = false;
         if(this._taxCollectors[param1.uniqueId])
         {
            this._taxCollectors[param1.uniqueId].update(param1);
         }
         else
         {
            this._taxCollectors[param1.uniqueId] = TaxCollectorWrapper.create(param1);
            _loc2_ = true;
         }
         var _loc3_:Boolean = this._taxCollectors[param1.uniqueId].guild == null || this._taxCollectors[param1.uniqueId].guild.guildId == SocialFrame.getInstance().guild.guildId;
         if(_loc3_)
         {
            if(param1.state == TaxCollectorStateEnum.STATE_COLLECTING)
            {
               delete this._guildTaxCollectorsInFight[[param1.uniqueId]];
            }
            else
            {
               this._guildTaxCollectorsInFight[param1.uniqueId] = SocialEntityInFightWrapper.create(TYPE_TAX_COLLECTOR,param1.uniqueId);
               if(param1.state == TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
               {
                  this._guildTaxCollectorsInFight[param1.uniqueId].addPonyFighter(this._taxCollectors[param1.uniqueId]);
               }
            }
         }
         if(param1.state != TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
         {
            delete this._allTaxCollectorsInPreFight[[param1.uniqueId]];
         }
         else
         {
            this._allTaxCollectorsInPreFight[param1.uniqueId] = SocialEntityInFightWrapper.create(TYPE_TAX_COLLECTOR,param1.uniqueId);
            this._allTaxCollectorsInPreFight[param1.uniqueId].addPonyFighter(this._taxCollectors[param1.uniqueId]);
         }
         return _loc2_;
      }
      
      public function addPrism(param1:PrismFightersInformation) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function addFighter(param1:int, param2:int, param3:CharacterMinimalPlusLookInformations, param4:Boolean, param5:Boolean=true) : void {
         var _loc7_:SocialEntityInFightWrapper = null;
         var _loc6_:Array = new Array();
         if(param1 == TYPE_PRISM)
         {
            _loc6_.push(this._prismsInFight[param2]);
         }
         else
         {
            if(param1 == TYPE_TAX_COLLECTOR)
            {
               if(this._guildTaxCollectorsInFight[param2])
               {
                  _loc6_.push(this._guildTaxCollectorsInFight[param2]);
               }
               if(this._allTaxCollectorsInPreFight[param2])
               {
                  _loc6_.push(this._allTaxCollectorsInPreFight[param2]);
               }
            }
         }
         for each (_loc7_ in _loc6_)
         {
            if(param4)
            {
               if(_loc7_.allyCharactersInformations == null)
               {
                  _loc7_.allyCharactersInformations = new Vector.<SocialFightersWrapper>();
               }
               _loc7_.allyCharactersInformations.push(SocialFightersWrapper.create(0,param3));
               if(param5)
               {
                  KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightAlliesListUpdate,param1,param2);
               }
            }
            else
            {
               if(_loc7_.enemyCharactersInformations == null)
               {
                  _loc7_.enemyCharactersInformations = new Vector.<SocialFightersWrapper>();
               }
               _loc7_.enemyCharactersInformations.push(SocialFightersWrapper.create(1,param3));
               if(param5)
               {
                  KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightEnnemiesListUpdate,param1,param2);
               }
            }
         }
         if(param5)
         {
            if(param4)
            {
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightAlliesListUpdate,param1,param2);
            }
            else
            {
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightEnnemiesListUpdate,param1,param2);
            }
         }
      }
      
      public function removeFighter(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean=true) : void {
         var _loc7_:uint = 0;
         var _loc8_:SocialEntityInFightWrapper = null;
         var _loc9_:SocialFightersWrapper = null;
         var _loc10_:SocialFightersWrapper = null;
         var _loc6_:Array = new Array();
         if(param1 == TYPE_PRISM)
         {
            _loc6_.push(this._prismsInFight[param2]);
         }
         else
         {
            if(param1 == TYPE_TAX_COLLECTOR)
            {
               if(this._guildTaxCollectorsInFight[param2])
               {
                  _loc6_.push(this._guildTaxCollectorsInFight[param2]);
               }
               if(this._allTaxCollectorsInPreFight[param2])
               {
                  _loc6_.push(this._allTaxCollectorsInPreFight[param2]);
               }
            }
         }
         if(_loc6_.length == 0)
         {
            _log.error("Error ! Fighter " + param3 + " cannot be removed from unknown fight " + param2 + ".");
            return;
         }
         for each (_loc8_ in _loc6_)
         {
            _loc7_ = 0;
            if(param4)
            {
               for each (_loc9_ in _loc8_.allyCharactersInformations)
               {
                  if(_loc9_.playerCharactersInformations.id == param3)
                  {
                     break;
                  }
                  _loc7_++;
               }
               _loc8_.allyCharactersInformations.splice(_loc7_,1);
            }
            else
            {
               for each (_loc10_ in _loc8_.enemyCharactersInformations)
               {
                  if(_loc10_.playerCharactersInformations.id == param3)
                  {
                     break;
                  }
                  _loc7_++;
               }
               _loc8_.enemyCharactersInformations.splice(_loc7_,1);
            }
         }
         if(param5)
         {
            if(param4)
            {
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightAlliesListUpdate,param1,param2);
            }
            else
            {
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightEnnemiesListUpdate,param1,param2);
            }
         }
      }
   }
}
