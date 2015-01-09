package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.MountApi;
    import d2components.Texture;
    import d2components.Label;
    import d2components.ButtonContainer;
    import d2components.Grid;
    import d2data.PartyMemberWrapper;
    import d2data.PartyCompanionWrapper;
    import d2hooks.PartyMemberUpdateDetails;
    import d2hooks.PartyMemberRemove;
    import d2enums.PartyTypeEnum;
    import d2actions.PartyRefuseInvitation;
    import d2actions.PartyAcceptInvitation;
    import d2actions.AddIgnored;

    public class JoinParty 
    {

        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var mountApi:MountApi;
        private var _partyId:uint;
        private var _members:Array;
        private var _fromName:String;
        private var _partyName:String;
        private var _leaderId:uint;
        private var _typeId:uint = 0;
        private var _dungeonId:uint = 0;
        private var _acceptMembersDungeon:Array;
        public var ctr_main:Object;
        public var tx_background:Texture;
        public var lbl_fromName:Label;
        public var lbl_dungeon:Label;
        public var btnClose:Object;
        public var btnValidate:ButtonContainer;
        public var btnCancel:ButtonContainer;
        public var btnIgnore:ButtonContainer;
        public var grid_members:Grid;
        public var tx_slotPlayer:Object;


        public function main(params:Array):void
        {
            var i:PartyMemberWrapper;
            var j:PartyCompanionWrapper;
            var b:Object;
            this.sysApi.addHook(PartyMemberUpdateDetails, this.onPartyMemberUpdate);
            this.sysApi.addHook(PartyMemberRemove, this.onPartyMemberRemove);
            this._partyId = params[0];
            this._fromName = params[1];
            this._leaderId = params[2];
            this._typeId = params[3];
            this._dungeonId = params[6];
            this._partyName = params[8];
            this._members = new Array();
            for each (i in params[4])
            {
                this._members.push(i);
                for each (j in i.companions)
                {
                    this._members.push(j);
                };
            };
            for each (i in params[5])
            {
                this._members.push(i);
                for each (j in i.companions)
                {
                    this._members.push(j);
                };
            };
            this._acceptMembersDungeon = new Array();
            for (b in params[4])
            {
                this._acceptMembersDungeon.push(b);
            };
            if (this._typeId == PartyTypeEnum.PARTY_TYPE_ARENA)
            {
                this.lbl_fromName.text = this.uiApi.getText("ui.common.invitationArena");
            }
            else
            {
                this.lbl_fromName.text = this.uiApi.getText("ui.common.invitationGroupe");
            };
            this.lbl_dungeon.text = this.uiApi.getText("ui.common.invitationPresentation", this._fromName, this._partyName);
            if (this._dungeonId != 0)
            {
                if (this._partyName != "")
                {
                    this.lbl_dungeon.text = (this.lbl_dungeon.text + " ");
                };
                this.lbl_dungeon.text = (this.lbl_dungeon.text + this.uiApi.getText("ui.common.invitationDonjon", this.dataApi.getDungeon(this._dungeonId).name));
            };
            this.lbl_dungeon.text = (this.lbl_dungeon.text + ".");
            this.btnValidate.x = 110;
            this.btnCancel.x = 270;
            this.btnIgnore.x = 610;
            this.btnValidate.y = (this.btnCancel.y = (this.btnIgnore.y = 402));
            this.updateGrid();
        }

        public function unload():void
        {
            this.uiApi.hideTooltip();
        }

        private function updateGrid():void
        {
            this.grid_members.dataProvider = this._members;
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btnClose:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btnCancel:
                    this.sysApi.sendAction(new PartyRefuseInvitation(this._partyId));
                    break;
                case this.btnValidate:
                    this.sysApi.sendAction(new PartyAcceptInvitation(this._partyId));
                    break;
                case this.btnIgnore:
                    this.sysApi.sendAction(new AddIgnored(this._fromName));
                    this.sysApi.sendAction(new PartyRefuseInvitation(this._partyId));
                    break;
            };
        }

        public function updateEntry(data:*, componentsRef:*, selected:Boolean):void
        {
            if (data)
            {
                componentsRef.ed_Player.look = this.mountApi.getRiderEntityLook(data.entityLook);
                componentsRef.ed_Player.visible = true;
                if (!(data.isMember))
                {
                    componentsRef.tx_slotPlayerLine.gotoAndStop = 1;
                    componentsRef.tx_slotPlayerLine.visible = true;
                }
                else
                {
                    componentsRef.tx_slotPlayerLine.gotoAndStop = 2;
                    componentsRef.tx_slotPlayerLine.visible = this.isReady(data.id);
                };
                componentsRef.lbl_name.text = (((((("{player," + data.name) + ",") + data.id) + "::") + data.name) + "}");
                if (data.breedId)
                {
                    componentsRef.lbl_breed.text = this.dataApi.getBreed(data.breedId).shortName;
                }
                else
                {
                    componentsRef.lbl_breed.text = "";
                };
                if ((((data.level == 0)) || ((data is PartyCompanionWrapper))))
                {
                    componentsRef.lbl_level.text = "";
                }
                else
                {
                    componentsRef.lbl_level.text = ((this.uiApi.getText("ui.common.level") + " ") + data.level);
                };
                componentsRef.tx_leaderCrown.gotoAndStop = 2;
                componentsRef.tx_leaderCrown.visible = (((data.id == this._leaderId)) && (!((data is PartyCompanionWrapper))));
            }
            else
            {
                componentsRef.tx_slotPlayerLine.visible = false;
                componentsRef.tx_leaderCrown.visible = false;
                componentsRef.ed_Player.visible = false;
                componentsRef.lbl_name.text = "";
                componentsRef.lbl_breed.text = "";
                componentsRef.lbl_level.text = "";
            };
        }

        private function isReady(playerId:uint):Boolean
        {
            var m:int;
            if ((((this._acceptMembersDungeon == null)) || ((this._acceptMembersDungeon.length <= 0))))
            {
                return (false);
            };
            for each (m in this._acceptMembersDungeon)
            {
                if (m == playerId)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var txt:String;
            if (item.data)
            {
                if (item.data.subAreaId)
                {
                    txt = (((((((this.uiApi.getText("ui.common.invitationLocation") + " ") + this.dataApi.getSubArea(item.data.subAreaId).name) + " (") + item.data.worldX) + ",") + item.data.worldY) + ")");
                };
                if (txt != "")
                {
                    this.uiApi.showTooltip(txt, item.container, false, "standard", 2, 0, 0, null, null, null, null);
                };
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        private function onPartyMemberUpdate(pPartyId:uint, pGuest:PartyMemberWrapper, pIsInGroup:Boolean):void
        {
            var c:PartyCompanionWrapper;
            var newMembers:Array;
            var m:PartyMemberWrapper;
            var i:int;
            var c2:PartyCompanionWrapper;
            if (this._partyId != pPartyId)
            {
                return;
            };
            var index:int = this.getMemberIndex(pGuest.id);
            if (index == -1)
            {
                this._members.push(pGuest);
                for each (c in pGuest.companions)
                {
                    this._members.push(c);
                };
            }
            else
            {
                newMembers = new Array();
                for each (m in this._members)
                {
                    if (m.id != pGuest.id)
                    {
                        newMembers.push(m);
                    };
                };
                this._members = newMembers;
                this._members.splice(index, 0, pGuest);
                i = 0;
                for each (c2 in pGuest.companions)
                {
                    i++;
                    this._members.splice((index + i), 0, c2);
                };
            };
            this.updateGrid();
        }

        private function onPartyMemberRemove(pPartyId:uint, pMemberId:uint):void
        {
            var m:PartyMemberWrapper;
            if (this._partyId != pPartyId)
            {
                return;
            };
            var newMembers:Array = new Array();
            for each (m in this._members)
            {
                if (m.id != pMemberId)
                {
                    newMembers.push(m);
                };
            };
            this._members = newMembers;
            this.updateGrid();
        }

        private function getMemberIndex(guestId:int):int
        {
            var m:PartyMemberWrapper;
            for each (m in this._members)
            {
                if (m.id == guestId)
                {
                    return (this._members.indexOf(m));
                };
            };
            return (-1);
        }


    }
}//package ui

