package ui
{
    import d2api.UiApi;
    import d2api.SystemApi;
    import d2api.SoundApi;
    import d2components.GraphicContainer;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2components.TextArea;
    import d2components.Texture;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2hooks.ClosePopup;
    import d2hooks.*;
    import d2actions.*;

    public class LargePopup 
    {

        public var uiApi:UiApi;
        public var sysApi:SystemApi;
        public var soundApi:SoundApi;
        protected var _aEventIndex:Array;
        protected var onCancelFunction:Function = null;
        protected var onEnterKey:Function = null;
        protected var numberButton:uint;
        protected var defaultShortcutFunction:Function;
        public var popCtr:GraphicContainer;
        public var btn_close:ButtonContainer;
        public var ctr_buttons:GraphicContainer;
        public var lbl_title:Label;
        public var lbl_content:TextArea;
        public var tx_background:Texture;

        public function LargePopup()
        {
            this._aEventIndex = new Array();
            super();
        }

        public function main(param:Object):void
        {
            var ie:Object;
            var btn:ButtonContainer;
            var btnTx:Texture;
            var btnLbl:Label;
            var stateChangingProperties:Array;
            this.sysApi.log(2, ("go large popup " + param));
            this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
            this.btn_close.soundId = SoundEnum.WINDOW_CLOSE;
            this.tx_background.autoGrid = true;
            this.lbl_content.multiline = true;
            this.lbl_content.wordWrap = true;
            this.lbl_content.allowTextMouse(true);
            if (param)
            {
                if (param.hideModalContainer)
                {
                    this.popCtr.getUi().showModalContainer = false;
                }
                else
                {
                    this.popCtr.getUi().showModalContainer = true;
                };
                this.lbl_title.text = param.title;
                if (param.useHyperLink)
                {
                    this.lbl_content.hyperlinkEnabled = true;
                    this.lbl_content.useStyleSheet = true;
                };
                this.lbl_content.text = param.content;
                if (((!(param.buttonText)) || (!(param.buttonText.length))))
                {
                    throw (new Error("Can't create popup without any button"));
                };
            }
            else
            {
                throw (new Error("Can't load popup without properties."));
            };
            var btnWidth:uint = 100;
            var btnHeight:uint = 32;
            var padding:uint = 20;
            this.sysApi.log(2, ("hauteur " + this.popCtr.height));
            this.numberButton = param.buttonText.length;
            if ((((((this.numberButton == 1)) && (param.buttonCallback))) && ((param.buttonCallback.length == 1))))
            {
                this.defaultShortcutFunction = param.buttonCallback[0];
            };
            var i:uint;
            while (i < this.numberButton)
            {
                btn = (this.uiApi.createContainer("ButtonContainer") as ButtonContainer);
                if (i == 0)
                {
                    btn.soundId = SoundEnum.POPUP_YES;
                }
                else
                {
                    btn.soundId = SoundEnum.POPUP_NO;
                };
                btn.width = btnWidth;
                btn.height = btnHeight;
                btn.x = (i * (padding + btnWidth));
                btn.name = ("btn" + (i + 1));
                btnTx = (this.uiApi.createComponent("Texture") as Texture);
                btnTx.width = btnWidth;
                btnTx.height = btnHeight;
                btnTx.uri = this.uiApi.createUri(this.uiApi.me().getConstant("btn.file"));
                btnTx.autoGrid = true;
                btnTx.name = (btn.name + "_tx");
                this.uiApi.me().registerId(btnTx.name, this.uiApi.createContainer("GraphicElement", btnTx, new Array(), btnTx.name));
                btnTx.finalize();
                btnLbl = (this.uiApi.createComponent("Label") as Label);
                btnLbl.width = btnWidth;
                btnLbl.height = btnHeight;
                btnLbl.verticalAlign = "center";
                btnLbl.css = this.uiApi.createUri(this.uiApi.me().getConstant("btn.css"));
                btnLbl.text = this.uiApi.replaceKey(param.buttonText[i]);
                btn.addChild(btnTx);
                btn.addChild(btnLbl);
                stateChangingProperties = new Array();
                stateChangingProperties[1] = new Array();
                stateChangingProperties[1][btnTx.name] = new Array();
                stateChangingProperties[1][btnTx.name]["gotoAndStop"] = "over";
                stateChangingProperties[2] = new Array();
                stateChangingProperties[2][btnTx.name] = new Array();
                stateChangingProperties[2][btnTx.name]["gotoAndStop"] = "pressed";
                btn.changingStateData = stateChangingProperties;
                if (((param.buttonCallback) && (param.buttonCallback[i])))
                {
                    this._aEventIndex[btn.name] = param.buttonCallback[i];
                };
                this.uiApi.addComponentHook(btn, "onRelease");
                this.ctr_buttons.addChild(btn);
                i++;
            };
            if (param.onCancel)
            {
                this.onCancelFunction = param.onCancel;
            };
            if (param.onEnterKey)
            {
                this.onEnterKey = param.onEnterKey;
            };
            this.uiApi.me().render();
        }

        public function onRelease(target:Object):void
        {
            if (this._aEventIndex[target.name])
            {
                this._aEventIndex[target.name].apply(null);
            }
            else
            {
                if ((((target == this.btn_close)) && (!((this.onCancelFunction == null)))))
                {
                    this.onCancelFunction();
                };
            };
            if (((((this.uiApi) && (this.uiApi.me()))) && (this.uiApi.getUi(this.uiApi.me().name))))
            {
                this.closeMe();
            };
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "validUi":
                    if ((((this.onEnterKey == null)) && ((this.numberButton > 1))))
                    {
                        throw (new Error("onEnterKey method is null"));
                    };
                    if (this.onEnterKey != null)
                    {
                        this.onEnterKey();
                    }
                    else
                    {
                        if (this.defaultShortcutFunction != null)
                        {
                            this.defaultShortcutFunction();
                        };
                    };
                    this.closeMe();
                    return (true);
                case "closeUi":
                    if ((((this.onCancelFunction == null)) && ((this.numberButton > 1))))
                    {
                        throw (new Error("onCancelFunction method is null"));
                    };
                    if (this.onCancelFunction != null)
                    {
                        this.onCancelFunction();
                    };
                    this.closeMe();
                    return (true);
            };
            return (false);
        }

        private function closeMe():void
        {
            this.uiApi.unloadUi(this.uiApi.me().name);
        }

        public function unload():void
        {
            this.sysApi.dispatchHook(ClosePopup);
        }


    }
}//package ui

