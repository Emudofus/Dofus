package ui
{
    import d2api.UiApi;
    import d2api.SystemApi;
    import d2api.SoundApi;
    import d2components.GraphicContainer;
    import d2components.Label;
    import d2components.InputComboBox;
    import d2components.ButtonContainer;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2enums.ShortcutHookListEnum;
    import d2hooks.ClosePopup;
    import d2hooks.*;

    public class InputComboBoxPopup 
    {

        public var uiApi:UiApi;
        public var sysApi:SystemApi;
        public var soundApi:SoundApi;
        private var _validCallBack:Function;
        private var _cancelCallback:Function;
        private var _resetCallback:Function;
        public var mainCtr:GraphicContainer;
        public var lbl_title:Label;
        public var lbl_description:Label;
        public var lbl_input:InputComboBox;
        public var btn_close:ButtonContainer;
        public var btn_ok:ButtonContainer;
        public var btn_emptyOptionHistory:ButtonContainer;
        public var _resetButtonTooltip:String;


        public function main(param:Object):void
        {
            this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
            this.btn_ok.soundId = SoundEnum.OK_BUTTON;
            this.lbl_title.text = param.title;
            this.lbl_description.text = param.content;
            this.lbl_input.input.text = param.defaultValue;
            this.lbl_input.input.selectAll();
            this._validCallBack = param.validCallBack;
            this._cancelCallback = param.cancelCallback;
            this._resetCallback = param.resetCallback;
            this._resetButtonTooltip = param.resetButtonTooltip;
            this.lbl_input.input.restrictChars = param.restric;
            this.lbl_input.maxChars = param.maxChars;
            this.lbl_input.focus();
            this.lbl_input.dataProvider = param.dataProvider;
        }

        public function onRelease(target:Object):void
        {
            var unload:Boolean = true;
            if (target == this.btn_ok)
            {
                if (this._validCallBack != null)
                {
                    this._validCallBack(this.lbl_input.input.text);
                };
            }
            else
            {
                if (target == this.btn_close)
                {
                    if (this._cancelCallback != null)
                    {
                        this._cancelCallback();
                    };
                }
                else
                {
                    if (target == this.btn_emptyOptionHistory)
                    {
                        unload = false;
                        this.lbl_input.dataProvider = new Array();
                        if (this._resetCallback != null)
                        {
                            this._resetCallback();
                        };
                    };
                };
            };
            if (unload)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            switch (target)
            {
                case this.btn_emptyOptionHistory:
                    text = this._resetButtonTooltip;
                    break;
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onShortcut(s:String):Boolean
        {
            if (this.lbl_input == null)
            {
                return (true);
            };
            switch (s)
            {
                case ShortcutHookListEnum.VALID_UI:
                    if (this._validCallBack != null)
                    {
                        this._validCallBack(this.lbl_input.input.text);
                    };
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case ShortcutHookListEnum.CLOSE_UI:
                    this.onRelease(this.btn_close);
                    return (true);
            };
            return (false);
        }

        public function unload():void
        {
            this.sysApi.dispatchHook(ClosePopup);
        }


    }
}//package ui

