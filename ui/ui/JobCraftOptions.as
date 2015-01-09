package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.JobsApi;
    import d2api.PlayedCharacterApi;
    import d2data.Job;
    import d2components.Label;
    import d2components.ButtonContainer;
    import d2components.ComboBox;
    import d2hooks.JobAllowMultiCraftRequest;
    import d2enums.ShortcutHookListEnum;
    import d2actions.JobAllowMultiCraftRequestSet;
    import d2actions.JobCrafterDirectoryDefineSettings;
    import d2hooks.*;
    import d2actions.*;

    public class JobCraftOptions 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var jobsApi:JobsApi;
        public var playerApi:PlayedCharacterApi;
        private var _bAllowCraftRequest:Boolean = false;
        private var _currentJob:Job;
        public var lbl_title:Label;
        public var btn_lbl_btn_activate:Label;
        public var chk_notFree:ButtonContainer;
        public var chk_freeOnFail:ButtonContainer;
        public var chk_resourcesRequired:ButtonContainer;
        public var combo_nbSlot:ComboBox;
        public var btn_activate:ButtonContainer;
        public var btn_close:ButtonContainer;
        public var btn_save:ButtonContainer;


        public function main(params:Object):void
        {
            this.sysApi.addHook(JobAllowMultiCraftRequest, this.onJobAllowMultiCraftRequest);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortCut);
            this._currentJob = params[0];
            this.lbl_title.text = ((this.uiApi.getText("ui.craft.jobOptions") + " ") + this._currentJob.name);
            var availableSlots:Array = new Array();
            var i:int;
            while (i < this.jobsApi.getMaxSlotsByJobId(this._currentJob.id))
            {
                availableSlots[i] = (i + 1).toString();
                i++;
            };
            this.combo_nbSlot.dataProvider = availableSlots;
            this.updateOptions();
        }

        public function unload():void
        {
        }

        private function updateOptions():void
        {
            var settings:Object = this.jobsApi.getJobCrafterDirectorySettingsById(this._currentJob.id);
            this.chk_notFree.selected = settings.notFree;
            if (!(this._currentJob.specializationOfId))
            {
                this.chk_freeOnFail.selected = false;
                this.chk_freeOnFail.visible = false;
            }
            else
            {
                if (this.chk_notFree.selected)
                {
                    this.chk_freeOnFail.disabled = false;
                    this.chk_freeOnFail.selected = settings.notFreeExceptOnFail;
                }
                else
                {
                    this.chk_freeOnFail.selected = false;
                    this.chk_freeOnFail.disabled = true;
                };
            };
            this.chk_resourcesRequired.selected = settings.resourcesRequired;
            this._bAllowCraftRequest = this.playerApi.publicMode();
            this.btn_lbl_btn_activate.text = ((this._bAllowCraftRequest) ? (this.uiApi.getText("ui.craft.disablePublicMode")) : (this.uiApi.getText("ui.craft.enablePublicMode")));
            this.combo_nbSlot.value = settings.minSlots.toString();
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.chk_notFree:
                    if (this.chk_notFree.selected)
                    {
                        this.chk_freeOnFail.disabled = false;
                    }
                    else
                    {
                        this.chk_freeOnFail.selected = false;
                        this.chk_freeOnFail.disabled = true;
                    };
                    break;
                case this.btn_activate:
                    this.sysApi.sendAction(new JobAllowMultiCraftRequestSet(!(this._bAllowCraftRequest)));
                    break;
                case this.btn_save:
                    this.sysApi.sendAction(new JobCrafterDirectoryDefineSettings(this._currentJob.id, (int(Number(this.combo_nbSlot.selectedIndex)) + 1), this.chk_notFree.selected, this.chk_freeOnFail.selected, this.chk_resourcesRequired.selected));
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
        }

        public function onJobAllowMultiCraftRequest(active:Boolean):void
        {
            this._bAllowCraftRequest = active;
            this.btn_lbl_btn_activate.text = ((active) ? (this.uiApi.getText("ui.craft.disablePublicMode")) : (this.uiApi.getText("ui.craft.enablePublicMode")));
        }

        private function onShortCut(s:String):Boolean
        {
            if (s == "closeUi")
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
                return (true);
            };
            return (false);
        }


    }
}//package ui

