package ui.items
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.JobsApi;
    import d2api.ContextMenuApi;
    import d2components.Slot;
    import d2components.Label;
    import d2data.Job;
    import d2hooks.ShowObjectLinked;
    import d2hooks.*;

    public class SkillItem 
    {

        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var jobApi:JobsApi;
        public var menuApi:ContextMenuApi;
        public var slotTarget:Slot;
        public var slotTool:Slot;
        public var lblTarget:Label;
        public var lblSkill:Label;
        public var lblInfo:Label;
        private var _grid:Object;
        private var _data;
        private var _selected:Boolean;
        private var _currentJob:Job;


        public function main(oParam:Object=null):void
        {
            this._grid = oParam.grid;
            this._data = oParam.data;
            this._selected = oParam.selected;
            this.uiApi.addComponentHook(this.slotTarget, "onRollOver");
            this.uiApi.addComponentHook(this.slotTarget, "onRollOut");
            this.uiApi.addComponentHook(this.slotTarget, "onRightClick");
            this.uiApi.addComponentHook(this.slotTarget, "onRelease");
            this.uiApi.addComponentHook(this.slotTool, "onRollOver");
            this.uiApi.addComponentHook(this.slotTool, "onRollOut");
            this.uiApi.addComponentHook(this.slotTool, "onRightClick");
            this.uiApi.addComponentHook(this.slotTool, "onRelease");
            this.update(this._data, this._selected);
        }

        public function get data()
        {
            return (this._data);
        }

        public function get selected():Boolean
        {
            return (this._selected);
        }

        public function update(data:*, selected:Boolean):void
        {
            var toolWrapper:Object;
            var _local_4:Object;
            var _local_5:Object;
            this._data = data;
            if (data)
            {
                this._currentJob = this._grid.getUi().uiClass.currentJob;
                this.lblSkill.text = this._data.name;
                this.lblTarget.text = this._data.interactive.name;
                switch (this.jobApi.getJobSkillType(this._currentJob, this._data))
                {
                    case "craft":
                        _local_4 = this.jobApi.getJobCraftSkillInfos(this._currentJob, this._data);
                        this.lblInfo.width = 201;
                        this.lblInfo.text = this.uiApi.getText("ui.jobs.slotPercents", _local_4.maxSlots, _local_4.probability);
                        break;
                    case "collect":
                        _local_5 = this.jobApi.getJobCollectSkillInfos(this._currentJob, this._data);
                        this.lblInfo.width = 159;
                        this.lblInfo.text = this.uiApi.getText("ui.jobs.collectSkillInfos", _local_5.time, _local_5.minResources, _local_5.maxResources);
                        break;
                };
                if (this._data.gatheredRessourceItem != -1)
                {
                    this.slotTarget.data = this.dataApi.getItemWrapper(this._data.gatheredRessourceItem);
                }
                else
                {
                    this.slotTarget.data = null;
                };
                toolWrapper = this.getToolFromJob(this._currentJob);
                if (toolWrapper)
                {
                    this.slotTool.data = toolWrapper;
                }
                else
                {
                    this.slotTool.data = null;
                };
                this.slotTarget.visible = true;
                this.slotTool.visible = true;
            }
            else
            {
                this.slotTarget.visible = false;
                this.slotTool.visible = false;
                this.lblInfo.text = "";
                this.lblSkill.text = "";
                this.lblTarget.text = "";
            };
        }

        public function getToolFromJob(job:Object):Object
        {
            var currentItem:Object;
            var toolId:Object;
            var item:Object;
            var name:String;
            var tools:Object = job.toolIds;
            if (((tools) && (tools.length)))
            {
                for each (toolId in tools)
                {
                    item = this.dataApi.getItemWrapper((toolId as uint));
                    name = item.name;
                    if ((((((name.indexOf("WIP") == -1)) && (((((!(currentItem)) || ((currentItem.level > item.level)))) || ((((currentItem.level == item.level)) && ((currentItem.objectGID > item.objectGID)))))))) && (!((item.iconUri.fileName == "0.png")))))
                    {
                        currentItem = item;
                    };
                };
                if (currentItem)
                {
                    return (currentItem);
                };
            };
            return (null);
        }

        public function select(b:Boolean):void
        {
        }

        public function onRollOver(target:Object):void
        {
            var ttData:Object;
            switch (target)
            {
                case this.slotTarget:
                case this.slotTool:
                    if (target.data)
                    {
                        this.uiApi.showTooltip(target.data, target, false, "standard", 8, 0, 0, "itemName", null, {
                            "showEffects":true,
                            "header":true
                        }, "ItemInfo");
                    };
                    break;
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onRelease(target:Object):void
        {
            if (!(this.sysApi.getOption("displayTooltips", "dofus")))
            {
                this.sysApi.dispatchHook(ShowObjectLinked, target.data);
            };
        }

        public function onRightClick(target:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            if (target == this.slotTarget)
            {
                data = target.data;
                contextMenu = this.menuApi.create(data);
                if (contextMenu.content.length > 0)
                {
                    this.modContextMenu.createContextMenu(contextMenu);
                };
            };
        }


    }
}//package ui.items

