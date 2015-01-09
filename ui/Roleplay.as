package 
{
    import flash.display.Sprite;
    import ui.NpcDialog;
    import ui.SpellForget;
    import ui.PrismDefense;
    import ui.SpectatorUi;
    import ui.LevelUpUi;
    import ui.KingOfTheHill;
    import ui.TreasureHunt;
    import ui.LegendaryHunts;
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.MapApi;
    import d2api.PlayedCharacterApi;
    import d2api.DataApi;
    import d2hooks.NpcDialogCreationFailure;
    import d2hooks.NpcDialogCreation;
    import d2hooks.PonyDialogCreation;
    import d2hooks.PrismDialogCreation;
    import d2hooks.PortalDialogCreation;
    import d2hooks.NpcDialogQuestion;
    import d2hooks.SpellForgetUI;
    import d2hooks.MapRunningFightList;
    import d2hooks.GameFightStarting;
    import d2hooks.CurrentMap;
    import d2hooks.MapComplementaryInformationsData;
    import d2hooks.CharacterLevelUp;
    import d2hooks.FightResultClosed;
    import d2hooks.GameFightJoin;
    import d2hooks.GameFightEnd;
    import d2hooks.SpectatorWantLeave;
    import d2hooks.KohState;
    import d2hooks.PvpAvaStateChange;
    import d2hooks.AllianceMembershipUpdated;
    import d2hooks.TreasureHuntUpdate;
    import d2hooks.TreasureHuntLegendaryUiUpdate;
    import d2actions.LeaveDialogRequest;
    import d2enums.PrismStateEnum;
    import d2data.PrismSubAreaWrapper;
    import d2enums.AggressableStatusEnum;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import d2data.WorldPointWrapper;
    import d2hooks.*;
    import d2actions.*;

    public class Roleplay extends Sprite 
    {

        public static var questions:Array;
        public static const LEVEL_UP_UI:String = "levelUp";
        private static var _compt:uint = 0;

        protected var npcDialog:NpcDialog;
        protected var spellForget:SpellForget;
        protected var prismDefense:PrismDefense;
        protected var spectatorUi:SpectatorUi;
        protected var levelUpUi:LevelUpUi;
        protected var kingOfTheHill:KingOfTheHill;
        protected var treasureHunt:TreasureHunt;
        protected var legendaryHunts:LegendaryHunts;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var mapApi:MapApi;
        public var playerApi:PlayedCharacterApi;
        public var dataApi:DataApi;
        private var _newLevel:uint;
        private var _spellPointEarned:uint;
        private var _caracPointEarned:uint;
        private var _healPointEarned:uint;
        private var _newSpell:Object;
        private var _spellObtained:Boolean;
        private var _levelSpellObtention:int;
        private var _avaEnable:Boolean;
        private var _probationTime:uint;
        private var _openUI:Boolean = false;
        private var _fightContext:Boolean = false;


        public function main():void
        {
            this.sysApi.addHook(NpcDialogCreationFailure, this.onNpcDialogCreationFailure);
            this.sysApi.addHook(NpcDialogCreation, this.onNpcDialogCreation);
            this.sysApi.addHook(PonyDialogCreation, this.onPonyDialogCreation);
            this.sysApi.addHook(PrismDialogCreation, this.onPrismDialogCreation);
            this.sysApi.addHook(PortalDialogCreation, this.onPortalDialogCreation);
            this.sysApi.addHook(NpcDialogQuestion, this.onNpcDialogQuestion);
            this.sysApi.addHook(SpellForgetUI, this.onSpellForgetUI);
            this.sysApi.addHook(MapRunningFightList, this.onMapRunningFightList);
            this.sysApi.addHook(GameFightStarting, this.onGameFightStarting);
            this.sysApi.addHook(CurrentMap, this.onMapChange);
            this.sysApi.addHook(MapComplementaryInformationsData, this.onMapLoaded);
            this.sysApi.addHook(CharacterLevelUp, this.onLevelUp);
            this.sysApi.addHook(FightResultClosed, this.onFightResultClosed);
            this.sysApi.addHook(GameFightJoin, this.onGameFightJoin);
            this.sysApi.addHook(GameFightEnd, this.onGameFightEnd);
            this.sysApi.addHook(SpectatorWantLeave, this.onSpectatorWantLeave);
            this.sysApi.addHook(KohState, this.onKohStateChange);
            this.sysApi.addHook(PvpAvaStateChange, this.onPvpAvaStateChange);
            this.sysApi.addHook(AllianceMembershipUpdated, this.onAllianceMembershipUpdated);
            this.sysApi.addHook(TreasureHuntUpdate, this.onTreasureHunt);
            this.sysApi.addHook(TreasureHuntLegendaryUiUpdate, this.onTreasureHuntLegendaryUiUpdate);
        }

        private function onNpcDialogCreationFailure():void
        {
            this.sysApi.log(16, "Impossible de parler à ce pnj :o");
        }

        private function onNpcDialogCreation(mapId:int, npcId:int, look:Object):void
        {
            questions = new Array();
            var map:uint = this.playerApi.currentMap().mapId;
            if (mapId == map)
            {
                if (this.uiApi.getUi("npcDialog"))
                {
                    this.uiApi.unloadUi("npcDialog");
                };
                this.uiApi.loadUi("npcDialog", "npcDialog", [npcId, look]);
            }
            else
            {
                this.sysApi.log(16, (((("Required npc (" + npcId) + ") cannot be found on map ") + map) + "."));
                this.sysApi.sendAction(new LeaveDialogRequest());
            };
        }

        private function onPonyDialogCreation(mapId:int, firstnameId:int, lastNameId:int, look:Object):void
        {
            questions = new Array();
            var map:uint = this.playerApi.currentMap().mapId;
            if (mapId == map)
            {
                this.uiApi.loadUi("npcDialog", "npcDialog", [1, look, firstnameId, lastNameId]);
            }
            else
            {
                this.sysApi.log(16, (("Required tax collector cannot be found on map " + map) + "."));
                this.sysApi.sendAction(new LeaveDialogRequest());
            };
        }

        private function onPrismDialogCreation(mapId:int, allianceName:String, look:Object):void
        {
            questions = new Array();
            var map:uint = this.playerApi.currentMap().mapId;
            if (mapId == map)
            {
                this.uiApi.loadUi("npcDialog", "npcDialog", [2141, look, allianceName]);
            }
            else
            {
                this.sysApi.log(16, (("Required prism cannot be found on map " + map) + "."));
                this.sysApi.sendAction(new LeaveDialogRequest());
            };
        }

        private function onPortalDialogCreation(mapId:int, areaName:String, look:Object):void
        {
            var portalNpcId:int;
            questions = new Array();
            var map:uint = this.playerApi.currentMap().mapId;
            if (look.getBone() == 2720)
            {
                portalNpcId = 2374;
            }
            else
            {
                if (look.getBone() == 2893)
                {
                    portalNpcId = 2594;
                }
                else
                {
                    if (look.getBone() == 3031)
                    {
                        portalNpcId = 2667;
                    };
                };
            };
            if (mapId == map)
            {
                this.uiApi.loadUi("npcDialog", "npcDialog", [portalNpcId, look, areaName]);
            }
            else
            {
                this.sysApi.log(16, (("Required portal cannot be found on map " + map) + "."));
                this.sysApi.sendAction(new LeaveDialogRequest());
            };
        }

        private function onSpellForgetUI(open:Boolean):void
        {
            if (open)
            {
                this.uiApi.loadUi("spellForget");
            }
            else
            {
                this.uiApi.unloadUi("spellForget");
            };
        }

        public function onNpcDialogQuestion(messageId:uint=0, dialogParams:Object=null, visibleReplies:Object=null):void
        {
        }

        private function onKohStateChange(prism:PrismSubAreaWrapper):void
        {
            if (!(prism))
            {
                this.uiApi.unloadUi("kingOfTheHill");
                return;
            };
            if (((((!(this._avaEnable)) || (!(prism.alliance)))) || (((KingOfTheHill.instance) && (!((KingOfTheHill.instance.currentSubArea == prism.subAreaId)))))))
            {
                this.uiApi.unloadUi("kingOfTheHill");
            };
            if (((((this._avaEnable) && ((prism.state == PrismStateEnum.PRISM_STATE_VULNERABLE)))) && (!(this.uiApi.getUi("kingOfTheHill")))))
            {
                this.uiApi.loadUi("kingOfTheHill", "kingOfTheHill", {
                    "prism":prism,
                    "probationTime":this._probationTime
                });
            };
        }

        private function onPvpAvaStateChange(status:uint, probationTime:uint):void
        {
            this._avaEnable = (((((((status == AggressableStatusEnum.AvA_DISQUALIFIED)) || ((status == AggressableStatusEnum.AvA_ENABLED_AGGRESSABLE)))) || ((status == AggressableStatusEnum.AvA_ENABLED_NON_AGGRESSABLE)))) || ((status == AggressableStatusEnum.AvA_PREQUALIFIED_AGGRESSABLE)));
            this._probationTime = probationTime;
            if (!(this._avaEnable))
            {
                this.uiApi.unloadUi("kingOfTheHill");
            };
        }

        private function onAllianceMembershipUpdated(hasAlliance:Boolean):void
        {
            if (((!(hasAlliance)) && (this._avaEnable)))
            {
                this.uiApi.unloadUi("kingOfTheHill");
                this._avaEnable = false;
            };
        }

        private function onTreasureHunt(treasureHuntType:uint):void
        {
            if (!(this.uiApi.getUi("treasureHunt")))
            {
                this.uiApi.loadUi("treasureHunt", "treasureHunt", treasureHuntType);
            };
        }

        private function onTreasureHuntLegendaryUiUpdate(huntsList:Object):void
        {
            if (!(this.uiApi.getUi("legendaryHunts")))
            {
                this.uiApi.loadUi("legendaryHunts", "legendaryHunts", huntsList);
            };
        }

        private function onMapRunningFightList(pFights:Object):void
        {
            if (!(this.uiApi.getUi(UIEnum.SPECTATOR_UI)))
            {
                this.uiApi.loadUi(UIEnum.SPECTATOR_UI, UIEnum.SPECTATOR_UI, pFights);
            };
        }

        private function onGameFightStarting(pFightType:uint):void
        {
            if (this.uiApi.getUi(UIEnum.SPECTATOR_UI))
            {
                this.uiApi.unloadUi(UIEnum.SPECTATOR_UI);
            };
        }

        private function onMapChange(pMapId:Object):void
        {
            if (this.uiApi.getUi(UIEnum.SPECTATOR_UI))
            {
                this.uiApi.unloadUi(UIEnum.SPECTATOR_UI);
            };
        }

        private function onMapLoaded(wp:WorldPointWrapper, subareaId:uint, foo:Boolean):void
        {
            if (((KingOfTheHill.instance) && (!((this.dataApi.getSubAreaFromMap(this.playerApi.currentMap().mapId).id == KingOfTheHill.instance.currentSubArea)))))
            {
                this.uiApi.unloadUi("kingOfTheHill");
            };
        }

        private function onLevelUp(pNewLevel:uint, pSpellPointEarned:uint, pCaracPointEarned:uint, pHealPointEarned:uint, pNewSpell:Object, pSpellObtained:Boolean, pLevelSpellObtention:int):void
        {
            this._openUI = true;
            this._newLevel = pNewLevel;
            this._spellPointEarned = pSpellPointEarned;
            this._caracPointEarned = pCaracPointEarned;
            this._healPointEarned = pHealPointEarned;
            this._newSpell = pNewSpell;
            this._spellObtained = pSpellObtained;
            this._levelSpellObtention = pLevelSpellObtention;
            if (!(this._fightContext))
            {
                this.uiApi.loadUi(LEVEL_UP_UI, LEVEL_UP_UI, {
                    "newLevel":pNewLevel,
                    "spellPointEarned":pSpellPointEarned,
                    "caracPointEarned":pCaracPointEarned,
                    "healPointEarned":pHealPointEarned,
                    "newSpell":pNewSpell,
                    "spellObtained":pSpellObtained,
                    "levelSpellObtention":pLevelSpellObtention
                }, 1, null, true);
                this._openUI = false;
            };
        }

        private function onFightResultClosed():void
        {
            if (this._openUI)
            {
                this.uiApi.loadUi(LEVEL_UP_UI, (LEVEL_UP_UI + ++_compt), {
                    "newLevel":this._newLevel,
                    "spellPointEarned":this._spellPointEarned,
                    "caracPointEarned":this._caracPointEarned,
                    "healPointEarned":this._healPointEarned,
                    "newSpell":this._newSpell,
                    "spellObtained":this._spellObtained,
                    "levelSpellObtention":this._levelSpellObtention
                });
                this._openUI = false;
            };
        }

        public function onGameFightJoin(canBeCancelled:Boolean, canSayReady:Boolean, isSpectator:Boolean, timeMaxBeforeFightStart:uint, fightType:int):void
        {
            this._fightContext = true;
            if (this.uiApi.getUi(UIEnum.TREASURE_HUNT))
            {
                this.uiApi.getUi(UIEnum.TREASURE_HUNT).visible = false;
            };
        }

        public function onGameFightEnd(params:Object):void
        {
            this._fightContext = false;
            if (this.uiApi.getUi(UIEnum.TREASURE_HUNT))
            {
                this.uiApi.getUi(UIEnum.TREASURE_HUNT).visible = true;
            };
        }

        public function onSpectatorWantLeave():void
        {
            this._fightContext = false;
            if (this.uiApi.getUi(UIEnum.TREASURE_HUNT))
            {
                this.uiApi.getUi(UIEnum.TREASURE_HUNT).visible = true;
            };
        }


    }
}//package 

