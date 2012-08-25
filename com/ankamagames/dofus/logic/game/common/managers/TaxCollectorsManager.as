package com.ankamagames.dofus.logic.game.common.managers
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.internalDatacenter.guild.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.types.game.character.*;
    import com.ankamagames.dofus.network.types.game.guild.tax.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.utils.*;

    public class TaxCollectorsManager extends Object implements IDestroyable
    {
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
        private static var _self:TaxCollectorsManager;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(TaxCollectorsManager));

        public function TaxCollectorsManager()
        {
            if (_self != null)
            {
                throw new SingletonError("TaxCollectorsManager is a singleton and should not be instanciated directly.");
            }
            this._taxCollectors = new Dictionary();
            this._taxCollectorsInFight = new Dictionary();
            return;
        }// end function

        public function destroy() : void
        {
            this._taxCollectors = new Dictionary();
            this._taxCollectorsInFight = new Dictionary();
            _self = null;
            return;
        }// end function

        public function get taxCollectors() : Dictionary
        {
            return this._taxCollectors;
        }// end function

        public function get taxCollectorsFighters() : Dictionary
        {
            return this._taxCollectorsInFight;
        }// end function

        public function setTaxCollectors(param1:Vector.<TaxCollectorInformations>) : void
        {
            var _loc_2:TaxCollectorInformations = null;
            for each (_loc_2 in param1)
            {
                
                if (this._taxCollectors[_loc_2.uniqueId])
                {
                    this._taxCollectors[_loc_2.uniqueId].update(_loc_2);
                    continue;
                }
                this._taxCollectors[_loc_2.uniqueId] = TaxCollectorWrapper.create(_loc_2);
            }
            return;
        }// end function

        public function setTaxCollectorsFighters(param1:Vector.<TaxCollectorFightersInformation>) : void
        {
            var _loc_2:TaxCollectorFightersInformation = null;
            for each (_loc_2 in param1)
            {
                
                if (this._taxCollectorsInFight[_loc_2.collectorId])
                {
                    this._taxCollectorsInFight[_loc_2.collectorId].update(_loc_2.collectorId, _loc_2.allyCharactersInformations, _loc_2.enemyCharactersInformations);
                }
                else
                {
                    this._taxCollectorsInFight[_loc_2.collectorId] = TaxCollectorInFightWrapper.create(_loc_2.collectorId, _loc_2.allyCharactersInformations, _loc_2.enemyCharactersInformations);
                }
                this._taxCollectorsInFight[_loc_2.collectorId].addPonyFighter(this._taxCollectors[_loc_2.collectorId]);
            }
            return;
        }// end function

        public function updateGuild(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : void
        {
            this.maxTaxCollectorsCount = param1;
            this.taxCollectorsCount = param2;
            this.taxCollectorLifePoints = param3;
            this.taxCollectorDamagesBonuses = param4;
            this.taxCollectorPods = param5;
            this.taxCollectorProspecting = param6;
            this.taxCollectorWisdom = param7;
            return;
        }// end function

        public function addTaxCollector(param1:TaxCollectorInformations) : Boolean
        {
            var _loc_2:Boolean = false;
            if (this._taxCollectors[param1.uniqueId])
            {
                this._taxCollectors[param1.uniqueId].update(param1);
            }
            else
            {
                this._taxCollectors[param1.uniqueId] = TaxCollectorWrapper.create(param1);
                _loc_2 = true;
            }
            if (param1.state == 0)
            {
                delete this._taxCollectorsInFight[param1.uniqueId];
            }
            else
            {
                this._taxCollectorsInFight[param1.uniqueId] = TaxCollectorInFightWrapper.create(param1.uniqueId);
                if (param1.state == 1)
                {
                    this._taxCollectorsInFight[param1.uniqueId].addPonyFighter(this._taxCollectors[param1.uniqueId]);
                }
            }
            return _loc_2;
        }// end function

        public function addFighter(param1:int, param2:CharacterMinimalPlusLookInformations, param3:Boolean, param4:Boolean = true) : void
        {
            var _loc_5:* = this._taxCollectorsInFight[param1];
            switch(param3)
            {
                case true:
                {
                    if (_loc_5.allyCharactersInformations == null)
                    {
                        _loc_5.allyCharactersInformations = new Vector.<TaxCollectorFightersWrapper>;
                    }
                    _loc_5.allyCharactersInformations.push(TaxCollectorFightersWrapper.create(0, param2));
                    if (param4)
                    {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightAlliesListUpdate, param1);
                    }
                    break;
                }
                case false:
                {
                    if (_loc_5.enemyCharactersInformations == null)
                    {
                        _loc_5.enemyCharactersInformations = new Vector.<TaxCollectorFightersWrapper>;
                    }
                    _loc_5.enemyCharactersInformations.push(TaxCollectorFightersWrapper.create(1, param2));
                    if (param4)
                    {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightEnnemiesListUpdate, param1);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function removeFighter(param1:int, param2:int, param3:Boolean, param4:Boolean = true) : void
        {
            var _loc_7:TaxCollectorFightersWrapper = null;
            var _loc_8:TaxCollectorFightersWrapper = null;
            var _loc_5:* = this._taxCollectorsInFight[param1];
            if (!this._taxCollectorsInFight[param1])
            {
                _log.error("Error ! Fighter " + param2 + " cannot be removed from unknown fight " + param1 + ".");
            }
            var _loc_6:uint = 0;
            switch(param3)
            {
                case true:
                {
                    for each (_loc_7 in _loc_5.allyCharactersInformations)
                    {
                        
                        if (_loc_7.playerCharactersInformations.id == param2)
                        {
                            break;
                        }
                        _loc_6 = _loc_6 + 1;
                    }
                    _loc_5.allyCharactersInformations.splice(_loc_6, 1);
                    if (param4)
                    {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightAlliesListUpdate, param1);
                    }
                    break;
                }
                case false:
                {
                    for each (_loc_8 in _loc_5.enemyCharactersInformations)
                    {
                        
                        if (_loc_8.playerCharactersInformations.id == param2)
                        {
                            _loc_5.enemyCharactersInformations.splice(_loc_6, 1);
                            if (param4)
                            {
                                KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightEnnemiesListUpdate, param1);
                            }
                        }
                        _loc_6 = _loc_6 + 1;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function getInstance() : TaxCollectorsManager
        {
            if (_self == null)
            {
                _self = new TaxCollectorsManager;
            }
            return _self;
        }// end function

    }
}
