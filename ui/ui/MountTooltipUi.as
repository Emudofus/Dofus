package ui
{
    import d2api.SystemApi;
    import d2api.TooltipApi;
    import d2api.UiApi;
    import d2api.PlayedCharacterApi;
    import d2components.GraphicContainer;
    import d2components.EntityDisplayer;
    import d2components.Texture;
    import d2components.Label;
    import d2hooks.MountRenamed;
    import d2hooks.MountXpRatio;
    import d2hooks.MountSterilized;
    import flash.geom.ColorTransform;
    import makers.MountTooltipMaker;
    import d2hooks.*;

    public class MountTooltipUi 
    {

        public var sysApi:SystemApi;
        public var tooltipApi:TooltipApi;
        public var uiApi:UiApi;
        public var playerApi:PlayedCharacterApi;
        private var _mountId:Number;
        private var _mount:Object;
        private var _serenityText:String;
        private var _playerMount:Boolean;
        public var mainCtr:GraphicContainer;
        public var ctr_serenity:GraphicContainer;
        public var ctr_mountReproduction:GraphicContainer;
        public var tx_mount:EntityDisplayer;
        public var tx_love:Texture;
        public var tx_maturity:Texture;
        public var tx_stamina:Texture;
        public var lbl_name:Label;
        public var lbl_ratio:Label;
        public var lbl_ratio0:Label;
        public var lbl_love:Label;
        public var lbl_maturity:Label;
        public var lbl_stamina:Label;
        public var lbl_reproduction:Label;
        public var tx_progressBarEnergy:Texture;
        public var tx_progressBarXP:Texture;
        public var tx_progressBarTired:Texture;
        public var tx_progressBarReproduction:Texture;
        public var tx_progressBarLove:Texture;
        public var tx_progressBarMaturity:Texture;
        public var tx_progressBarStamina:Texture;
        public var tx_progressBarSerenity:Texture;


        public function main(oParam:Object=null):void
        {
            this.sysApi.addHook(MountRenamed, this.onMountRenamed);
            this.sysApi.addHook(MountXpRatio, this.onMountXpRatio);
            this.sysApi.addHook(MountSterilized, this.onMountSterilized);
            this.uiApi.addComponentHook(this.lbl_love, "onRollOver");
            this.uiApi.addComponentHook(this.lbl_love, "onRollOut");
            this.uiApi.addComponentHook(this.lbl_maturity, "onRollOver");
            this.uiApi.addComponentHook(this.lbl_maturity, "onRollOut");
            this.uiApi.addComponentHook(this.lbl_stamina, "onRollOver");
            this.uiApi.addComponentHook(this.lbl_stamina, "onRollOut");
            this.uiApi.addComponentHook(this.lbl_reproduction, "onRollOver");
            this.uiApi.addComponentHook(this.lbl_reproduction, "onRollOut");
            this.uiApi.addComponentHook(this.ctr_serenity, "onRollOver");
            this.uiApi.addComponentHook(this.ctr_serenity, "onRollOut");
            this.uiApi.addComponentHook(this.tx_love, "onRollOver");
            this.uiApi.addComponentHook(this.tx_love, "onRollOut");
            this.uiApi.addComponentHook(this.tx_maturity, "onRollOver");
            this.uiApi.addComponentHook(this.tx_maturity, "onRollOut");
            this.uiApi.addComponentHook(this.tx_stamina, "onRollOver");
            this.uiApi.addComponentHook(this.tx_stamina, "onRollOut");
            this._mount = oParam.data;
            this.uiApi.me().mouseChildren = true;
            if (this._mount.isFecondationReady)
            {
                this.lbl_name.useCustomFormat = true;
                this.lbl_name.text = ((this._mount.name + " - ") + this.uiApi.getText("ui.mount.fecondable"));
            };
            this._serenityText = ((((this._mount.aggressivityMax + "/") + this._mount.serenity) + "/") + this._mount.serenityMax);
            this.tx_mount.look = oParam.data.entityLook;
            this._mountId = oParam.data.id;
            var playerMount:Object = this.playerApi.getMount();
            if (playerMount)
            {
                if (playerMount.id == this._mountId)
                {
                    this._playerMount = true;
                }
                else
                {
                    this._playerMount = false;
                };
            }
            else
            {
                this._playerMount = false;
            };
            this.lbl_ratio.visible = this._playerMount;
            this.lbl_ratio0.visible = this._playerMount;
            this.tx_progressBarEnergy.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 68, -160, -160);
            this.tx_progressBarXP.transform.colorTransform = new ColorTransform(1, 1, 1, 1, -110, -66, 0);
            this.tx_progressBarTired.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 71, -50, -146);
            this.tx_progressBarReproduction.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 71, -50, -146);
            this.tx_progressBarLove.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 71, -50, -146);
            this.tx_progressBarMaturity.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 71, -50, -146);
            this.tx_progressBarStamina.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 71, -50, -146);
            this.tx_progressBarSerenity.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 71, -50, -146);
            this.uiApi.getUi(MountTooltipMaker.lastUiName).getElement("tooltipCtr").addContent(this.uiApi.me());
        }

        private function onMountRenamed(id:Number, name:String):void
        {
            if (id == this._mountId)
            {
                this.lbl_name.text = name;
            };
        }

        private function onMountXpRatio(ratio:uint):void
        {
            this.lbl_ratio.text = (ratio + "%");
        }

        private function onMountSterilized(id:Number):void
        {
            if (id == this._mountId)
            {
                this.ctr_mountReproduction.visible = false;
                this.lbl_reproduction.text = this.uiApi.getText("ui.mount.castrated");
                this.lbl_reproduction.css = "[local.css]normal.css";
            };
        }

        public function onRollOver(target:Object):void
        {
            var textTooltip:String;
            var pos1:int = 6;
            var pos2:int;
            var offset:int;
            if (target == this.lbl_love)
            {
                textTooltip = this.uiApi.getText("ui.mount.viewerTooltipLove");
            }
            else
            {
                if (target == this.lbl_maturity)
                {
                    textTooltip = this.uiApi.getText("ui.mount.viewerTooltipMaturity");
                }
                else
                {
                    if (target == this.lbl_stamina)
                    {
                        textTooltip = this.uiApi.getText("ui.mount.viewerTooltipStamina");
                    }
                    else
                    {
                        if (target == this.ctr_serenity)
                        {
                            textTooltip = this._serenityText;
                            pos1 = 7;
                            pos2 = 1;
                        }
                        else
                        {
                            if (target == this.tx_stamina)
                            {
                                textTooltip = this.uiApi.getText("ui.mount.viewerTooltipZone1");
                                pos1 = 1;
                                pos2 = 7;
                                offset = 10;
                            }
                            else
                            {
                                if (target == this.tx_maturity)
                                {
                                    textTooltip = this.uiApi.getText("ui.mount.viewerToolTipZone2");
                                    pos1 = 1;
                                    pos2 = 7;
                                    offset = 10;
                                }
                                else
                                {
                                    if (target == this.tx_love)
                                    {
                                        textTooltip = this.uiApi.getText("ui.mount.viewerTooltipZone3");
                                        pos1 = 1;
                                        pos2 = 7;
                                        offset = 10;
                                    }
                                    else
                                    {
                                        if (target == this.lbl_reproduction)
                                        {
                                            if (this._mount.fecondationTime != -1)
                                            {
                                                textTooltip = this.uiApi.getText("ui.mount.pregnantSince", this._mount.fecondationTime);
                                                pos1 = 1;
                                                pos2 = 7;
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (textTooltip)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(textTooltip), target, false, "standard", pos1, pos2, offset, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function unload():void
        {
        }


    }
}//package ui

