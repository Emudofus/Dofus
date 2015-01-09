package ui
{
    import d2enums.PvpArenaTypeEnum;
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.PartyApi;
    import d2api.PlayedCharacterApi;
    import d2api.SoundApi;
    import flash.utils.Dictionary;
    import d2components.Label;
    import d2components.Grid;
    import d2components.ButtonContainer;
    import d2enums.SoundTypeEnum;
    import d2enums.UISoundEnum;
    import d2hooks.ArenaRegistrationStatusUpdate;
    import d2hooks.ArenaFighterStatusUpdate;
    import d2hooks.ArenaFightProposition;
    import d2hooks.ArenaUpdateRank;
    import d2hooks.PartyJoin;
    import d2hooks.PartyUpdate;
    import d2hooks.PartyLeave;
    import d2hooks.PartyLeaderUpdate;
    import d2hooks.PartyMemberUpdate;
    import d2hooks.PartyMemberRemove;
    import d2actions.ArenaRegister;
    import d2actions.ArenaUnregister;
    import d2actions.PartyLeaveRequest;
    import d2enums.PvpArenaStepEnum;
    import d2hooks.*;
    import d2actions.*;

    public class PvpArena 
    {

        public static const TEAM_MEMBERS_MAX:int = PvpArenaTypeEnum.ARENA_TYPE_3VS3;//3

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var partyApi:PartyApi;
        public var playerApi:PlayedCharacterApi;
        public var soundApi:SoundApi;
        private var _isRegistered:Boolean;
        private var _currentStatus:int;
        private var _nbFightersReady:int = 0;
        private var _myTeam:Array;
        private var _statusList:Dictionary;
        public var lbl_step:Label;
        public var lbl_whatToDo:Label;
        public var lbl_rank:Label;
        public var lbl_rankDay:Label;
        public var lbl_rankMax:Label;
        public var lbl_fights:Label;
        public var gd_myTeam:Grid;
        public var btn_lbl_btn_validate:Label;
        public var btn_validate:ButtonContainer;
        public var btn_quitArena:ButtonContainer;
        public var btn_close:ButtonContainer;

        public function PvpArena()
        {
            this._statusList = new Dictionary(true);
            super();
        }

        public function main(list:Array):void
        {
            var readyMember:int;
            this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
            this.btn_validate.soundId = UISoundEnum.OK_BUTTON;
            this.btn_quitArena.soundId = UISoundEnum.OK_BUTTON;
            this.btn_close.soundId = UISoundEnum.CANCEL_BUTTON;
            this.sysApi.addHook(ArenaRegistrationStatusUpdate, this.onArenaRegistrationStatusUpdate);
            this.sysApi.addHook(ArenaFighterStatusUpdate, this.onArenaFighterStatusUpdate);
            this.sysApi.addHook(ArenaFightProposition, this.onArenaFightProposition);
            this.sysApi.addHook(ArenaUpdateRank, this.onArenaUpdateRank);
            this.sysApi.addHook(PartyJoin, this.onPartyJoin);
            this.sysApi.addHook(PartyUpdate, this.onPartyUpdate);
            this.sysApi.addHook(PartyLeave, this.onPartyLeave);
            this.sysApi.addHook(PartyLeaderUpdate, this.onPartyLeaderUpdate);
            this.sysApi.addHook(PartyMemberUpdate, this.onPartyMemberUpdate);
            this.sysApi.addHook(PartyMemberRemove, this.onPartyMemberRemove);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addShortcutHook("validUi", this.onShortcut);
            this.uiApi.addComponentHook(this.lbl_fights, "onRollOver");
            this.uiApi.addComponentHook(this.lbl_fights, "onRollOut");
            this.uiApi.addComponentHook(this.lbl_rank, "onRollOver");
            this.uiApi.addComponentHook(this.lbl_rank, "onRollOut");
            this.uiApi.addComponentHook(this.lbl_rankDay, "onRollOver");
            this.uiApi.addComponentHook(this.lbl_rankDay, "onRollOut");
            this.uiApi.addComponentHook(this.lbl_rankMax, "onRollOver");
            this.uiApi.addComponentHook(this.lbl_rankMax, "onRollOut");
            this.uiApi.addComponentHook(this.btn_validate, "onRollOver");
            this.uiApi.addComponentHook(this.btn_validate, "onRollOut");
            this.uiApi.addComponentHook(this.btn_quitArena, "onRollOver");
            this.uiApi.addComponentHook(this.btn_quitArena, "onRollOut");
            this._isRegistered = this.partyApi.isArenaRegistered();
            this._currentStatus = this.partyApi.getArenaCurrentStatus();
            this.onArenaRegistrationStatusUpdate(this._isRegistered, this._currentStatus);
            this.updateFighters();
            if (((this.partyApi.getArenaLeader()) && (!((this.playerApi.id() == this.partyApi.getArenaLeader().id)))))
            {
                this.btn_validate.softDisabled = true;
            };
            if (this.partyApi.getArenaPartyId() == 0)
            {
                this.btn_quitArena.softDisabled = true;
            };
            var ranks:Object = this.partyApi.getArenaRanks();
            this.lbl_rank.text = this.uiApi.getText("ui.party.arenaRank", ranks[0]);
            this.lbl_rankDay.text = this.uiApi.getText("ui.party.arenaRankMaxToday", ranks[1]);
            this.lbl_rankMax.text = this.uiApi.getText("ui.party.arenaRankMax", ranks[2]);
            this.lbl_fights.text = this.uiApi.getText("ui.party.arenaFightsOfTheDay", this.partyApi.getTodaysWonArenaFights(), this.partyApi.getTodaysArenaFights());
            for each (readyMember in this.partyApi.getArenaReadyPartyMemberIds())
            {
                this.onArenaFighterStatusUpdate(readyMember, true);
            };
        }

        public function unload():void
        {
            this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
        }

        public function updateFighterLine(data:*, componentsRef:*, selected:Boolean):void
        {
            var playerLink:String;
            if (!(this._statusList[componentsRef.tx_fighterState.name]))
            {
                this.uiApi.addComponentHook(componentsRef.tx_fighterState, "onRollOut");
                this.uiApi.addComponentHook(componentsRef.tx_fighterState, "onRollOver");
            };
            this._statusList[componentsRef.tx_fighterState.name] = data;
            if (data)
            {
                if (data.name != "")
                {
                    playerLink = (((((("{player," + data.name) + ",") + data.realId) + "::") + data.name) + "}");
                    componentsRef.lbl_fighterName.text = playerLink;
                    if (data.chief)
                    {
                        componentsRef.tx_leader.visible = true;
                    }
                    else
                    {
                        componentsRef.tx_leader.visible = false;
                    };
                }
                else
                {
                    componentsRef.lbl_fighterName.text = this.uiApi.getText("ui.common.randomCharacter");
                    componentsRef.tx_leader.visible = false;
                };
                componentsRef.tx_fighterState.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("assets") + "state_") + data.status));
            }
            else
            {
                componentsRef.lbl_fighterName.text = "";
                componentsRef.tx_fighterState.uri = null;
                componentsRef.tx_leader.visible = false;
            };
        }

        private function updateFighters():void
        {
            this._myTeam = new Array();
            var partyMembers:Object = this.partyApi.getPartyMembers(1);
            var alliesIds:Object = this.partyApi.getArenaAlliesIds();
            if (((partyMembers) && ((partyMembers.length > 0))))
            {
                this.btn_quitArena.softDisabled = false;
                if (this.playerApi.id() != this.partyApi.getArenaLeader().id)
                {
                    this.btn_validate.softDisabled = true;
                }
                else
                {
                    this.btn_validate.softDisabled = false;
                };
            }
            else
            {
                this.btn_quitArena.softDisabled = true;
                this.btn_validate.softDisabled = false;
            };
            var name:String = "";
            var realId:int;
            var isLeader:Boolean;
            var iMy:int;
            while (iMy < TEAM_MEMBERS_MAX)
            {
                name = "";
                realId = 0;
                isLeader = false;
                if (((((((((partyMembers) && ((partyMembers.length > 0)))) && ((iMy < partyMembers.length)))) && (partyMembers[iMy]))) && (partyMembers[iMy].isMember)))
                {
                    name = partyMembers[iMy].name;
                    realId = partyMembers[iMy].id;
                    isLeader = partyMembers[iMy].isLeader;
                }
                else
                {
                    if (((((!(partyMembers)) || ((partyMembers.length == 0)))) && ((iMy == 0))))
                    {
                        name = this.playerApi.getPlayedCharacterInfo().name;
                        realId = this.playerApi.id();
                    }
                    else
                    {
                        if (((((alliesIds) && (alliesIds[iMy]))) && (!((alliesIds[iMy] == this.playerApi.id())))))
                        {
                            name = "";
                            realId = alliesIds[iMy];
                        };
                    };
                };
                this._myTeam.push({
                    "id":iMy,
                    "realId":realId,
                    "name":name,
                    "status":0,
                    "chief":isLeader
                });
                iMy++;
            };
            this.gd_myTeam.dataProvider = this._myTeam;
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_validate:
                    if (!(this._isRegistered))
                    {
                        this.sysApi.sendAction(new ArenaRegister(PvpArenaTypeEnum.ARENA_TYPE_3VS3));
                    }
                    else
                    {
                        this.sysApi.sendAction(new ArenaUnregister());
                    };
                    break;
                case this.btn_quitArena:
                    this.sysApi.sendAction(new PartyLeaveRequest(this.partyApi.getArenaPartyId()));
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var data:Object;
            switch (target)
            {
                case this.btn_validate:
                    if (this.btn_validate.softDisabled)
                    {
                        if (this._isRegistered)
                        {
                            data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arenaUnregistrationRestricted", this.partyApi.getArenaLeader().name));
                        }
                        else
                        {
                            data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arenaRegistrationRestricted", this.partyApi.getArenaLeader().name));
                        };
                    }
                    else
                    {
                        if (this.partyApi.getArenaPartyId() == 0)
                        {
                            if (this._isRegistered)
                            {
                                data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arenaSoloUnregister"));
                            }
                            else
                            {
                                data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arenaSoloRegister"));
                            };
                        }
                        else
                        {
                            if (this._isRegistered)
                            {
                                data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arenaTeamUnregister"));
                            }
                            else
                            {
                                data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arenaTeamRegister"));
                            };
                        };
                    };
                    break;
                case this.btn_quitArena:
                    if (!(this.btn_quitArena.softDisabled))
                    {
                        data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arenaInfoQuit"));
                    };
                    break;
                case this.lbl_fights:
                    data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arenaFightsOfTheDayInfos"));
                    break;
                case this.lbl_rank:
                    data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arenaRankInfos"));
                    break;
                case this.lbl_rankDay:
                    data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arenaRankMaxTodayInfos"));
                    break;
                case this.lbl_rankMax:
                    data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arenaRankMaxInfos"));
                    break;
            };
            if (target.name.indexOf("tx_fighterState") != -1)
            {
                if (this._statusList[target.name].status == 3)
                {
                    data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arenaFightAccepted"));
                }
                else
                {
                    if (this._currentStatus == PvpArenaStepEnum.ARENA_STEP_WAITING_FIGHT)
                    {
                        data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arenaFightNotYetAccepted"));
                    };
                };
            };
            if (data)
            {
                this.uiApi.showTooltip(data, target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "validUi":
                    if (!(this._isRegistered))
                    {
                        this.sysApi.sendAction(new ArenaRegister(PvpArenaTypeEnum.ARENA_TYPE_3VS3));
                    };
                    return (true);
                case "closeUi":
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    return (true);
            };
            return (false);
        }

        public function onArenaRegistrationStatusUpdate(isRegistered:Boolean, currentStatus:int):void
        {
            var whatToDoText:String;
            this._isRegistered = isRegistered;
            this._currentStatus = currentStatus;
            this.lbl_step.text = this.uiApi.getText("ui.common.step", (((this._currentStatus + 1) % 4) + 1), 4);
            switch (this._currentStatus)
            {
                case PvpArenaStepEnum.ARENA_STEP_UNREGISTER:
                    this._nbFightersReady = 0;
                    whatToDoText = this.uiApi.getText("ui.party.arenaInfoInvite");
                    if (!(this.btn_validate.softDisabled))
                    {
                        this.btn_validate.disabled = false;
                    };
                    if (!(this.btn_quitArena.softDisabled))
                    {
                        this.btn_quitArena.disabled = false;
                    };
                    break;
                case PvpArenaStepEnum.ARENA_STEP_REGISTRED:
                    whatToDoText = this.uiApi.getText("ui.party.arenaInfoSearch");
                    if (!(this.btn_validate.softDisabled))
                    {
                        this.btn_validate.disabled = false;
                    };
                    if (!(this.btn_quitArena.softDisabled))
                    {
                        this.btn_quitArena.disabled = false;
                    };
                    break;
                case PvpArenaStepEnum.ARENA_STEP_WAITING_FIGHT:
                    whatToDoText = this.uiApi.getText("ui.party.arenaInfoWaiting", 0);
                    if (!(this.btn_validate.softDisabled))
                    {
                        this.btn_validate.disabled = true;
                    };
                    if (!(this.btn_quitArena.softDisabled))
                    {
                        this.btn_quitArena.disabled = true;
                    };
                    break;
                case PvpArenaStepEnum.ARENA_STEP_STARTING_FIGHT:
                    this._nbFightersReady = 0;
                    whatToDoText = this.uiApi.getText("ui.party.arenaInfoFighting");
                    if (!(this.btn_validate.softDisabled))
                    {
                        this.btn_validate.disabled = true;
                    };
                    if (!(this.btn_quitArena.softDisabled))
                    {
                        this.btn_quitArena.disabled = true;
                    };
                    break;
                default:
                    this.sysApi.log(1, "Probleme de status d'arene");
            };
            if (!(this._isRegistered))
            {
                this.btn_lbl_btn_validate.text = this.uiApi.getText("ui.teamSearch.registration");
            }
            else
            {
                this.btn_lbl_btn_validate.text = this.uiApi.getText("ui.teamSearch.unregistration");
            };
            this.lbl_whatToDo.text = whatToDoText;
        }

        public function onArenaFighterStatusUpdate(playerId:int, answer:Boolean):void
        {
            var myFighter:Object;
            if (answer)
            {
                for each (myFighter in this._myTeam)
                {
                    if (myFighter.realId == playerId)
                    {
                        myFighter.status = 3;
                    };
                };
                this._nbFightersReady++;
                if (this._currentStatus == PvpArenaStepEnum.ARENA_STEP_WAITING_FIGHT)
                {
                    this.lbl_whatToDo.text = this.uiApi.getText("ui.party.arenaInfoWaiting", this._nbFightersReady);
                };
            }
            else
            {
                for each (myFighter in this._myTeam)
                {
                    myFighter.status = 0;
                };
                this._nbFightersReady = 0;
            };
            this.gd_myTeam.dataProvider = this._myTeam;
        }

        public function onArenaFightProposition(alliesIds:Object):void
        {
            var fighterId:int;
            var name:String;
            var partyMember:Object;
            this._myTeam = new Array();
            var partyMembers:Object = this.partyApi.getPartyMembers(1);
            var found:Boolean;
            this._nbFightersReady = 0;
            if (this._currentStatus == PvpArenaStepEnum.ARENA_STEP_WAITING_FIGHT)
            {
                this.lbl_whatToDo.text = this.uiApi.getText("ui.party.arenaInfoWaiting", this._nbFightersReady);
            };
            for each (fighterId in alliesIds)
            {
                found = false;
                if (((!(partyMembers)) || ((partyMembers.length == 0))))
                {
                    if (fighterId == this.playerApi.id())
                    {
                        name = this.playerApi.getPlayedCharacterInfo().name;
                        this._myTeam.push({
                            "id":0,
                            "realId":fighterId,
                            "name":name,
                            "status":0,
                            "chief":false
                        });
                    }
                    else
                    {
                        this._myTeam.push({
                            "id":0,
                            "realId":fighterId,
                            "name":"",
                            "status":0,
                            "chief":false
                        });
                    };
                }
                else
                {
                    for each (partyMember in partyMembers)
                    {
                        if (fighterId == partyMember.id)
                        {
                            this._myTeam.push({
                                "id":0,
                                "realId":fighterId,
                                "name":partyMember.name,
                                "status":0,
                                "chief":partyMember.isLeader
                            });
                            found = true;
                        };
                    };
                    if (!(found))
                    {
                        this._myTeam.push({
                            "id":0,
                            "realId":fighterId,
                            "name":"",
                            "status":0,
                            "chief":false
                        });
                    };
                };
            };
            this.gd_myTeam.dataProvider = this._myTeam;
        }

        public function onPartyJoin(id:int, pMembers:Object, restrict:Boolean, isArenaParty:Boolean, name:String=""):void
        {
            if (id == this.partyApi.getArenaPartyId())
            {
                this.updateFighters();
            };
        }

        public function onPartyUpdate(id:int, pMembers:Object):void
        {
            if (id == this.partyApi.getArenaPartyId())
            {
                this.updateFighters();
            };
        }

        public function onPartyLeave(id:int, isArena:Boolean):void
        {
            if (isArena)
            {
                this.updateFighters();
            };
        }

        public function onPartyMemberUpdate(id:int, playerId:uint):void
        {
            if (id == this.partyApi.getArenaPartyId())
            {
                this.updateFighters();
            };
        }

        public function onPartyLeaderUpdate(id:int, leaderId:uint):void
        {
            if (id == this.partyApi.getArenaPartyId())
            {
                if (((this.partyApi.getArenaLeader()) && (!((this.playerApi.id() == this.partyApi.getArenaLeader().id)))))
                {
                    this.btn_validate.softDisabled = true;
                }
                else
                {
                    this.btn_validate.softDisabled = false;
                };
            };
        }

        public function onPartyMemberRemove(id:int, playerId:uint):void
        {
            if (id == this.partyApi.getArenaPartyId())
            {
                this.updateFighters();
            };
        }

        public function onArenaUpdateRank(ranks:Object, fights:int, wonFights:int):void
        {
            this.lbl_rank.text = this.uiApi.getText("ui.party.arenaRank", ranks[0]);
            this.lbl_rankDay.text = this.uiApi.getText("ui.party.arenaRankMaxToday", ranks[1]);
            this.lbl_rankMax.text = this.uiApi.getText("ui.party.arenaRankMax", ranks[2]);
            this.lbl_fights.text = this.uiApi.getText("ui.party.arenaFightsOfTheDay", wonFights, fights);
        }


    }
}//package ui

