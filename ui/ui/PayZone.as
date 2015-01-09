package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2components.GraphicContainer;
    import d2components.ButtonContainer;
    import d2components.Texture;
    import d2components.Label;
    import d2hooks.NonSubscriberPopup;
    import d2hooks.SubscriptionZone;
    import d2hooks.GuestLimitationPopup;
    import d2hooks.GuestMode;
    import d2hooks.*;
    import d2actions.*;

    public class PayZone 
    {

        public static const PAY_ZONE_MODE:int = 0;
        public static const GUEST_MODE:int = 1;

        public var output:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        private var _mode:int;
        private var _link:String;
        public var ctr_popup:GraphicContainer;
        public var btn_topLeft:ButtonContainer;
        public var btn_link:ButtonContainer;
        public var btn_close:ButtonContainer;
        public var bgTexturebtn_topLeft:Texture;
        public var lbl_title:Label;
        public var lbl_description:Label;
        public var btn_lbl_btn_link:Label;


        public function main(args:Array):void
        {
            this.sysApi.addHook(NonSubscriberPopup, this.onNonSubscriberPopup);
            this.sysApi.addHook(SubscriptionZone, this.onSubscriptionZone);
            this.sysApi.addHook(GuestLimitationPopup, this.onGuestLimitationPopup);
            this.sysApi.addHook(GuestMode, this.onGuestMode);
            this._mode = args[0];
            if (this._mode == PAY_ZONE_MODE)
            {
                this.bgTexturebtn_topLeft.uri = this.uiApi.createUri(this.uiApi.me().getConstant("uri_payzone"));
                this.lbl_title.text = this.uiApi.getText("ui.payzone.title");
                this.lbl_description.text = this.uiApi.getText("ui.payzone.description");
                this.btn_lbl_btn_link.text = this.uiApi.getText("ui.payzone.btn");
                this._link = this.uiApi.getText("ui.link.members");
            }
            else
            {
                if (this._mode == GUEST_MODE)
                {
                    this.bgTexturebtn_topLeft.uri = this.uiApi.createUri(this.uiApi.me().getConstant("uri_guest"));
                    this.lbl_title.text = this.uiApi.getText("ui.guest.guestMode");
                    this.lbl_description.text = this.uiApi.getText("ui.guest.description");
                    this.btn_lbl_btn_link.text = this.uiApi.getText("ui.guest.register");
                };
            };
            if (args.length > 1)
            {
                this.showPopup(args[1]);
                this.btn_topLeft.visible = !(args[1]);
            };
        }

        public function unload():void
        {
        }

        private function showPopup(show:Boolean):void
        {
            this.ctr_popup.visible = show;
            this.uiApi.me().render();
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_close:
                    this.ctr_popup.visible = false;
                    break;
                case this.btn_link:
                    if (this._mode == GUEST_MODE)
                    {
                        this.sysApi.convertGuestAccount();
                    }
                    else
                    {
                        this.sysApi.goToUrl(this._link);
                    };
                    this.ctr_popup.visible = false;
                    break;
                case this.btn_topLeft:
                    this.ctr_popup.visible = true;
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
        }

        public function onRollOut(target:Object):void
        {
        }

        public function onGuestLimitationPopup():void
        {
            this.ctr_popup.visible = true;
        }

        private function onGuestMode(active:Boolean):void
        {
            if (active)
            {
                this.btn_topLeft.visible = true;
                this.ctr_popup.visible = true;
            }
            else
            {
                if (this.uiApi)
                {
                    this.uiApi.unloadUi(this.uiApi.me().name);
                };
            };
        }

        public function onNonSubscriberPopup():void
        {
            this.ctr_popup.visible = true;
        }

        private function onSubscriptionZone(active:Boolean):void
        {
            if (active)
            {
                this.btn_topLeft.visible = true;
                this.ctr_popup.visible = true;
            }
            else
            {
                if (this.uiApi)
                {
                    this.uiApi.unloadUi(this.uiApi.me().name);
                };
            };
        }


    }
}//package ui

