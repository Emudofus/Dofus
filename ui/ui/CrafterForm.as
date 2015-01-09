package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.JobsApi;
    import d2api.MountApi;
    import d2components.GraphicContainer;
    import d2components.EntityDisplayer;
    import d2components.Texture;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2hooks.JobCrafterContactLook;
    import d2actions.JobCrafterContactLookRequest;
    import d2hooks.ChatFocus;
    import d2hooks.*;
    import d2actions.*;

    public class CrafterForm 
    {

        public var output:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var jobsApi:JobsApi;
        public var mountApi:MountApi;
        private var _data:Object;
        public var crafterFormCtr:GraphicContainer;
        public var entdis_character:EntityDisplayer;
        public var tx_bgDeco:Texture;
        public var btn_lucrative:ButtonContainer;
        public var btn_freeOnFailure:ButtonContainer;
        public var btn_dontProvideComponent:ButtonContainer;
        public var btn_mp:ButtonContainer;
        public var btn_close:ButtonContainer;
        public var lbl_nameContent:Label;
        public var lbl_jobContent:Label;
        public var lbl_levelContent:Label;
        public var lbl_subareaContent:Label;
        public var lbl_craftingContent:Label;
        public var lbl_coordContent:Label;
        public var lbl_nbComponentContent:Label;


        public function main(... args):void
        {
            this.sysApi.addHook(JobCrafterContactLook, this.onJobCrafterContactLook);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this._data = args[0];
            this.updateInformations();
            this.entdis_character.direction = 2;
            this.sysApi.sendAction(new JobCrafterContactLookRequest(this._data.playerId));
            this.btn_lucrative.disabled = true;
            this.btn_freeOnFailure.disabled = true;
            this.btn_dontProvideComponent.disabled = true;
        }

        public function unload():void
        {
        }

        private function updateInformations():void
        {
            if (this._data.alignmentSide >= 0)
            {
                this.tx_bgDeco.uri = this.uiApi.createUri((this.uiApi.me().getConstant("alignment_uri") + this._data.alignmentSide));
            }
            else
            {
                this.tx_bgDeco.uri = this.uiApi.createUri((this.uiApi.me().getConstant("alignment_uri") + "0"));
            };
            this.lbl_nameContent.text = (((((("{player," + this._data.playerName) + ",") + this._data.playerId) + "::") + this._data.playerName) + "}");
            this.lbl_jobContent.text = this.jobsApi.getJobName(this._data.jobId);
            this.lbl_levelContent.text = this._data.jobLevel;
            if (!(this._data.isInWorkshop))
            {
                this.lbl_craftingContent.text = this.uiApi.getText("ui.common.no");
                this.lbl_coordContent.text = "-";
                this.lbl_subareaContent.text = "";
            }
            else
            {
                this.lbl_craftingContent.text = this.uiApi.getText("ui.common.yes");
                this.lbl_coordContent.text = this._data.worldPos;
                this.lbl_subareaContent.text = (((this.dataApi.getArea(this.dataApi.getSubArea(this._data.subAreaId).areaId).name + " ( ") + this.dataApi.getSubArea(this._data.subAreaId).name) + " )");
            };
            this.btn_lucrative.selected = this._data.notFree;
            this.btn_freeOnFailure.selected = this._data.notFreeExceptOnFail;
            this.btn_dontProvideComponent.selected = this._data.resourcesRequired;
            this.lbl_nbComponentContent.text = this._data.minSlots;
            if (!(this._data.specialization))
            {
                this.btn_freeOnFailure.selected = false;
                this.btn_freeOnFailure.visible = false;
                this.btn_dontProvideComponent.y = (this.btn_dontProvideComponent.y - 5);
                this.btn_lucrative.y = (this.btn_lucrative.y + 5);
            };
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_mp:
                    this.sysApi.dispatchHook(ChatFocus, this._data.playerName);
                    break;
            };
        }

        public function onJobCrafterContactLook(crafterId:uint, crafterName:String, crafterLook:*):void
        {
            if (this.lbl_nameContent.text == crafterName)
            {
                this.entdis_character.look = this.mountApi.getRiderEntityLook(crafterLook);
            };
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "closeUi":
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    return (true);
            };
            return (false);
        }


    }
}//package ui

