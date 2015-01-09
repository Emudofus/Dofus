package ui
{
    import d2api.UiApi;
    import d2api.SystemApi;
    import d2api.SoundApi;
    import d2components.GraphicContainer;
    import d2components.Label;
    import d2components.TextArea;
    import d2components.ButtonContainer;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2enums.ShortcutHookListEnum;
    import d2hooks.ClosePopup;
    import d2actions.*;
    import d2hooks.*;

    public class CheckboxPopup 
    {

        public var uiApi:UiApi;
        public var sysApi:SystemApi;
        public var soundApi:SoundApi;
        private var _validCallBack:Function;
        private var _cancelCallback:Function;
        public var mainCtr:GraphicContainer;
        public var lbl_title:Label;
        public var lbl_description:TextArea;
        public var btn_label_btn_checkbox:Label;
        public var btn_checkbox:ButtonContainer;
        public var btn_close:ButtonContainer;
        public var btn_ok:ButtonContainer;
        public var btn_undo:ButtonContainer;


        public function main(param:Object):void
        {
            this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
            this.btn_ok.soundId = SoundEnum.OK_BUTTON;
            this.lbl_title.text = param.title;
            this.lbl_description.text = param.content;
            this.btn_checkbox.selected = param.defaultSelect;
            this.btn_label_btn_checkbox.text = param.checkboxText;
            this._validCallBack = param.validCallBack;
            this._cancelCallback = param.cancelCallback;
        }

        public function onRelease(target:Object):void
        {
            if (target == this.btn_ok)
            {
                if (this._validCallBack != null)
                {
                    this._validCallBack(this.btn_checkbox.selected);
                };
            }
            else
            {
                if ((((target == this.btn_close)) || ((target == this.btn_undo))))
                {
                    if (this._cancelCallback != null)
                    {
                        this._cancelCallback();
                    };
                };
            };
            this.uiApi.unloadUi(this.uiApi.me().name);
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case ShortcutHookListEnum.VALID_UI:
                    if (this._validCallBack != null)
                    {
                        this._validCallBack(this.btn_checkbox.selected);
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

