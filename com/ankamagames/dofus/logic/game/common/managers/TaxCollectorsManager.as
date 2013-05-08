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
   import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorInFightWrapper;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorFightersWrapper;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.jerakine.utils.errors.SingletonError;


   public class TaxCollectorsManager extends Object implements IDestroyable
   {
         

      public function TaxCollectorsManager() {
         super();
         if(_self!=null)
         {
            throw new SingletonError("TaxCollectorsManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            this._taxCollectors=new Dictionary();
            this._taxCollectorsInFight=new Dictionary();
            return;
         }
      }

      private static var _self:TaxCollectorsManager;

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TaxCollectorsManager));

      public static function getInstance() : TaxCollectorsManager {
         if(_self==null)
         {
            _self=new TaxCollectorsManager();
         }
         return _self;
      }

      private var _taxCollectors:Dictionary;

      private var _taxCollectorsInFight:Dictionary;

      public var maxTaxCollectorsCount:int;

      public var taxCollectorsCount:int;

      public var taxCollectorHireCost:int;

      public var taxCollectorLifePoints:int;

      public var taxCollectorDamagesBonuses:int;

      public var taxCollectorPods:int;

      public var taxCollectorProspecting:int;

      public var taxCollectorWisdom:int;

      public function destroy() : void {
         this._taxCollectors=new Dictionary();
         this._taxCollectorsInFight=new Dictionary();
         _self=null;
      }

      public function get taxCollectors() : Dictionary {
         return this._taxCollectors;
      }

      public function get taxCollectorsFighters() : Dictionary {
         return this._taxCollectorsInFight;
      }

      public function setTaxCollectors(tcList:Vector.<TaxCollectorInformations>) : void {
         var tc:TaxCollectorInformations = null;
         for each (tc in tcList)
         {
            if(this._taxCollectors[tc.uniqueId])
            {
               this._taxCollectors[tc.uniqueId].update(tc);
            }
            else
            {
               this._taxCollectors[tc.uniqueId]=TaxCollectorWrapper.create(tc);
            }
         }
      }

      public function setTaxCollectorsFighters(tcList:Vector.<TaxCollectorFightersInformation>) : void {
         var tc:TaxCollectorFightersInformation = null;
         for each (tc in tcList)
         {
            if(this._taxCollectorsInFight[tc.collectorId])
            {
               this._taxCollectorsInFight[tc.collectorId].update(tc.collectorId,tc.allyCharactersInformations,tc.enemyCharactersInformations);
            }
            else
            {
               this._taxCollectorsInFight[tc.collectorId]=TaxCollectorInFightWrapper.create(tc.collectorId,tc.allyCharactersInformations,tc.enemyCharactersInformations);
            }
            this._taxCollectorsInFight[tc.collectorId].addPonyFighter(this._taxCollectors[tc.collectorId]);
         }
      }

      public function updateGuild(pMaxTaxCollectorsCount:int, pTaxCollectorsCount:int, pTaxCollectorLifePoints:int, pTaxCollectorDamagesBonuses:int, pTaxCollectorPods:int, pTaxCollectorProspecting:int, pTaxCollectorWisdom:int) : void {
         this.maxTaxCollectorsCount=pMaxTaxCollectorsCount;
         this.taxCollectorsCount=pTaxCollectorsCount;
         this.taxCollectorLifePoints=pTaxCollectorLifePoints;
         this.taxCollectorDamagesBonuses=pTaxCollectorDamagesBonuses;
         this.taxCollectorPods=pTaxCollectorPods;
         this.taxCollectorProspecting=pTaxCollectorProspecting;
         this.taxCollectorWisdom=pTaxCollectorWisdom;
      }

      public function addTaxCollector(taxCollector:TaxCollectorInformations) : Boolean {
         var newTC:Boolean = false;
         if(this._taxCollectors[taxCollector.uniqueId])
         {
            this._taxCollectors[taxCollector.uniqueId].update(taxCollector);
         }
         else
         {
            this._taxCollectors[taxCollector.uniqueId]=TaxCollectorWrapper.create(taxCollector);
            newTC=true;
         }
         if(taxCollector.state==0)
         {
            delete this._taxCollectorsInFight[[taxCollector.uniqueId]];
         }
         else
         {
            this._taxCollectorsInFight[taxCollector.uniqueId]=TaxCollectorInFightWrapper.create(taxCollector.uniqueId);
            if(taxCollector.state==1)
            {
               this._taxCollectorsInFight[taxCollector.uniqueId].addPonyFighter(this._taxCollectors[taxCollector.uniqueId]);
            }
         }
         return newTC;
      }

      public function addFighter(pFightId:int, pPlayerInfo:CharacterMinimalPlusLookInformations, ally:Boolean, pDispatchHook:Boolean=true) : void {
         var tc:TaxCollectorInFightWrapper = this._taxCollectorsInFight[pFightId];
         switch(ally)
         {
            case true:
               if(tc.allyCharactersInformations==null)
               {
                  tc.allyCharactersInformations=new Vector.<TaxCollectorFightersWrapper>();
               }
               tc.allyCharactersInformations.push(TaxCollectorFightersWrapper.create(0,pPlayerInfo));
               if(pDispatchHook)
               {
                  KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightAlliesListUpdate,pFightId);
               }
               break;
            case false:
               if(tc.enemyCharactersInformations==null)
               {
                  tc.enemyCharactersInformations=new Vector.<TaxCollectorFightersWrapper>();
               }
               tc.enemyCharactersInformations.push(TaxCollectorFightersWrapper.create(1,pPlayerInfo));
               if(pDispatchHook)
               {
                  KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightEnnemiesListUpdate,pFightId);
               }
               break;
         }
      }

      public function removeFighter(pFightId:int, pPlayerId:int, ally:Boolean, pDispatchHook:Boolean=true) : void {
         var allyFighter:TaxCollectorFightersWrapper = null;
         var enemyFighter:TaxCollectorFightersWrapper = null;
         var tc:TaxCollectorInFightWrapper = this._taxCollectorsInFight[pFightId];
         if(!tc)
         {
            _log.error("Error ! Fighter "+pPlayerId+" cannot be removed from unknown fight "+pFightId+".");
         }
         var count:uint = 0;
         switch(ally)
         {
            case true:
               for each (allyFighter in tc.allyCharactersInformations)
               {
                  if(allyFighter.playerCharactersInformations.id==pPlayerId)
                  {
                     break;
                  }
                  count++;
               }
               tc.allyCharactersInformations.splice(count,1);
               if(pDispatchHook)
               {
                  KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightAlliesListUpdate,pFightId);
               }
               break;
            case false:
               for each (enemyFighter in tc.enemyCharactersInformations)
               {
                  if(enemyFighter.playerCharactersInformations.id==pPlayerId)
                  {
                     tc.enemyCharactersInformations.splice(count,1);
                     if(pDispatchHook)
                     {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightEnnemiesListUpdate,pFightId);
                     }
                  }
                  count++;
               }
               break;
         }
      }
   }

}