package com.ankamagames.dofus.logic.game.common.managers
{
    import com.ankamagames.jerakine.interfaces.IDestroyable;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformations;
    import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorFightersInformation;
    import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
    import com.ankamagames.dofus.internalDatacenter.guild.SocialEntityInFightWrapper;
    import com.ankamagames.dofus.network.enums.TaxCollectorStateEnum;
    import com.ankamagames.dofus.network.types.game.prism.PrismFightersInformation;
    import flash.utils.getTimer;
    import com.ankamagames.dofus.internalDatacenter.guild.SocialFightersWrapper;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.SocialHookList;
    import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
    import __AS3__.vec.*;

    public class TaxCollectorsManager implements IDestroyable 
    {

        private static const TYPE_TAX_COLLECTOR:int = 0;
        private static const TYPE_PRISM:int = 1;
        private static var _self:TaxCollectorsManager;
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TaxCollectorsManager));

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

        public function TaxCollectorsManager()
        {
            if (_self != null)
            {
                throw (new SingletonError("TaxCollectorsManager is a singleton and should not be instanciated directly."));
            };
            this._taxCollectors = new Dictionary();
            this._guildTaxCollectorsInFight = new Dictionary();
            this._allTaxCollectorsInPreFight = new Dictionary();
            this._prismsInFight = new Dictionary();
        }

        public static function getInstance():TaxCollectorsManager
        {
            if (_self == null)
            {
                _self = new (TaxCollectorsManager)();
            };
            return (_self);
        }


        public function destroy():void
        {
            this._taxCollectors = new Dictionary();
            this._guildTaxCollectorsInFight = new Dictionary();
            this._allTaxCollectorsInPreFight = new Dictionary();
            this._prismsInFight = new Dictionary();
            _self = null;
        }

        public function get taxCollectors():Dictionary
        {
            return (this._taxCollectors);
        }

        public function get guildTaxCollectorsFighters():Dictionary
        {
            return (this._guildTaxCollectorsInFight);
        }

        public function get allTaxCollectorsInPreFight():Dictionary
        {
            return (this._allTaxCollectorsInPreFight);
        }

        public function get prismsFighters():Dictionary
        {
            return (this._prismsInFight);
        }

        public function setTaxCollectors(tcList:Vector.<TaxCollectorInformations>):void
        {
            var tc:TaxCollectorInformations;
            this._taxCollectors = new Dictionary();
            for each (tc in tcList)
            {
                this._taxCollectors[tc.uniqueId] = TaxCollectorWrapper.create(tc);
            };
        }

        public function setTaxCollectorsFighters(tcList:Vector.<TaxCollectorFightersInformation>):void
        {
            var fightTime:int;
            var waitTime:Number;
            var char:Object;
            var tc:TaxCollectorFightersInformation;
            var tcWrapper:TaxCollectorWrapper;
            var allies:Array = new Array();
            var enemies:Array = new Array();
            var myGuildId:int = SocialFrame.getInstance().guild.guildId;
            this._guildTaxCollectorsInFight = new Dictionary();
            this._allTaxCollectorsInPreFight = new Dictionary();
            for each (tc in tcList)
            {
                tcWrapper = this._taxCollectors[tc.collectorId];
                if (!(tcWrapper))
                {
                    _log.error((("Tax collector " + tc.collectorId) + " doesn't exist IS PROBLEM"));
                }
                else
                {
                    fightTime = tcWrapper.fightTime;
                    waitTime = (tcWrapper.waitTimeForPlacement * 100);
                    allies = new Array();
                    enemies = new Array();
                    for each (char in tc.allyCharactersInformations)
                    {
                        allies.push(char);
                    };
                    for each (char in tc.enemyCharactersInformations)
                    {
                        enemies.push(char);
                    };
                    if (((!(tcWrapper.guild)) || ((tcWrapper.guild.guildId == myGuildId))))
                    {
                        if (this._guildTaxCollectorsInFight[tc.collectorId])
                        {
                            this._guildTaxCollectorsInFight[tc.collectorId].update(TYPE_TAX_COLLECTOR, tc.collectorId, allies, enemies, fightTime, waitTime, tcWrapper.nbPositionPerTeam);
                        }
                        else
                        {
                            this._guildTaxCollectorsInFight[tc.collectorId] = SocialEntityInFightWrapper.create(TYPE_TAX_COLLECTOR, tc.collectorId, allies, enemies, fightTime, waitTime, tcWrapper.nbPositionPerTeam);
                        };
                        this._guildTaxCollectorsInFight[tc.collectorId].addPonyFighter(tcWrapper);
                    };
                    if (tcWrapper.state != TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
                    {
                        if (this._allTaxCollectorsInPreFight[tc.collectorId])
                        {
                            delete this._allTaxCollectorsInPreFight[tc.collectorId];
                        };
                    }
                    else
                    {
                        if (this._allTaxCollectorsInPreFight[tc.collectorId])
                        {
                            this._allTaxCollectorsInPreFight[tc.collectorId].update(TYPE_TAX_COLLECTOR, tc.collectorId, allies, enemies, fightTime, waitTime, tcWrapper.nbPositionPerTeam);
                        }
                        else
                        {
                            this._allTaxCollectorsInPreFight[tc.collectorId] = SocialEntityInFightWrapper.create(TYPE_TAX_COLLECTOR, tc.collectorId, allies, enemies, fightTime, waitTime, tcWrapper.nbPositionPerTeam);
                        };
                        this._allTaxCollectorsInPreFight[tc.collectorId].addPonyFighter(tcWrapper);
                    };
                };
            };
        }

        public function setPrismsInFight(pList:Vector.<PrismFightersInformation>):void
        {
            var allies:Array;
            var enemies:Array;
            var char:Object;
            var fightTime:int;
            var pfi:PrismFightersInformation;
            this._prismsInFight = new Dictionary();
            for each (pfi in pList)
            {
                allies = new Array();
                enemies = new Array();
                for each (char in pfi.allyCharactersInformations)
                {
                    allies.push(char);
                };
                for each (char in pfi.enemyCharactersInformations)
                {
                    enemies.push(char);
                };
                fightTime = ((pfi.waitingForHelpInfo.timeLeftBeforeFight * 100) + getTimer());
                if (this._prismsInFight[pfi.subAreaId])
                {
                    this._prismsInFight[pfi.subAreaId].update(TYPE_PRISM, pfi.subAreaId, allies, enemies, fightTime, (pfi.waitingForHelpInfo.waitTimeForPlacement * 100), pfi.waitingForHelpInfo.nbPositionForDefensors);
                }
                else
                {
                    this._prismsInFight[pfi.subAreaId] = SocialEntityInFightWrapper.create(TYPE_PRISM, pfi.subAreaId, allies, enemies, fightTime, (pfi.waitingForHelpInfo.waitTimeForPlacement * 100), pfi.waitingForHelpInfo.nbPositionForDefensors);
                };
            };
        }

        public function updateGuild(pMaxTaxCollectorsCount:int, pTaxCollectorsCount:int, pTaxCollectorLifePoints:int, pTaxCollectorDamagesBonuses:int, pTaxCollectorPods:int, pTaxCollectorProspecting:int, pTaxCollectorWisdom:int):void
        {
            this.maxTaxCollectorsCount = pMaxTaxCollectorsCount;
            this.taxCollectorsCount = pTaxCollectorsCount;
            this.taxCollectorLifePoints = pTaxCollectorLifePoints;
            this.taxCollectorDamagesBonuses = pTaxCollectorDamagesBonuses;
            this.taxCollectorPods = pTaxCollectorPods;
            this.taxCollectorProspecting = pTaxCollectorProspecting;
            this.taxCollectorWisdom = pTaxCollectorWisdom;
        }

        public function addTaxCollector(taxCollector:TaxCollectorInformations):Boolean
        {
            var newTC:Boolean;
            if (this._taxCollectors[taxCollector.uniqueId])
            {
                this._taxCollectors[taxCollector.uniqueId].update(taxCollector);
            }
            else
            {
                this._taxCollectors[taxCollector.uniqueId] = TaxCollectorWrapper.create(taxCollector);
                newTC = true;
            };
            var belongsToMyGuild:Boolean = (((this._taxCollectors[taxCollector.uniqueId].guild == null)) || ((this._taxCollectors[taxCollector.uniqueId].guild.guildId == SocialFrame.getInstance().guild.guildId)));
            if (belongsToMyGuild)
            {
                if (taxCollector.state == TaxCollectorStateEnum.STATE_COLLECTING)
                {
                    delete this._guildTaxCollectorsInFight[taxCollector.uniqueId];
                }
                else
                {
                    this._guildTaxCollectorsInFight[taxCollector.uniqueId] = SocialEntityInFightWrapper.create(TYPE_TAX_COLLECTOR, taxCollector.uniqueId);
                    if (taxCollector.state == TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
                    {
                        this._guildTaxCollectorsInFight[taxCollector.uniqueId].addPonyFighter(this._taxCollectors[taxCollector.uniqueId]);
                    };
                };
            };
            if (taxCollector.state != TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
            {
                delete this._allTaxCollectorsInPreFight[taxCollector.uniqueId];
            }
            else
            {
                this._allTaxCollectorsInPreFight[taxCollector.uniqueId] = SocialEntityInFightWrapper.create(TYPE_TAX_COLLECTOR, taxCollector.uniqueId);
                this._allTaxCollectorsInPreFight[taxCollector.uniqueId].addPonyFighter(this._taxCollectors[taxCollector.uniqueId]);
            };
            return (newTC);
        }

        public function addPrism(prism:PrismFightersInformation):void
        {
            var char:Object;
            var fightTime:int;
            var allies:Array = new Array();
            var enemies:Array = new Array();
            for each (char in prism.allyCharactersInformations)
            {
                allies.push(char);
            };
            for each (char in prism.enemyCharactersInformations)
            {
                enemies.push(char);
            };
            fightTime = ((prism.waitingForHelpInfo.timeLeftBeforeFight * 100) + getTimer());
            this._prismsInFight[prism.subAreaId] = SocialEntityInFightWrapper.create(TYPE_PRISM, prism.subAreaId, allies, enemies, fightTime, (prism.waitingForHelpInfo.waitTimeForPlacement * 100), prism.waitingForHelpInfo.nbPositionForDefensors);
        }

        public function addFighter(pType:int, pFightId:int, pPlayerInfo:CharacterMinimalPlusLookInformations, ally:Boolean, pDispatchHook:Boolean=true):void
        {
            var entity:SocialEntityInFightWrapper;
            var entitiesToUpdate:Array = new Array();
            if (pType == TYPE_PRISM)
            {
                entitiesToUpdate.push(this._prismsInFight[pFightId]);
            }
            else
            {
                if (pType == TYPE_TAX_COLLECTOR)
                {
                    if (this._guildTaxCollectorsInFight[pFightId])
                    {
                        entitiesToUpdate.push(this._guildTaxCollectorsInFight[pFightId]);
                    };
                    if (this._allTaxCollectorsInPreFight[pFightId])
                    {
                        entitiesToUpdate.push(this._allTaxCollectorsInPreFight[pFightId]);
                    };
                };
            };
            for each (entity in entitiesToUpdate)
            {
                if (ally)
                {
                    if (entity.allyCharactersInformations == null)
                    {
                        entity.allyCharactersInformations = new Vector.<SocialFightersWrapper>();
                    };
                    entity.allyCharactersInformations.push(SocialFightersWrapper.create(0, pPlayerInfo));
                    if (pDispatchHook)
                    {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightAlliesListUpdate, pType, pFightId);
                    };
                }
                else
                {
                    if (entity.enemyCharactersInformations == null)
                    {
                        entity.enemyCharactersInformations = new Vector.<SocialFightersWrapper>();
                    };
                    entity.enemyCharactersInformations.push(SocialFightersWrapper.create(1, pPlayerInfo));
                    if (pDispatchHook)
                    {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightEnnemiesListUpdate, pType, pFightId);
                    };
                };
            };
            if (pDispatchHook)
            {
                if (ally)
                {
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightAlliesListUpdate, pType, pFightId);
                }
                else
                {
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightEnnemiesListUpdate, pType, pFightId);
                };
            };
        }

        public function removeFighter(pType:int, pFightId:int, pPlayerId:int, ally:Boolean, pDispatchHook:Boolean=true):void
        {
            var index:uint;
            var entity:SocialEntityInFightWrapper;
            var allyFighter:SocialFightersWrapper;
            var _local_10:SocialFightersWrapper;
            var entitiesToUpdate:Array = new Array();
            if (pType == TYPE_PRISM)
            {
                entitiesToUpdate.push(this._prismsInFight[pFightId]);
            }
            else
            {
                if (pType == TYPE_TAX_COLLECTOR)
                {
                    if (this._guildTaxCollectorsInFight[pFightId])
                    {
                        entitiesToUpdate.push(this._guildTaxCollectorsInFight[pFightId]);
                    };
                    if (this._allTaxCollectorsInPreFight[pFightId])
                    {
                        entitiesToUpdate.push(this._allTaxCollectorsInPreFight[pFightId]);
                    };
                };
            };
            if (entitiesToUpdate.length == 0)
            {
                _log.error((((("Error ! Fighter " + pPlayerId) + " cannot be removed from unknown fight ") + pFightId) + "."));
                return;
            };
            for each (entity in entitiesToUpdate)
            {
                index = 0;
                if (ally)
                {
                    for each (allyFighter in entity.allyCharactersInformations)
                    {
                        if (allyFighter.playerCharactersInformations.id == pPlayerId)
                        {
                            break;
                        };
                        index++;
                    };
                    entity.allyCharactersInformations.splice(index, 1);
                }
                else
                {
                    for each (_local_10 in entity.enemyCharactersInformations)
                    {
                        if (_local_10.playerCharactersInformations.id == pPlayerId)
                        {
                            break;
                        };
                        index++;
                    };
                    entity.enemyCharactersInformations.splice(index, 1);
                };
            };
            if (pDispatchHook)
            {
                if (ally)
                {
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightAlliesListUpdate, pType, pFightId);
                }
                else
                {
                    KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightEnnemiesListUpdate, pType, pFightId);
                };
            };
        }


    }
}//package com.ankamagames.dofus.logic.game.common.managers

