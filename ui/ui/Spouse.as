package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.SocialApi;
    import d2api.PlayedCharacterApi;
    import d2api.DataApi;
    import d2api.SoundApi;
    import flash.display.Sprite;
    import d2components.GraphicContainer;
    import d2components.Label;
    import d2components.ButtonContainer;
    import d2components.Texture;
    import d2components.EntityDisplayer;
    import d2hooks.SpouseFollowStatusUpdated;
    import d2hooks.SpouseUpdated;
    import d2actions.FriendSpouseFollow;
    import d2actions.PartyInvitation;
    import d2actions.JoinSpouse;
    import d2hooks.*;
    import d2actions.*;

    public class Spouse 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var socialApi:SocialApi;
        public var playerApi:PlayedCharacterApi;
        public var dataApi:DataApi;
        public var soundApi:SoundApi;
        private var _spouse:Object;
        private var _charMask:Sprite;
        public var spouseCtr:GraphicContainer;
        public var lbl_title:Label;
        public var lbl_name:Label;
        public var lbl_breed:Label;
        public var lbl_level:Label;
        public var lbl_guild:Label;
        public var lbl_state:Label;
        public var lbl_loc:Label;
        public var lbl_alignment:Label;
        public var btn_lbl_btn_follow:Label;
        public var btn_group:ButtonContainer;
        public var btn_follow:ButtonContainer;
        public var btn_join:ButtonContainer;
        public var tx_inFight:Texture;
        public var ent_spouse:EntityDisplayer;


        public function main(... params):void
        {
            this.sysApi.addHook(SpouseFollowStatusUpdated, this.onSpouseFollowStatusUpdated);
            this.sysApi.addHook(SpouseUpdated, this.onSpouseUpdated);
            this.uiApi.addComponentHook(this.btn_group, "onRelease");
            this.uiApi.addComponentHook(this.btn_follow, "onRelease");
            this.uiApi.addComponentHook(this.btn_join, "onRelease");
            this._charMask = new Sprite();
            this._charMask.name = "charMask";
            this.displaySpouse();
        }

        public function unload():void
        {
        }

        private function displaySpouse():void
        {
            this._spouse = this.socialApi.getSpouse();
            this.lbl_name.text = (((((("{player," + this._spouse.name) + ",") + this._spouse.id) + "::") + this._spouse.name) + "}");
            this.lbl_title.text = this.uiApi.processText(this.uiApi.getText("ui.common.spouse"), (((this._spouse.sex > 0)) ? "f" : "m"), true);
            this.lbl_level.text = this._spouse.level;
            if (this._spouse.breed > 0)
            {
                this.lbl_breed.text = this.dataApi.getBreed(this._spouse.breed).shortName;
            }
            else
            {
                this.lbl_breed.text = "-";
            };
            if (this._spouse.entityLook != this.ent_spouse.look)
            {
                this.ent_spouse.look = this._spouse.entityLook;
            };
            this.lbl_guild.text = this._spouse.guildName;
            this.lbl_alignment.text = this.dataApi.getAlignmentSide(this._spouse.alignmentSide).name;
            if (this._spouse.online)
            {
                this.lbl_state.text = this.uiApi.getText("ui.server.state.online");
                this.lbl_loc.text = this.dataApi.getSubArea(this._spouse.subareaId).name;
                if (this._spouse.inFight)
                {
                    this.tx_inFight.visible = true;
                }
                else
                {
                    this.tx_inFight.visible = false;
                };
                if (this._spouse.followSpouse)
                {
                    this.btn_lbl_btn_follow.text = this.uiApi.getText("ui.common.stopFollow");
                }
                else
                {
                    this.btn_lbl_btn_follow.text = this.uiApi.getText("ui.common.follow");
                };
                if (this.btn_follow.disabled)
                {
                    this.btn_follow.disabled = false;
                };
                if (this.btn_group.disabled)
                {
                    this.btn_group.disabled = false;
                };
                if (this.btn_join.disabled)
                {
                    this.btn_join.disabled = false;
                };
            }
            else
            {
                if (this.tx_inFight.visible)
                {
                    this.tx_inFight.visible = false;
                };
                this.lbl_loc.text = "-";
                this.lbl_state.text = this.uiApi.getText("ui.server.state.offline");
                this.btn_follow.disabled = true;
                this.btn_group.disabled = true;
                this.btn_join.disabled = true;
            };
        }

        private function onSpouseFollowStatusUpdated(enable:Boolean):void
        {
            if (enable)
            {
                this.btn_lbl_btn_follow.text = this.uiApi.getText("ui.common.stopFollow");
            }
            else
            {
                this.btn_lbl_btn_follow.text = this.uiApi.getText("ui.common.follow");
            };
            this._spouse = this.socialApi.getSpouse();
        }

        private function onSpouseUpdated():void
        {
            this._spouse = this.socialApi.getSpouse();
            this.displaySpouse();
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_follow:
                    this.sysApi.sendAction(new FriendSpouseFollow(!(this._spouse.followSpouse)));
                    break;
                case this.btn_group:
                    this.sysApi.sendAction(new PartyInvitation(this._spouse.name));
                    break;
                case this.btn_join:
                    this.sysApi.sendAction(new JoinSpouse());
                    this.uiApi.unloadUi("socialBase");
                    break;
            };
        }


    }
}//package ui

