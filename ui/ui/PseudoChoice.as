package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2components.Input;
    import d2components.Label;
    import d2components.ButtonContainer;
    import d2hooks.NicknameRefused;
    import d2hooks.NicknameAccepted;
    import d2actions.NicknameChoiceRequest;
    import d2actions.ResetGame;
    import d2hooks.*;
    import d2actions.*;

    public class PseudoChoice 
    {

        public var output:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        private var validatedPseudo:Boolean = false;
        private var connecting:Boolean = false;
        public var input_pseudo:Input;
        public var lbl_result:Label;
        public var btn_close:ButtonContainer;
        public var btn_undo:ButtonContainer;
        public var btn_validate:ButtonContainer;


        public function main(... args):void
        {
            this.sysApi.addHook(NicknameRefused, this.onNicknameRefused);
            this.sysApi.addHook(NicknameAccepted, this.onNicknameAccepted);
        }

        public function unload():void
        {
            var login:Object;
            if (!(this.connecting))
            {
                login = this.uiApi.getUi("login");
                if (((login) && (!((login["disableUi"] == null)))))
                {
                    login.disableUi(false);
                };
            };
        }

        public function onNicknameAccepted():void
        {
            this.uiApi.unloadUi(this.uiApi.me().name);
        }

        public function onNicknameRefused(reason:uint):void
        {
            this.connecting = false;
            switch (reason)
            {
                case this.sysApi.getEnum("com.ankamagames.dofus.network.enums.NicknameErrorEnum").ALREADY_USED:
                    this.lbl_result.text = this.uiApi.getText("ui.nickname.alreadyUsed");
                    break;
                case this.sysApi.getEnum("com.ankamagames.dofus.network.enums.NicknameErrorEnum").SAME_AS_LOGIN:
                    this.lbl_result.text = this.uiApi.getText("ui.nickname.equalsLogin");
                    break;
                case this.sysApi.getEnum("com.ankamagames.dofus.network.enums.NicknameErrorEnum").TOO_SIMILAR_TO_LOGIN:
                    this.lbl_result.text = this.uiApi.getText("ui.nickname.similarToLogin");
                    break;
                case this.sysApi.getEnum("com.ankamagames.dofus.network.enums.NicknameErrorEnum").INVALID_NICK:
                    this.lbl_result.text = this.uiApi.getText("ui.nickname.invalid");
                    break;
                case this.sysApi.getEnum("com.ankamagames.dofus.network.enums.NicknameErrorEnum").UNKNOWN_NICK_ERROR:
                    this.lbl_result.text = this.uiApi.getText("ui.nickname.unknown");
                    break;
                default:
                    this.sysApi.log(8, "Pseudo refusé pour une raison non traitée");
            };
            this.btn_validate.disabled = false;
            this.btn_undo.disabled = false;
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_validate:
                    this.connecting = true;
                    this.sysApi.sendAction(new NicknameChoiceRequest(this.input_pseudo.text));
                    this.btn_validate.disabled = true;
                    this.btn_undo.disabled = true;
                    this.lbl_result.text = this.uiApi.getText("ui.common.waiting");
                    break;
                case this.btn_close:
                case this.btn_undo:
                    this.sysApi.sendAction(new ResetGame());
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
            };
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "validUi":
                    if (!(this.validatedPseudo))
                    {
                        this.sysApi.sendAction(new NicknameChoiceRequest(this.input_pseudo.text));
                        return (true);
                    };
                    break;
            };
            return (true);
        }


    }
}//package ui

