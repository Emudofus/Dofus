package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.PlayedCharacterApi;
    import d2components.GraphicContainer;
    import d2components.ButtonContainer;
    import d2components.Texture;
    import d2hooks.RoleplayBuffViewContent;
    import d2hooks.FoldAll;
    import d2hooks.ShowObjectLinked;
    import d2hooks.*;
    import d2actions.*;

    public class BuffUi 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var playerApi:PlayedCharacterApi;
        private var _buffs:Object;
        private var _slots:Array;
        private var _hidden:Boolean = false;
        private var _foldStatus:Boolean;
        public var buffCtr:GraphicContainer;
        public var btn_minimArrow:ButtonContainer;
        public var btn_minimArrow_small:ButtonContainer;
        public var btn_minimArrow_tx:Texture;
        public var tx_background:Texture;
        public var buffFrames:GraphicContainer;
        public var buff_slot_1:Texture;
        public var buff_slot_2:Texture;
        public var buff_slot_3:Texture;
        public var buff_slot_4:Texture;
        public var buff_slot_5:Texture;
        public var buff_slot_6:Texture;
        public var buff_slot_7:Texture;
        public var buff_slot_8:Texture;


        public function main(param:Object):void
        {
            var slot:Texture;
            this._buffs = new Array();
            this._slots = [this.buff_slot_1, this.buff_slot_2, this.buff_slot_3, this.buff_slot_4, this.buff_slot_5, this.buff_slot_6, this.buff_slot_7, this.buff_slot_8];
            for each (slot in this._slots)
            {
                this.uiApi.addComponentHook(slot, "onRollOver");
                this.uiApi.addComponentHook(slot, "onRollOut");
                this.uiApi.addComponentHook(slot, "onRelease");
            };
            this.btn_minimArrow.visible = false;
            this.tx_background.visible = false;
            this.buffFrames.visible = false;
            this.tx_background.height = 65;
            this.sysApi.addHook(RoleplayBuffViewContent, this.onInventoryUpdate);
            this.sysApi.addHook(FoldAll, this.onFoldAll);
            this.update(param.buffs);
        }

        private function onInventoryUpdate(buffs:Object):void
        {
            this.update(buffs);
            this._hidden = false;
            this.btn_minimArrow.visible = true;
            this.btn_minimArrow_small.visible = false;
            this.tx_background.visible = true;
            this.buffFrames.visible = true;
        }

        public function onRelease(target:Object):void
        {
            var buff:Object;
            switch (target)
            {
                case this.btn_minimArrow:
                    this._hidden = true;
                    this.btn_minimArrow.visible = false;
                    this.btn_minimArrow_small.visible = true;
                    this.tx_background.visible = false;
                    this.buffFrames.visible = false;
                    break;
                case this.btn_minimArrow_small:
                    this._hidden = false;
                    this.btn_minimArrow.visible = true;
                    this.btn_minimArrow_small.visible = false;
                    this.tx_background.visible = true;
                    this.buffFrames.visible = true;
                    break;
                default:
                    if (target.name.indexOf("slot") != -1)
                    {
                        if (!(this.sysApi.getOption("displayTooltips", "dofus")))
                        {
                            buff = this._buffs[this._slots.indexOf(target)];
                            this.sysApi.dispatchHook(ShowObjectLinked, buff);
                        };
                    };
            };
        }

        private function onFoldAll(fold:Boolean):void
        {
            if (fold)
            {
                this._foldStatus = !(this._hidden);
                this._hidden = true;
                this.btn_minimArrow.visible = false;
                this.btn_minimArrow_small.visible = true;
                this.tx_background.visible = false;
                this.buffFrames.visible = false;
            }
            else
            {
                this._hidden = !(this._foldStatus);
                this.btn_minimArrow.visible = this._foldStatus;
                this.btn_minimArrow_small.visible = !(this._foldStatus);
                this.tx_background.visible = this._foldStatus;
                this.buffFrames.visible = this._foldStatus;
            };
        }

        public function onRollOver(target:Object):void
        {
            this.sysApi.log(2, ("target : " + target.name));
            var buff:Object = this._buffs[this._slots.indexOf(target)];
            if (buff)
            {
                this.uiApi.showTooltip(buff, target, false, "standard", 0, 2, 3, "itemName", null, {
                    "showEffects":true,
                    "header":true,
                    "averagePrice":false
                }, "ItemInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function update(buffs:Object):void
        {
            var slot:Object;
            var i:int;
            this._buffs = buffs;
            if (buffs.length == 0)
            {
                this.buffCtr.visible = false;
            }
            else
            {
                this.buffCtr.visible = true;
                i = 0;
                while (i < this._slots.length)
                {
                    slot = this._slots[i];
                    if (i >= buffs.length)
                    {
                        slot.visible = false;
                    }
                    else
                    {
                        slot.visible = true;
                        slot.uri = buffs[i].iconUri;
                    };
                    i++;
                };
                this.tx_background.width = (((this._slots[0].width + 6) * buffs.length) + 20);
                this.tx_background.x = -(this.tx_background.width);
                this.uiApi.me().render();
            };
        }


    }
}//package ui

