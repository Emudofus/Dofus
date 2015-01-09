package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.JobsApi;
    import d2api.SoundApi;
    import d2components.GraphicContainer;
    import d2components.ComboBox;
    import d2components.Grid;
    import d2components.Label;
    import d2components.ButtonContainer;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import d2hooks.CrafterDirectoryListUpdate;
    import d2actions.JobCrafterDirectoryListRequest;
    import d2actions.LeaveDialogRequest;
    import d2hooks.*;
    import d2actions.*;

    public class CrafterList 
    {

        public var output:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var jobsApi:JobsApi;
        public var soundApi:SoundApi;
        private var _bDescendingSort:Boolean = false;
        private var _jobs:Array;
        private var _sCraftersText:String;
        private var _sChooseJobText:String;
        public var crafterListCtr:GraphicContainer;
        public var listCtr:GraphicContainer;
        public var combo_job:ComboBox;
        public var gd_crafters:Grid;
        public var lbl_nbCrafter:Label;
        public var lbl_job:Label;
        public var btn_tabAli1:ButtonContainer;
        public var btn_tabBreed:ButtonContainer;
        public var btn_tabAli2:ButtonContainer;
        public var btn_tabName:ButtonContainer;
        public var btn_tabLevel:ButtonContainer;
        public var btn_tabCoord:ButtonContainer;
        public var btn_tabCost:ButtonContainer;
        public var btn_tabNbSlots:ButtonContainer;
        public var btn_search:Object;
        public var btn_close:ButtonContainer;


        public function main(jobs:Array):void
        {
            var job:*;
            this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_OPEN);
            this.sysApi.addHook(CrafterDirectoryListUpdate, this.onCrafterDirectoryListUpdate);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this._sChooseJobText = this.uiApi.getText("ui.craft.chooseJob");
            this._sCraftersText = this.uiApi.getText("ui.craft.crafters");
            this.gd_crafters.dataProvider = new Array();
            this._jobs = new Array();
            var labels:Array = new Array();
            if (jobs.length > 1)
            {
                labels.push(this._sChooseJobText);
                for each (job in jobs)
                {
                    labels.push(this.jobsApi.getJobName(job));
                    this._jobs.push(job);
                };
                this.combo_job.dataProvider = labels;
                this.combo_job.value = labels[0];
                this.lbl_job.visible = false;
            }
            else
            {
                this.sysApi.sendAction(new JobCrafterDirectoryListRequest(jobs[0]));
                this.lbl_job.text = this.jobsApi.getJobName(jobs[0]);
                this.combo_job.visible = false;
            };
        }

        public function unload():void
        {
            this.sysApi.sendAction(new LeaveDialogRequest());
            this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_CLOSE);
        }

        public function onCrafterDirectoryListUpdate(list:Object):void
        {
            var crafter:*;
            var crafters:Array = new Array();
            for each (crafter in list)
            {
                crafters.push(crafter);
            };
            this.gd_crafters.dataProvider = crafters;
            this.lbl_nbCrafter.text = ((crafters.length + " ") + this._sCraftersText);
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_search:
                    break;
                case this.btn_tabAli1:
                case this.btn_tabAli2:
                    if (this._bDescendingSort)
                    {
                        this.gd_crafters.sortOn("alignmentSide", Array.NUMERIC);
                    }
                    else
                    {
                        this.gd_crafters.sortOn("alignmentSide", (Array.NUMERIC | Array.DESCENDING));
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
                case this.btn_tabBreed:
                    if (this._bDescendingSort)
                    {
                        this.gd_crafters.sortOn("breed", Array.NUMERIC);
                    }
                    else
                    {
                        this.gd_crafters.sortOn("breed", (Array.NUMERIC | Array.DESCENDING));
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
                case this.btn_tabName:
                    if (this._bDescendingSort)
                    {
                        this.gd_crafters.sortOn("playerName", Array.CASEINSENSITIVE);
                    }
                    else
                    {
                        this.gd_crafters.sortOn("playerName", (Array.CASEINSENSITIVE | Array.DESCENDING));
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
                case this.btn_tabLevel:
                    if (this._bDescendingSort)
                    {
                        this.gd_crafters.sortOn("jobLevel", Array.NUMERIC);
                    }
                    else
                    {
                        this.gd_crafters.sortOn("jobLevel", (Array.NUMERIC | Array.DESCENDING));
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
                case this.btn_tabCost:
                    if (this._bDescendingSort)
                    {
                        this.gd_crafters.sortOn("notFree");
                    }
                    else
                    {
                        this.gd_crafters.sortOn("notFree", Array.DESCENDING);
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
                case this.btn_tabCoord:
                    if (this._bDescendingSort)
                    {
                        this.gd_crafters.sortOn("worldPos");
                    }
                    else
                    {
                        this.gd_crafters.sortOn("worldPos", Array.DESCENDING);
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
                case this.btn_tabNbSlots:
                    if (this._bDescendingSort)
                    {
                        this.gd_crafters.sortOn("minSlots", Array.NUMERIC);
                    }
                    else
                    {
                        this.gd_crafters.sortOn("minSlots", (Array.NUMERIC | Array.DESCENDING));
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
        }

        public function onRollOut(target:Object):void
        {
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var jobId:uint;
            switch (target)
            {
                case this.combo_job:
                    if (this.combo_job.selectedIndex > 0)
                    {
                        jobId = this._jobs[(this.combo_job.selectedIndex - 1)];
                        this.sysApi.sendAction(new JobCrafterDirectoryListRequest(jobId));
                    }
                    else
                    {
                        this.gd_crafters.dataProvider = new Array();
                        this.lbl_nbCrafter.text = "";
                    };
                    break;
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

